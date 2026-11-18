# Content Review

Every entry is **DRAFT** until a qualified reviewer from its tradition signs it off below (spec sections 1 and 11). Nothing ships to the App Store with a draft entry.

- **Passages** (`passageText`) were copied by script from the source named below, not typed. Reviewers should still confirm each one against a printed or authoritative copy.
- **Reflections and study prompts** were drafted by AI (Claude) and need the most attention: accuracy, tone, and whether a member of the tradition would find them fitting.

## Sources

| Tradition | Text | Where the wording was taken from |
|---|---|---|
| Christian | World English Bible (Classic WEB, uses "Yahweh"), public domain | eBible.org `eng-web` chapter pages |
| Jewish | JPS 1917 Tanakh, public domain; Hebrew verse numbering | Sefaria, version "The Holy Scriptures: A New Translation (JPS 1917)" |
| Muslim | Pickthall, *The Meaning of the Glorious Koran* (1930) | quran.com translation resource 19 (M. Pickthall) |
| Humanist | Marcus Aurelius, *Meditations*, tr. George Long; Epictetus, *Enchiridion*, tr. George Long; Seneca, *Moral Letters*, tr. R. M. Gummere | Project Gutenberg #15877 and #10661; Wikisource "Moral letters to Lucilius" |

Days 1–45 were fetched from the sites above. Days 46–90 were read by script from the bundled full texts in `DutifulDailyDevotional/Resources/Texts/`, which `scripts/build_texts.py` builds from the same sources. `python -I scripts/check_texts.py` confirms every passage matches the bundled text (360/360).

## Days 1–90 (all draft)

