"""Build the bundled full texts (spec §4.3) from public-domain sources.

Downloads raw sources into scripts/downloads/ (gitignored, reused if present) and writes
DutifulDailyDevotional/Resources/Texts/<dir>/<work>.json. Run on a dev machine, never in the app:

    python -I scripts/build_texts.py            # all sources
    python -I scripts/build_texts.py web stoics # some of them
    python -I scripts/check_texts.py            # then verify every devotional reference
"""
import html
import json
import re
import sys
import time
import urllib.error
import urllib.parse
import urllib.request
import zipfile
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
DOWNLOADS = ROOT / "scripts" / "downloads"
TEXTS = ROOT / "DutifulDailyDevotional" / "Resources" / "Texts"
USER_AGENT = "dutiful-devotional-text-builder/1.0 (offline build script)"


def fetch(url, dest):
    """Download url to dest once; later runs reuse the file."""
    dest = Path(dest)
    if dest.exists() and dest.stat().st_size > 0:
        return dest
    dest.parent.mkdir(parents=True, exist_ok=True)
    print("  downloading", url)
    request = urllib.request.Request(url, headers={"User-Agent": USER_AGENT})
    for attempt in range(6):
        try:
            with urllib.request.urlopen(request, timeout=60) as response:
                data = response.read()
            break
        except urllib.error.HTTPError as error:  # Wikisource answers 429 when fetched quickly
            if error.code not in (429, 503) or attempt == 5:
                raise
            wait = int(error.headers.get("Retry-After") or 0) or 10 * (attempt + 1)
            print(f"  HTTP {error.code}, retrying in {wait}s")
            time.sleep(wait)
    dest.write_bytes(data)
    time.sleep(1)  # be polite to Sefaria / Wikisource
    return dest


def clean(text):
    """Collapse whitespace inside a paragraph and drop zero-width characters."""
    text = text.replace("​", "").replace("﻿", "").replace("­", "")
    return re.sub(r"\s+", " ", text).strip()


def write_work(directory, work, divisions):
    """divisions: {division number: {verse number: text}}."""
    out = TEXTS / directory / f"{work}.json"
    out.parent.mkdir(parents=True, exist_ok=True)
    body = {
        "work": work,
        "divisions": [
            {"number": d, "verses": [{"number": v, "text": t} for v, t in sorted(verses.items()) if t]}
            for d, verses in sorted(divisions.items())
        ],
    }
    out.write_text(json.dumps(body, ensure_ascii=False, indent=1) + "\n", encoding="utf-8")


# --- World English Bible (eBible.org eng-web, VPL) -------------------------------------------

WEB_BOOKS = {  # BibleWorks codes used by eng-web_vpl.txt -> file name used in references
    "GEN": "Genesis", "EXO": "Exodus", "LEV": "Leviticus", "NUM": "Numbers", "DEU": "Deuteronomy",
    "JOS": "Joshua", "JDG": "Judges", "RUT": "Ruth", "1SA": "1 Samuel", "2SA": "2 Samuel",
    "1KI": "1 Kings", "2KI": "2 Kings", "1CH": "1 Chronicles", "2CH": "2 Chronicles", "EZR": "Ezra",
    "NEH": "Nehemiah", "EST": "Esther", "JOB": "Job", "PSA": "Psalms", "PRO": "Proverbs",
    "ECC": "Ecclesiastes", "SOL": "Song of Solomon", "ISA": "Isaiah", "JER": "Jeremiah",
    "LAM": "Lamentations", "EZE": "Ezekiel", "DAN": "Daniel", "HOS": "Hosea", "JOE": "Joel",
    "AMO": "Amos", "OBA": "Obadiah", "JON": "Jonah", "MIC": "Micah", "NAH": "Nahum",
    "HAB": "Habakkuk", "ZEP": "Zephaniah", "HAG": "Haggai", "ZEC": "Zechariah", "MAL": "Malachi",
    "MAT": "Matthew", "MAR": "Mark", "LUK": "Luke", "JOH": "John", "ACT": "Acts", "ROM": "Romans",
    "1CO": "1 Corinthians", "2CO": "2 Corinthians", "GAL": "Galatians", "EPH": "Ephesians",
    "PHI": "Philippians", "COL": "Colossians", "1TH": "1 Thessalonians", "2TH": "2 Thessalonians",
    "1TI": "1 Timothy", "2TI": "2 Timothy", "TIT": "Titus", "PHM": "Philemon", "HEB": "Hebrews",
    "JAM": "James", "1PE": "1 Peter", "2PE": "2 Peter", "1JO": "1 John", "2JO": "2 John",
    "3JO": "3 John", "JUD": "Jude", "REV": "Revelation",
}  # The deuterocanonical books in the archive are skipped.


