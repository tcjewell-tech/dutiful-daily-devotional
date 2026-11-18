"""Self-test for build_texts.py: every devotional reference must resolve in the converted texts,
and its passageText must match them (whitespace-normalized), as ContentIntegrityTests does in the app.

    python -I scripts/check_texts.py
"""
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
TEXTS = ROOT / "DutifulDailyDevotional" / "Resources" / "Texts"
DIRECTORY = {"christian": "web", "jewish": "jps1917", "muslim": "pickthall", "humanist": "stoics"}


def parse(reference, tradition):
    """Mirror of SourceReference.parse: (work, division, first verse, last verse or None for whole)."""
    patterns = {
        "christian": r"(.+?) (\d+):(\d+)(?:-(\d+))?",
        "jewish": r"(.+?) (\d+):(\d+)(?:-(\d+))?",
        "muslim": r"Qur['’]an() (\d+):(\d+)(?:-(\d+))?",
        "humanist": r"(Meditations|Seneca, Letters|Enchiridion) (\d+)(?:\.(\d+)(?:-(\d+))?)?",
    }
    match = re.fullmatch(patterns[tradition], reference.strip())
    if not match:
        return None
    work, division, first, last = match.groups()
    work = {"": division, "Seneca, Letters": "Letters"}.get(work, work)
    if work == "Enchiridion":
        return (work, int(division), None, None) if first is None else None
    if first is None:
        return None
    return work, int(division), int(first), int(last or first)


def passage(work, division, first, last, directory):
    path = TEXTS / directory / f"{work}.json"
    if not path.exists():
        return None
    data = json.loads(path.read_text(encoding="utf-8"))
    verses = next((d["verses"] for d in data["divisions"] if d["number"] == division), [])
    chosen = [v["text"] for v in verses if first is None or first <= v["number"] <= last]
    if not chosen or (first is not None and len(chosen) != last - first + 1):
        return None
    return " ".join(chosen)


def normalized(text):
    return " ".join(text.split())


def main():
    failures, checked = [], 0
    for path in sorted((ROOT / "Shared" / "Resources" / "Devotionals").glob("*.json")):
        data = json.loads(path.read_text(encoding="utf-8"))
        tradition = data["tradition"]
        for entry in data["entries"]:
            checked += 1
            label = f"{tradition}-{entry['day']} {entry['reference']}"
            ref = parse(entry["reference"], tradition)
            full = ref and passage(*ref, DIRECTORY[tradition])
            if full is None:
                failures.append(f"{label}: reference does not resolve")
            elif normalized(full) != normalized(entry["passageText"]):
                failures.append(f"{label}:\n  devotional: {normalized(entry['passageText'])}\n  full text:  {normalized(full)}")
    for failure in failures:
        print("FAIL", failure)
    print(f"{checked - len(failures)}/{checked} passages match the converted texts")
    return 1 if failures or not checked else 0


if __name__ == "__main__":
    assert parse("1 John 4:19", "christian") == ("1 John", 4, 19, 19)
    assert parse("Qur’an 94:5-6", "muslim") == ("94", 94, 5, 6)
    assert parse("Seneca, Letters 13.4", "humanist") == ("Letters", 13, 4, 4)
    assert parse("Enchiridion 8", "humanist") == ("Enchiridion", 8, None, None)
    assert parse("Meditations 4", "humanist") is None
    sys.exit(main())