| Day | Theme | Christian | Jewish | Muslim | Humanist |
|---|---|---|---|---|---|
| 1 | Peace | John 14:27 | Numbers 6:24-26 | Qur'an 13:28 | Enchiridion 8 |
| 2 | Courage | 2 Timothy 1:7 | Joshua 1:9 | Qur'an 20:46 | Meditations 7.61 |
| 3 | Fear | Philippians 4:6-7 | Psalms 27:1 | Qur'an 65:3 | Seneca, Letters 13.4 |
| 4 | Rest | Matthew 11:28-30 | Exodus 33:14 | Qur'an 78:9-11 | Meditations 2.7 |
| 5 | Gratitude | 1 Thessalonians 5:16-18 | Psalms 92:2-3 | Qur'an 2:152 | Meditations 6.48 |
| 6 | Hope | Romans 15:13 | Lamentations 3:22-23 | Qur'an 94:5-6 | Meditations 7.8 |
| 7 | Endurance | 2 Corinthians 4:8-9 | Isaiah 40:31 | Qur'an 2:153 | Meditations 5.18 |
| 8 | Forgiveness | Colossians 3:13 | Leviticus 19:18 | Qur'an 42:43 | Meditations 7.26 |
| 9 | Integrity | Philippians 4:8 | Micah 6:8 | Qur'an 4:135 | Meditations 10.16 |
| 10 | Loneliness | Romans 8:38-39 | Psalms 139:9-10 | Qur'an 2:186 | Seneca, Letters 40.1 |
| 11 | Grief | Matthew 5:4 | Psalms 34:19 | Qur'an 2:155-156 | Seneca, Letters 63.4 |
| 12 | Duty | Colossians 3:23-24 | Ecclesiastes 9:10 | Qur'an 4:58 | Enchiridion 17 |
| 13 | Separation from family | Philippians 1:3-4 | Genesis 31:49 | Qur'an 12:86 | Seneca, Letters 55.9 |
| 14 | Humility | Philippians 2:3-4 | Proverbs 11:2 | Qur'an 25:63 | Meditations 8.33 |
| 15 | Patience | Romans 12:12 | Psalms 27:14 | Qur'an 103:1-3 | Enchiridion 10 |
| 16 | Kindness | Ephesians 4:32 | Proverbs 3:3 | Qur'an 2:263 | Meditations 10.4 |
| 17 | Purpose | Ephesians 2:10 | Jeremiah 29:11 | Qur'an 67:2 | Meditations 8.19 |
| 18 | Homecoming | Luke 15:20 | Psalms 126:5-6 | Qur'an 28:85 | Meditations 6.11 |
| 19 | Anger | Ephesians 4:26 | Ecclesiastes 7:9 | Qur'an 3:134 | Enchiridion 20 |
| 20 | Trust | John 14:1 | Proverbs 3:5-6 | Qur'an 33:3 | Seneca, Letters 3.2 |
| 21 | Comradeship | John 15:13 | Ecclesiastes 4:9-10 | Qur'an 49:10 | Meditations 6.39 |
| 22 | Self-control | Galatians 5:22-23 | Proverbs 16:32 | Qur'an 79:40-41 | Meditations 8.48 |
| 23 | Contentment | Philippians 4:12-13 | Ecclesiastes 4:6 | Qur'an 20:131 | Meditations 4.31 |
| 24 | Mercy | Luke 6:36 | Hosea 6:6 | Qur'an 39:53 | Meditations 9.11 |
| 25 | Honesty | Ephesians 4:25 | Zechariah 8:16 | Qur'an 33:70-71 | Meditations 6.21 |
| 26 | Uncertainty | Matthew 6:34 | Psalms 121:1-2 | Qur'an 6:59 | Meditations 8.36 |
| 27 | Generosity | 2 Corinthians 9:7 | Deuteronomy 15:11 | Qur'an 2:261 | Meditations 7.73 |
| 28 | Leadership | Mark 10:43-44 | Psalms 78:72 | Qur'an 3:159 | Seneca, Letters 47.11 |
| 29 | Service | 1 Peter 4:10 | Isaiah 6:8 | Qur'an 76:8-9 | Meditations 11.4 |
| 30 | Wisdom | James 1:5 | Job 28:28 | Qur'an 2:269 | Meditations 12.22 |
| 31 | Justice | Matthew 5:6 | Amos 5:24 | Qur'an 5:8 | Meditations 9.5 |
| 32 | Mortality | 2 Corinthians 4:16 | Psalms 90:12 | Qur'an 3:185 | Meditations 4.17 |
| 33 | Renewal | Romans 12:2 | Isaiah 43:19 | Qur'an 57:17 | Seneca, Letters 6.1 |
| 34 | Stillness | Mark 1:35 | Psalms 46:11 | Qur'an 7:205 | Meditations 4.24 |
| 35 | Steadfastness | 1 Corinthians 15:58 | Psalms 112:7 | Qur'an 41:30 | Meditations 7.45 |
| 36 | Compassion | Colossians 3:12 | Isaiah 58:7 | Qur'an 93:9-10 | Meditations 7.22 |
| 37 | Reflection | Psalms 139:23-24 | Lamentations 3:40 | Qur'an 59:18 | Meditations 7.59 |
| 38 | Joy | John 15:11 | Psalms 30:6 | Qur'an 10:58 | Seneca, Letters 23.3 |
| 39 | Responsibility | Luke 16:10 | Proverbs 3:27 | Qur'an 74:38 | Enchiridion 5 |
| 40 | Change | Hebrews 13:8 | Ecclesiastes 3:1 | Qur'an 55:26-27 | Meditations 7.18 |
| 41 | Asking for help | Galatians 6:2 | Exodus 18:18 | Qur'an 20:29-32 | Meditations 7.7 |
| 42 | Loyalty | Proverbs 17:17 | Ruth 1:16 | Qur'an 23:8 | Seneca, Letters 9.10 |
| 43 | Discipline | Hebrews 12:11 | Proverbs 12:1 | Qur'an 2:183 | Seneca, Letters 18.6 |
| 44 | Listening | James 1:19 | 1 Samuel 3:10 | Qur'an 39:18 | Meditations 6.53 |
| 45 | Gentleness | Philippians 4:5 | Proverbs 15:1 | Qur'an 41:34 | Meditations 7.63 |
| 46 | Strength | 2 Corinthians 12:9 | Isaiah 40:29 | Qur'an 30:54 | Seneca, Letters 13.3 |
| 47 | Friendship | Proverbs 27:17 | Proverbs 18:24 | Qur'an 9:71 | Seneca, Letters 3.3 |
| 48 | Waiting | Romans 8:25 | Psalms 130:5-6 | Qur'an 12:83 | Seneca, Letters 13.10 |
| 49 | Words | Ephesians 4:29 | Proverbs 16:24 | Qur'an 14:24-25 | Meditations 8.30 |
| 50 | Weariness | Galatians 6:9 | Jeremiah 31:25 | Qur'an 23:62 | Meditations 7.74 |
| 51 | Second chances | 1 John 1:9 | Psalms 103:12 | Qur'an 11:114 | Meditations 7.2 |
| 52 | Simplicity | Luke 10:41-42 | Psalms 131:1-2 | Qur'an 25:67 | Meditations 1.3 |
| 53 | Hard work | Proverbs 14:23 | Proverbs 6:6 | Qur'an 53:39-40 | Seneca, Letters 76.6 |
| 54 | Respect | 1 Peter 2:17 | Leviticus 19:32 | Qur'an 49:11 | Meditations 8.59 |
| 55 | Morning | Psalms 5:3 | Psalms 143:8 | Qur'an 93:1-3 | Meditations 11.27 |
| 56 | Evening | Psalms 4:8 | Psalms 3:6 | Qur'an 25:47 | Seneca, Letters 83.2 |
| 57 | Healing | Psalms 147:3 | Jeremiah 17:14 | Qur'an 26:78-80 | Seneca, Letters 50.9 |
| 58 | Guilt | Romans 8:1 | Psalms 32:5 | Qur'an 3:135 | Meditations 9.4 |
| 59 | Encouragement | 1 Thessalonians 5:11 | Psalms 31:25 | Qur'an 90:17 | Seneca, Letters 34.2 |
| 60 | Unity | Ephesians 4:2-3 | Psalms 133:1 | Qur'an 3:103 | Seneca, Letters 95.52 |
| 61 | Peacemaking | Matthew 5:9 | Psalms 34:15 | Qur'an 4:114 | Enchiridion 43 |
| 62 | Hospitality | Hebrews 13:2 | Deuteronomy 10:19 | Qur'an 51:24-27 | Seneca, Letters 95.51 |
| 63 | Family | John 19:26-27 | Exodus 20:12 | Qur'an 17:24 | Meditations 1.1-2 |
| 64 | Love | 1 Corinthians 13:4-7 | Song of Songs 8:7 | Qur'an 30:21 | Seneca, Letters 9.6 |
| 65 | Envy | Galatians 5:26 | Proverbs 14:30 | Qur'an 4:32 | Seneca, Letters 15.10 |
| 66 | Worry | Matthew 6:27 | Psalms 94:19 | Qur'an 9:51 | Seneca, Letters 5.9 |
| 67 | Hardship | John 16:33 | Isaiah 43:2 | Qur'an 29:2 | Meditations 10.3 |
| 68 | Temptation | 1 Corinthians 10:13 | Genesis 4:7 | Qur'an 12:53 | Seneca, Letters 51.5 |
| 69 | Freedom | Galatians 5:13 | Leviticus 25:10 | Qur'an 2:256 | Seneca, Letters 37.3 |
| 70 | Honor | Romans 12:10 | Proverbs 22:1 | Qur'an 17:70 | Seneca, Letters 43.5 |
| 71 | Keeping promises | Matthew 5:37 | Numbers 30:3 | Qur'an 16:91 | Seneca, Letters 75.4 |
| 72 | Good deeds | Matthew 5:16 | Isaiah 1:17 | Qur'an 16:97 | Meditations 8.26 |
| 73 | Selflessness | Romans 15:1-2 | Isaiah 58:10 | Qur'an 3:92 | Meditations 6.7 |
| 74 | Faithfulness | Matthew 25:21 | Psalms 36:6 | Qur'an 3:17 | Seneca, Letters 71.35 |
| 75 | Character | Romans 5:3-4 | Proverbs 20:11 | Qur'an 91:7-10 | Meditations 7.15 |
| 76 | Time | Ephesians 5:15-16 | Psalms 118:24 | Qur'an 25:62 | Seneca, Letters 1.3 |
| 77 | Learning | Proverbs 9:9 | Proverbs 4:13 | Qur'an 96:1-5 | Seneca, Letters 76.3 |
| 78 | Creation | Psalms 19:1 | Psalms 8:4-5 | Qur'an 3:190 | Meditations 4.23 |
| 79 | Light in darkness | John 1:5 | Micah 7:8 | Qur'an 24:35 | Meditations 12.15 |
| 80 | Burdens | 1 Peter 5:7 | Psalms 68:20 | Qur'an 94:1-3 | Seneca, Letters 28.2 |
| 81 | Perspective | 2 Corinthians 4:17-18 | Isaiah 55:8-9 | Qur'an 57:22-23 | Meditations 7.48 |
| 82 | Small things | Matthew 10:42 | 1 Kings 19:12 | Qur'an 99:7-8 | Seneca, Letters 2.4 |
| 83 | Belonging | Ephesians 2:19 | Psalms 68:7 | Qur'an 49:13 | Seneca, Letters 28.4 |
| 84 | Moral courage | 1 Corinthians 16:13-14 | Esther 4:14 | Qur'an 31:17 | Seneca, Letters 7.6 |
| 85 | Neighbors | Luke 10:36-37 | Proverbs 27:10 | Qur'an 4:36 | Seneca, Letters 48.2 |
| 86 | Health | 3 John 1:2 | Proverbs 17:22 | Qur'an 7:31 | Seneca, Letters 15.5 |
| 87 | Money | Hebrews 13:5 | Proverbs 30:8-9 | Qur'an 18:46 | Seneca, Letters 2.6 |
| 88 | Remembrance | Hebrews 13:7 | Psalms 112:6 | Qur'an 59:10 | Seneca, Letters 63.7 |
| 89 | Mentoring | 2 Timothy 2:2 | Numbers 27:18-20 | Qur'an 18:66 | Seneca, Letters 7.8 |
| 90 | The road ahead | Philippians 3:13-14 | Psalms 121:8 | Qur'an 94:7-8 | Seneca, Letters 4.1 |