def build_web():
    archive = fetch("https://ebible.org/Scriptures/eng-web_vpl.zip", DOWNLOADS / "web" / "eng-web_vpl.zip")
    with zipfile.ZipFile(archive) as z:
        lines = z.read("eng-web_vpl.txt").decode("utf-8-sig").splitlines()
    books = {}
    for line in lines:
        match = re.match(r"(\w+) (\d+):(\d+) ?(.*)", line)
        if match and match[1] in WEB_BOOKS:
            books.setdefault(WEB_BOOKS[match[1]], {}).setdefault(int(match[2]), {})[int(match[3])] = clean(match[4])
    assert len(books) == 66, f"expected 66 books, got {len(books)}"
    for work, divisions in books.items():
        write_work("web", work, divisions)
    print(f"web: {len(books)} books")


# --- JPS 1917 (Sefaria) -------------------------------------------------------------------------

JPS_BOOKS = [
    "Genesis", "Exodus", "Leviticus", "Numbers", "Deuteronomy", "Joshua", "Judges", "I Samuel",
    "II Samuel", "I Kings", "II Kings", "Isaiah", "Jeremiah", "Ezekiel", "Hosea", "Joel", "Amos",
    "Obadiah", "Jonah", "Micah", "Nahum", "Habakkuk", "Zephaniah", "Haggai", "Zechariah", "Malachi",
    "Psalms", "Proverbs", "Job", "Song of Songs", "Ruth", "Lamentations", "Ecclesiastes", "Esther",
    "Daniel", "Ezra", "Nehemiah", "I Chronicles", "II Chronicles",
]
JPS_VERSION = "The Holy Scriptures: A New Translation (JPS 1917)"


def strip_sefaria_html(text):
    text = re.sub(r'<sup class="footnote-marker">.*?</sup>', "", text)
    # Footnote bodies are <i class="footnote">…</i> and may contain nested <i>.
    while (start := text.find('<i class="footnote">')) >= 0:
        depth, pos = 0, start
        for tag in re.finditer(r"<(/?)i\b[^>]*>", text[start:]):
            depth += -1 if tag[1] else 1
            if depth == 0:
                pos = start + tag.end()
                break
        text = text[:start] + text[pos:]
    return clean(html.unescape(re.sub(r"<[^>]+>", "", text)))


def build_jps():
    for title in JPS_BOOKS:
        query = urllib.parse.quote(f"english|{JPS_VERSION}")
        raw = fetch(f"https://www.sefaria.org/api/v3/texts/{urllib.parse.quote(title)}?version={query}",
                    DOWNLOADS / "jps1917" / f"{title}.json")
        versions = json.loads(raw.read_text(encoding="utf-8"))["versions"]
        assert versions and versions[0]["versionTitle"] == JPS_VERSION, f"{title}: wrong Sefaria version"
        chapters = versions[0]["text"]
        work = re.sub(r"^II ", "2 ", re.sub(r"^I ", "1 ", title))  # "I Samuel" -> "1 Samuel", like WEB
        write_work("jps1917", work, {c: {v: strip_sefaria_html(t) for v, t in enumerate(verses, 1)}
                                      for c, verses in enumerate(chapters, 1)})
    print(f"jps1917: {len(JPS_BOOKS)} books")


# --- Pickthall (Tanzil, cross-checked against fawazahmed0/quran-api) ----------------------------

def build_pickthall():
    tanzil = fetch("https://tanzil.net/trans/?transID=en.pickthall&type=txt-2",
                   DOWNLOADS / "pickthall" / "tanzil.txt").read_text(encoding="utf-8-sig")
    surahs = {}
    for match in re.finditer(r"^(\d+)\|(\d+)\|(.*)$", tanzil, re.M):
        surahs.setdefault(int(match[1]), {})[int(match[2])] = clean(match[3])
    assert len(surahs) == 114 and sum(map(len, surahs.values())) == 6236, "Tanzil Pickthall incomplete"

    other = fetch("https://cdn.jsdelivr.net/gh/fawazahmed0/quran-api@1/editions/eng-mohammedmarmadu.json",
                  DOWNLOADS / "pickthall" / "fawazahmed0.json")
    words = lambda t: re.sub(r"[^a-z0-9]+", " ", t.lower()).strip()
    differing = [f"{v['chapter']}:{v['verse']}"
                 for v in json.loads(other.read_text(encoding="utf-8"))["quran"]
                 if words(v["text"]) != words(surahs[v["chapter"]].get(v["verse"], ""))]
    # Punctuation is ignored; any wording difference is listed so a reviewer can check it.
    print(f"pickthall: cross-check found {len(differing)} verses worded differently", differing[:20])

    for number, verses in surahs.items():
        write_work("pickthall", str(number), {number: verses})
    print("pickthall: 114 surahs")


# --- Stoics -------------------------------------------------------------------------------------

def gutenberg(number, file_name):
    # gutenberg.org often answers 503 to scripts; the pglaf mirror serves the same files.
    path = "/".join(str(number)[:-1]) + f"/{number}/{file_name}"
    raw = fetch(f"https://gutenberg.pglaf.org/{path}", DOWNLOADS / "stoics" / file_name).read_bytes()
    text = raw.decode("utf-8-sig") if file_name.endswith("-0.txt") else raw.decode("latin-1")
    text = text.replace("\r\n", "\n")
    start = re.search(r"^\*\*\* ?START OF.*$", text, re.M).end()
    end = re.search(r"^\*\*\* ?END OF", text, re.M).start()
    return text[start:end]


def paragraphs(block):
    return [p for p in re.split(r"\n\s*\n", block) if p.strip()]


def build_meditations():
    body = gutenberg(15877, "15877-8.txt")
    body = body[:re.search(r"^\s*INDEXES\.\s*$", body, re.M).start()]
    heads = list(re.finditer(r"^([IVX]+)\.\s*$", body, re.M))
    assert len(heads) == 12, f"expected 12 books, got {len(heads)}"
    books = {}
    for number, (head, nxt) in enumerate(zip(heads, heads[1:] + [None]), 1):
        sections, current = {}, 1  # the first section of each book is not numbered in Long's text
        in_note = False
        for para in paragraphs(body[head.end(): nxt.start() if nxt else len(body)]):
            # Footnotes are indented runs opening with "[A]"; other indented blocks are quoted verse.
            indented = para.startswith((" ", "\t"))
            in_note = indented and (in_note or bool(re.match(r"\s+\[[A-Z]\]", para)))
            if in_note:
                continue
            para = re.sub(r"\[[A-Z]\]", "", para)  # footnote markers like "Verus[A]"
            match = re.match(r"(\d+)\. ", para)
            if match and int(match[1]) == current + 1 and current in sections:
                current, para = current + 1, para[match.end():]
            sections[current] = (sections.get(current, "") + "\n\n" + clean(para)).strip()
        books[number] = sections
    write_work("stoics", "Meditations", books)
    print("stoics: Meditations,", sum(map(len, books.values())), "sections")


def build_enchiridion():
    body = gutenberg(10661, "10661-0.txt")
    body = body[re.search(r"^THE ENCHEIRIDION, OR MANUAL\.\s*$", body, re.M).end():]
    heads = list(re.finditer(r"^([IVXL]+)\.\s*$", body, re.M))
    chapters = {}
    for number, (head, nxt) in enumerate(zip(heads, heads[1:] + [None]), 1):
        text = body[head.end(): nxt.start() if nxt else len(body)]
        chapters[number] = {1: "\n\n".join(clean(p) for p in paragraphs(text))}  # one verse per chapter
    assert len(chapters) == 52, f"expected 52 chapters, got {len(chapters)}"
    write_work("stoics", "Enchiridion", chapters)
    print("stoics: Enchiridion, 52 chapters")


def build_letters():
    letters = {}
    for number in range(1, 125):
        page = f"Moral letters to Lucilius/Letter {number}"
        url = ("https://en.wikisource.org/w/api.php?action=parse&prop=text&format=json&formatversion=2&page="
               + urllib.parse.quote(page))
        raw = fetch(url, DOWNLOADS / "stoics" / "letters" / f"{number:03}.json")
        text = json.loads(raw.read_text(encoding="utf-8"))["parse"]["text"]
        text = text.split('<div class="reflist"')[0]  # drop the footnote list
        text = re.sub(r"<style.*?</style>", "", text, flags=re.S)
        text = re.sub(r'<sup[^>]*class="reference".*?</sup>', "", text, flags=re.S)  # footnote markers
        text = re.sub(r"</p>\s*<p>", "\n\n", text)
        parts = re.split(r'<span class="wst-verse[^"]*" id="(\d+)\.">.*?</span>', text)
        verses = {}
        for marker, chunk in zip(parts[1::2], parts[2::2]):
            chunk = html.unescape(re.sub(r"<[^>]+>", "", chunk))
            verses[int(marker)] = "\n\n".join(clean(p) for p in chunk.split("\n\n") if clean(p))
        assert list(verses) == list(range(1, len(verses) + 1)), f"Letter {number}: sections out of order"
        letters[number] = verses
    write_work("stoics", "Letters", letters)
    print("stoics: Letters, 124 letters")


def build_stoics():
    build_meditations()
    build_enchiridion()
    build_letters()


BUILDERS = {"web": build_web, "jps1917": build_jps, "pickthall": build_pickthall, "stoics": build_stoics}

if __name__ == "__main__":
    for name in sys.argv[1:] or BUILDERS:
        BUILDERS[name]()