## Points for reviewers

- **Jewish, Joshua 1:9:** the JPS text ends with a closing quotation mark (’) because God's speech starts at verse 2. Kept as printed; decide whether to keep or pick a different passage.
- **Jewish, Psalms 27:1:** JPS prints "[A Psalm] of David." as part of verse 1 (Hebrew numbering). Kept as printed.
- **Jewish, Psalms 92:2-3** and **Christian, 2 Corinthians 4:8-9** end mid-sentence (comma / semicolon) because the sentence continues in the next verse.
- **Muslim, Qur'an 42:43:** the digital text uses a plain hyphen ("forgiveth - lo!"); the 1930 printing likely uses a dash. Check against a printed copy.
- **Muslim:** the Pickthall wording came from one digital source only; check every verse against a second source or the 1930 edition.
- **Humanist:** footnote markers in Long's translation were removed; the passage words are unchanged. "Humanist" content is Stoic philosophy, per the spec. A humanist chaplain or celebrant should confirm this framing suits non-religious service members.
- **Day 13, Jewish, Genesis 31:49:** starts mid-sentence ("and Mizpah, for he said:") and the JPS quotation mark stays open because Laban's speech continues into verse 50. In context this is a wary covenant between Jacob and Laban; the reflection uses it as a blessing over people who are apart. Decide whether that reading is fitting.
- **Endings mid-sentence (days 11–45):** Christian Philippians 1:3-4, Romans 12:12, Ephesians 4:26, Colossians 3:12, James 1:19; Jewish Proverbs 3:3, Zechariah 8:16, Ecclesiastes 3:1, Ruth 1:16; Muslim Qur'an 25:63, 67:2, 3:134, 76:8-9, 93:9-10, 74:38, 20:29-32, 23:8, 2:183. Kept as printed.
- **Jewish, 1 Samuel 3:10:** the reference uses "1 Samuel" (as the Christian file uses "1 Peter"); Sefaria calls the book "I Samuel". The full-text converter must use the same file name for the Study view to find it.
- **Jewish, Psalms 46:11 and 121:1-2:** Hebrew numbering (English 46:10). Psalms 121:1 includes "A Song of Ascents." as printed.
- **Muslim, Qur'an 28:85:** the reflection says many commentators read this as a promise that the Prophet would return to Mecca. Confirm that wording.
- **Muslim, Qur'an 2:261:** "spend ... in Allah's way" is read in the reflection as charity. Confirm that reading suits the context.
- **Humanist, Seneca, Letters 47.11 (day 28, Leadership):** Seneca is writing about how slaves are treated. The reflection names this and applies the principle to people under your authority. A reviewer should decide whether this passage is suitable at all.
- **Humanist, Meditations 7.7 (day 41) and 7.45 (day 35):** both use military images (an assault on a town; staying at the post a commander gave you, even at risk of death). Check they read well for serving members, especially anyone who has lost comrades.
- **Humanist, length:** Seneca, Letters 3.2 (798 characters), Meditations 4.24 (732), Seneca, Letters 18.6 (671) and 23.3 (651) are longer than the rest and will be truncated in the medium widget. Shorter sections were not available for those themes without footnote markers or cross-references.
- **Day 41 theme "Asking for help":** chosen to encourage reaching out. Check every tradition's reflection supports getting help and does not read as a substitute for it.
- **Endings mid-sentence (days 46–90):** Christian Romans 12:10, Romans 5:3-4, Ephesians 2:19; Jewish Proverbs 6:6, Isaiah 58:10; Muslim Qur'an 25:67, 93:1-3, 26:78-80, 3:103, 3:190, 94:1-3, 57:22-23, 4:36; Humanist Seneca, Letters 95.51. Starting mid-sentence (lowercase): Christian Ephesians 4:2-3, 1 Peter 5:7; Jewish 1 Kings 19:12; Humanist Seneca, Letters 95.52. Kept as printed.
- **Closing quotation marks without an opening one:** Jewish Genesis 4:7 and Esther 4:14 end with ’ because the speech starts in an earlier verse; Numbers 27:18-20 opens a quote that continues past verse 20; Christian Matthew 6:27 opens a quote that continues. Kept as printed.
- **Psalm headings:** Christian Psalms 19:1 includes "For the Chief Musician. A Psalm by David."; Jewish Psalms 131:1-2 and 133:1 include "A Song of Ascents; of David." Kept as printed. Jewish Psalms references use Hebrew numbering (3:6, 8:4-5, 31:25, 34:15, 36:6, 68:7, 68:20 are English 3:5, 8:3-4, 31:24, 34:14, 36:5, 68:6, 68:19).
- **Jewish, Micah 7:8** addresses "O mine enemy". The reflection reads it as rising after a fall. Check that it reads well out of context.
- **Muslim, Qur'an 49:11:** the digital Pickthall reads "not let women (deride) women", likely a typo for "nor". Check against a printed copy.
- **Muslim, Qur'an 4:36 (day 85, Neighbors)** includes "(the slaves) whom your right hands possess". Decide whether the passage is suitable.
- **Muslim, Qur'an 93:1-3:** the reflection says many commentators link this surah to a pause in revelation. **Qur'an 12:53:** the reflection notes that commentators differ on who speaks. **Qur'an 96:1-5** is described as the first revealed words. Confirm each.
- **Muslim, Qur'an 12:83 and 18:66** include Pickthall's bracketed additions such as "(O Muhammad)" and "(And when they came unto their father...)". Kept as printed.
- **Jewish, day 56 and 57 reflections** mention the bedtime Shema and the Amidah's blessing for healing; **day 61** cites the sages' praise of Aaron as a lover and pursuer of peace (Pirkei Avot 1:12). Confirm the wording.
- **Humanist, Seneca letters about ending one's life:** letters 24, 70, 77 and 78 discuss suicide, so no passage was taken from them; the Study view shows the whole letter. Seneca, Letters 4 (day 90) has a later section on departing from life contentedly; check it is acceptable in context.
- **Humanist, Seneca, Letters 95.51 (day 62)** ends with a colon and 95.52 (day 60) starts mid-sentence; they are one sentence split across sections.
- **Humanist, Meditations 1.1-2 and 12.15** include Long's bracketed insertions ("[I learned]", "[before thy death]"). Kept as printed.
- **Humanist, length (days 46–90):** ten sections are 500–658 characters (Meditations 10.3 is the longest) and will be truncated in the medium widget.
- **Day 57 (Healing), 66 (Worry) and 86 (Health):** check that every tradition's reflection encourages getting help and does not read as a substitute for it.
- **Themes 3 (Fear) and 10 (Loneliness):** check that reflections encourage people to reach out, and do not read as a substitute for getting help.

## Per-tradition checklist

For each entry the reviewer confirms:

- [ ] The passage text matches the named translation exactly, with the reference and verse numbering correct.
- [ ] The passage is not polemical, does not concern warfare against other faiths, and reads well out of context.
- [ ] The reflection is accurate to the tradition and does not overstate or misattribute.
- [ ] The three study prompts are respectful, open-ended and suitable for someone serving away from home.
- [ ] The theme fits the passage.

## Sign-off

| Tradition | Reviewer (name, role) | Days reviewed | Date | Result |
|---|---|---|---|---|
| Christian | | | | |
| Jewish | | | | |
| Muslim | | | | |
| Humanist | | | | |
