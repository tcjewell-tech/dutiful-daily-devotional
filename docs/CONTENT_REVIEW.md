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

Days 1–45 were fetched from the sites above. Days 46–270 were read by script from the bundled full texts in `DutifulDailyDevotional/Resources/Texts/`, which `scripts/build_texts.py` builds from the same sources. `python -I scripts/check_texts.py` confirms every passage matches the bundled text (1080/1080).

## Days 1–270 (all draft)

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
| 91 | Beginnings | 2 Corinthians 5:17 | Genesis 1:1 | Qur'an 1:1-5 | Enchiridion 22 |
| 92 | Preparation | Luke 14:28 | Proverbs 24:27 | Qur'an 2:197 | Enchiridion 4 |
| 93 | Teamwork | 1 Corinthians 12:26 | Ecclesiastes 4:12 | Qur'an 18:95 | Meditations 7.5 |
| 94 | Doubt | Mark 9:24 | Habakkuk 1:2 | Qur'an 2:260 | Meditations 4.27 |
| 95 | Wonder | Psalms 139:14 | Psalms 104:24 | Qur'an 67:3-4 | Seneca, Letters 41.3 |
| 96 | Vigilance | Mark 14:38 | Proverbs 4:23 | Qur'an 3:200 | Enchiridion 38 |
| 97 | Marriage | Mark 10:8-9 | Ecclesiastes 9:9 | Qur'an 25:74 | Seneca, Letters 104.5 |
| 98 | Failure | John 21:17 | Proverbs 24:16 | Qur'an 20:121-122 | Meditations 12.6 |
| 99 | Laughter | Luke 6:21 | Psalms 126:2 | Qur'an 53:43 | Seneca, Letters 23.5 |
| 100 | Prudence | Matthew 10:16 | Proverbs 22:3 | Qur'an 17:36 | Meditations 12.20 |
| 101 | Homesickness | John 14:2 | Psalms 84:3 | Qur'an 29:56 | Seneca, Letters 55.10 |
| 102 | Obedience | John 14:15 | Deuteronomy 10:12 | Qur'an 24:51 | Meditations 11.29 |
| 103 | Beauty | Matthew 6:28-29 | Ecclesiastes 3:11 | Qur'an 32:7 | Seneca, Letters 115.3 |
| 104 | Shame | Psalms 34:5 | Isaiah 54:4 | Qur'an 4:110 | Enchiridion 28 |
| 105 | Parents | Proverbs 1:8-9 | Proverbs 23:22 | Qur'an 17:23 | Meditations 6.12 |
| 106 | Success | Proverbs 16:3 | Psalms 1:3 | Qur'an 23:1-2 | Enchiridion 6 |
| 107 | Night watch | Psalms 63:6 | Psalms 121:4 | Qur'an 73:6 | Seneca, Letters 11.8 |
| 108 | Sincerity | Romans 12:9 | Psalms 15:1-2 | Qur'an 6:162 | Seneca, Letters 75.1 |
| 109 | Enemies | Matthew 5:44 | Proverbs 25:21 | Qur'an 60:7 | Meditations 6.6 |
| 110 | Stress | Isaiah 26:3 | Psalms 4:2 | Qur'an 20:2-3 | Meditations 9.13 |
| 111 | Daily bread | Matthew 6:11 | Exodus 16:4 | Qur'an 11:6 | Seneca, Letters 123.2 |
| 112 | Children | Mark 10:14 | Psalms 127:3 | Qur'an 14:40 | Meditations 1.13 |
| 113 | Pride | James 4:6 | Proverbs 16:18 | Qur'an 17:37 | Enchiridion 44 |
| 114 | Courtesy | Colossians 4:6 | Proverbs 25:11 | Qur'an 4:86 | Meditations 1.10 |
| 115 | Regret | Luke 15:18 | Psalms 51:12 | Qur'an 25:71 | Meditations 8.53 |
| 116 | Journeys | Matthew 28:20 | Exodus 13:21 | Qur'an 43:13-14 | Seneca, Letters 33.11 |
| 117 | Fairness | Matthew 7:12 | Leviticus 19:15 | Qur'an 17:35 | Meditations 1.5 |
| 118 | Discouragement | Hebrews 12:3 | Isaiah 41:10 | Qur'an 93:4-5 | Meditations 6.19 |
| 119 | Brothers and sisters | 1 John 4:21 | Genesis 45:14-15 | Qur'an 12:92 | Meditations 2.1 |
| 120 | Excellence | Proverbs 22:29 | Daniel 6:4 | Qur'an 18:30 | Meditations 4.2 |
| 121 | Sleepless nights | Psalms 127:2 | Psalms 4:5 | Qur'an 2:255 | Seneca, Letters 56.6 |
| 122 | Strangers | Matthew 25:35 | Exodus 23:9 | Qur'an 59:9 | Meditations 11.24 |
| 123 | Calm under pressure | Proverbs 17:27 | Psalms 37:7 | Qur'an 48:4 | Meditations 5.2 |
| 124 | Gossip | James 3:5 | Leviticus 19:16 | Qur'an 49:12 | Enchiridion 45 |
| 125 | Storms | Mark 4:39-40 | Psalms 107:29-30 | Qur'an 10:22 | Seneca, Letters 28.7 |
| 126 | Advice | Proverbs 12:15 | Proverbs 15:22 | Qur'an 42:38 | Meditations 4.12 |
| 127 | Apology | Matthew 5:23-24 | Numbers 5:6-7 | Qur'an 7:23 | Seneca, Letters 28.9 |
| 128 | Seasons | Genesis 8:22 | Song of Songs 2:11-12 | Qur'an 36:38-40 | Meditations 9.10 |
| 129 | Self-denial | Luke 9:23 | Isaiah 58:6 | Qur'an 92:17-18 | Seneca, Letters 18.5 |
| 130 | Difficult people | Romans 12:18 | Exodus 23:5 | Qur'an 7:199 | Enchiridion 42 |
| 131 | Cheerfulness | Proverbs 15:13 | Proverbs 15:15 | Qur'an 80:38-39 | Seneca, Letters 59.16 |
| 132 | Solitude | Matthew 14:23 | Lamentations 3:26-28 | Qur'an 73:8 | Meditations 7.28 |
| 133 | Reconciliation | 2 Corinthians 5:18 | Genesis 33:4 | Qur'an 4:128 | Meditations 6.20 |
| 134 | Facing danger | Psalms 91:1-2 | Psalms 23:4 | Qur'an 27:62 | Meditations 10.12 |
| 135 | Criticism | Proverbs 9:8 | Proverbs 27:6 | Qur'an 25:73 | Meditations 8.16 |
| 136 | Study | 2 Timothy 2:15 | Joshua 1:8 | Qur'an 20:114 | Seneca, Letters 16.3 |
| 137 | Dry seasons | Psalms 63:1 | Isaiah 58:11 | Qur'an 41:39 | Seneca, Letters 27.4 |
| 138 | Initiative | James 4:17 | Ecclesiastes 11:4 | Qur'an 13:11 | Meditations 2.4 |
| 139 | Pain | Revelation 21:4 | Psalms 30:3 | Qur'an 2:214 | Enchiridion 9 |
| 140 | Community | Acts 2:46 | Psalms 122:1 | Qur'an 3:104 | Meditations 9.23 |
| 141 | Reverence | Hebrews 12:28 | Exodus 3:5 | Qur'an 23:57-58 | Seneca, Letters 41.2 |
| 142 | Bitterness | Ephesians 4:31 | Ruth 1:20 | Qur'an 15:47 | Meditations 6.57 |
| 143 | Correcting others | Galatians 6:1 | Leviticus 19:17 | Qur'an 16:125 | Meditations 10.30 |
| 144 | Routine | Luke 4:16 | Daniel 6:11 | Qur'an 17:78 | Seneca, Letters 6.7 |
| 145 | Sorrow | John 11:35 | Psalms 56:9 | Qur'an 12:84 | Seneca, Letters 63.1 |
| 146 | Adaptability | 1 Corinthians 9:22 | Jeremiah 29:5 | Qur'an 2:239 | Meditations 8.32 |
| 147 | The night sky | Psalms 147:4 | Genesis 15:5 | Qur'an 6:97 | Meditations 7.47 |
| 148 | Conscience | Acts 24:16 | Proverbs 20:27 | Qur'an 75:14-15 | Enchiridion 35 |
| 149 | Self-pity | John 5:6 | Exodus 14:15 | Qur'an 70:19-22 | Meditations 4.7 |
| 150 | Thanking others | 2 Timothy 1:16 | Ruth 2:12 | Qur'an 55:60 | Seneca, Letters 81.30 |
| 151 | Aging | Isaiah 46:4 | Psalms 92:15 | Qur'an 46:15 | Seneca, Letters 83.3 |
| 152 | Truth | John 8:32 | Proverbs 12:19 | Qur'an 17:81 | Meditations 4.11 |
| 153 | Boredom | Romans 12:11 | Ecclesiastes 1:9 | Qur'an 3:191 | Meditations 6.46 |
| 154 | Celebration | Luke 15:23-24 | Nehemiah 8:10 | Qur'an 2:185 | Seneca, Letters 18.4 |
| 155 | Tolerance | Romans 15:7 | Proverbs 19:11 | Qur'an 6:108 | Meditations 6.27 |
| 156 | Despair | Psalms 42:11 | Psalms 42:6 | Qur'an 21:83-84 | Seneca, Letters 52.2 |
| 157 | Modesty | Matthew 6:3-4 | Proverbs 27:2 | Qur'an 31:19 | Enchiridion 47 |
| 158 | Departures | Acts 20:36-38 | Genesis 28:15 | Qur'an 28:22 | Seneca, Letters 49.1 |
| 159 | Using power well | 1 Peter 5:2-3 | Deuteronomy 17:20 | Qur'an 38:26 | Meditations 7.36 |
| 160 | Frustration | Romans 7:19 | Ecclesiastes 7:8 | Qur'an 21:87 | Meditations 8.17 |
| 161 | Acceptance | Philippians 4:11 | Job 1:21 | Qur'an 64:11 | Meditations 7.54 |
| 162 | Habits | 1 Timothy 4:7-8 | Psalms 1:1-2 | Qur'an 29:45 | Meditations 11.26 |
| 163 | Disappointment | Luke 24:21 | Proverbs 13:12 | Qur'an 18:23-24 | Meditations 7.57 |
| 164 | Legacy | 2 Timothy 4:7 | Proverbs 13:22 | Qur'an 26:84 | Seneca, Letters 86.15 |
| 165 | Wholeheartedness | Mark 12:30 | Deuteronomy 6:5 | Qur'an 2:208 | Meditations 3.12 |
| 166 | Restlessness | Hebrews 4:9-10 | Psalms 62:2 | Qur'an 20:130 | Seneca, Letters 2.1 |
| 167 | Overwhelm | Psalms 61:2 | Psalms 69:2 | Qur'an 65:7 | Meditations 8.49 |
| 168 | Those in authority | 1 Timothy 2:1-2 | Jeremiah 29:7 | Qur'an 4:59 | Seneca, Letters 73.10 |
| 169 | Leisure | Mark 6:31 | Ecclesiastes 3:13 | Qur'an 7:32 | Seneca, Letters 3.5 |
| 170 | Sacrifice | Romans 12:1 | Psalms 51:19 | Qur'an 22:37 | Seneca, Letters 6.2 |
| 171 | Attention | Hebrews 2:1 | Proverbs 4:20-21 | Qur'an 50:37 | Meditations 7.4 |
| 172 | Balance | Mark 2:27 | Exodus 23:12 | Qur'an 28:77 | Enchiridion 39 |
| 173 | Ambition | 1 Thessalonians 4:11 | Proverbs 16:9 | Qur'an 2:201 | Enchiridion 37 |
| 174 | Protection | 2 Thessalonians 3:3 | Psalms 91:11 | Qur'an 113:1-5 | Meditations 4.8 |
| 175 | Goodwill | Luke 2:14 | Psalms 122:8 | Qur'an 10:10 | Meditations 4.25 |
| 176 | Letting go | Hebrews 12:1 | Isaiah 43:18 | Qur'an 24:22 | Meditations 12.25 |
| 177 | Being alive | John 10:10 | Deuteronomy 30:19 | Qur'an 76:1-3 | Meditations 12.29 |
| 178 | Holidays away from home | Luke 2:7 | Leviticus 23:42-43 | Qur'an 108:1-2 | Seneca, Letters 18.1 |
| 179 | Transitions | Psalms 16:11 | Deuteronomy 31:8 | Qur'an 84:19 | Meditations 4.42 |
| 180 | Together | Matthew 18:20 | Psalms 34:4 | Qur'an 4:1 | Meditations 7.9 |
| 181 | Calling | Ephesians 4:1 | Jeremiah 1:5 | Qur'an 74:1-3 | Meditations 9.12 |
| 182 | Self-worth | Luke 12:7 | Genesis 1:27 | Qur'an 95:4 | Meditations 12.4 |
| 183 | Restoration | Joel 2:25 | Psalms 23:3 | Qur'an 11:3 | Meditations 4.16 |
| 184 | Contemplation | Psalms 119:15 | Psalms 19:15 | Qur'an 38:29 | Meditations 10.17 |
| 185 | Silence | Ecclesiastes 3:7 | Proverbs 17:28 | Qur'an 7:204 | Seneca, Letters 56.5 |
| 186 | Forbearance | 2 Timothy 2:24 | Proverbs 14:29 | Qur'an 16:126 | Meditations 7.70 |
| 187 | Grace | Ephesians 2:8 | Exodus 34:6 | Qur'an 62:4 | Seneca, Letters 95.49 |
| 188 | Play | Zechariah 8:5 | Proverbs 8:30-31 | Qur'an 12:12 | Meditations 8.20 |
| 189 | Generations | Psalms 145:4 | Joel 1:3 | Qur'an 14:41 | Seneca, Letters 8.6 |
| 190 | Self-compassion | Matthew 22:39 | Psalms 103:14 | Qur'an 4:28 | Seneca, Letters 11.6 |
| 191 | Trustworthiness | 1 Corinthians 4:2 | Proverbs 11:13 | Qur'an 8:27 | Seneca, Letters 3.4 |
| 192 | Speaking up | Proverbs 31:8 | Proverbs 31:9 | Qur'an 4:148 | Seneca, Letters 10.4 |
| 193 | Persistence | Luke 18:1 | Genesis 32:27 | Qur'an 29:69 | Seneca, Letters 20.4 |
| 194 | Sharing | Hebrews 13:16 | Proverbs 22:9 | Qur'an 2:215 | Seneca, Letters 6.4 |
| 195 | Wants and needs | Philippians 4:19 | Psalms 23:1 | Qur'an 14:34 | Seneca, Letters 1.5 |
| 196 | The present moment | 2 Corinthians 6:2 | Psalms 95:7 | Qur'an 31:34 | Meditations 8.44 |
| 197 | Expectation | Romans 8:19 | Psalms 62:6 | Qur'an 21:90 | Seneca, Letters 91.4 |
| 198 | Rebuilding | Nehemiah 2:18 | Isaiah 58:12 | Qur'an 2:127 | Seneca, Letters 50.5 |
| 199 | Lament | Psalms 13:1-2 | Psalms 22:2 | Qur'an 28:24 | Meditations 7.14 |
| 200 | Rejoicing | Philippians 4:4 | Deuteronomy 16:15 | Qur'an 76:11 | Seneca, Letters 23.2 |
| 201 | Commitment | Luke 9:62 | Psalms 37:5 | Qur'an 33:72 | Seneca, Letters 32.2 |
| 202 | Self-deception | James 1:22 | Jeremiah 17:9 | Qur'an 18:103-104 | Seneca, Letters 118.7 |
| 203 | Risk | Matthew 14:29 | Ecclesiastes 11:1 | Qur'an 18:60 | Seneca, Letters 22.6 |
| 204 | Readiness | 1 Peter 3:15 | Exodus 12:11 | Qur'an 3:133 | Seneca, Letters 31.7 |
| 205 | Guidance | Psalms 32:8 | Psalms 25:4-5 | Qur'an 1:6-7 | Seneca, Letters 11.9 |
| 206 | Longing | Psalms 42:1 | Isaiah 26:9 | Qur'an 20:84 | Seneca, Letters 32.1 |
| 207 | Grit | 2 Timothy 2:3 | Deuteronomy 31:6 | Qur'an 46:35 | Seneca, Letters 31.4 |
| 208 | Dawn | Malachi 4:2 | Isaiah 60:1 | Qur'an 89:1-2 | Seneca, Letters 122.1 |
| 209 | Dark times | Psalms 139:11-12 | Isaiah 50:10 | Qur'an 40:44 | Seneca, Letters 66.49 |
| 210 | Harmony | Romans 12:16 | Amos 3:3 | Qur'an 30:22 | Meditations 4.40 |
| 211 | Conviction | Romans 14:5 | Psalms 16:8 | Qur'an 6:161 | Meditations 8.13 |
| 212 | Order | 1 Corinthians 14:40 | Genesis 1:31 | Qur'an 55:5 | Meditations 6.58 |
| 213 | Confusion | 1 Corinthians 14:33 | Psalms 119:105 | Qur'an 93:7 | Seneca, Letters 16.5 |
| 214 | Sloth | Proverbs 6:9 | Proverbs 24:33-34 | Qur'an 107:4-5 | Meditations 6.8 |
| 215 | Greed | Luke 12:15 | Exodus 20:14 | Qur'an 64:16 | Seneca, Letters 69.4 |
| 216 | Desire | Psalms 37:4 | Psalms 145:16 | Qur'an 3:14 | Meditations 9.7 |
| 217 | Appetite | 1 Corinthians 10:31 | Proverbs 25:16 | Qur'an 2:172 | Seneca, Letters 60.3 |
| 218 | Revenge | Romans 12:19 | Proverbs 20:22 | Qur'an 42:40 | Meditations 5.25 |
| 219 | Deception | Galatians 6:7 | Leviticus 19:11 | Qur'an 83:1-3 | Seneca, Letters 40.6 |
| 220 | Honest gain | Ephesians 4:28 | Proverbs 16:8 | Qur'an 2:188 | Meditations 7.53 |
| 221 | Comfort | 2 Corinthians 1:3-4 | Isaiah 40:1 | Qur'an 33:43 | Seneca, Letters 63.10 |
| 222 | Comforting others | Romans 12:15 | Job 2:11 | Qur'an 4:8 | Seneca, Letters 103.3 |
| 223 | Caring for the sick | Matthew 25:36 | Psalms 41:4 | Qur'an 2:184 | Meditations 6.55 |
| 224 | The vulnerable | James 1:27 | Deuteronomy 10:18 | Qur'an 107:1-3 | Seneca, Letters 25.2 |
| 225 | Poverty | Luke 6:20 | Deuteronomy 15:7 | Qur'an 2:273 | Seneca, Letters 4.10 |
| 226 | Abundance | Ephesians 3:20 | Psalms 23:5 | Qur'an 16:18 | Seneca, Letters 20.10 |
| 227 | Day of rest | Exodus 20:8 | Genesis 2:3 | Qur'an 62:9-10 | Seneca, Letters 15.6 |
| 228 | Sharing a meal | Luke 24:30-31 | Ecclesiastes 9:7 | Qur'an 22:28 | Seneca, Letters 64.2 |
| 229 | Song | Colossians 3:16 | Psalms 96:1 | Qur'an 17:44 | Seneca, Letters 108.10 |
| 230 | Rain | Matthew 5:45 | Deuteronomy 11:14 | Qur'an 50:9 | Meditations 5.7 |
| 231 | Creatures | Matthew 6:26 | Proverbs 12:10 | Qur'an 6:38 | Seneca, Letters 76.8 |
| 232 | The sea | Psalms 107:23-24 | Psalms 104:25 | Qur'an 16:14 | Seneca, Letters 53.3 |
| 233 | Mountains | Isaiah 52:7 | Psalms 36:7 | Qur'an 78:6-7 | Seneca, Letters 79.2 |
| 234 | Growth | 2 Peter 3:18 | Psalms 92:13 | Qur'an 71:17 | Seneca, Letters 94.47 |
| 235 | Harvest | Matthew 9:37-38 | Leviticus 23:22 | Qur'an 6:141 | Meditations 6.17 |
| 236 | Sowing | 2 Corinthians 9:6 | Hosea 10:12 | Qur'an 56:63-64 | Meditations 4.36 |
| 237 | Roots | Colossians 2:6-7 | Jeremiah 17:8 | Qur'an 31:22 | Seneca, Letters 2.2 |
| 238 | Refining | 1 Peter 1:7 | Malachi 3:3 | Qur'an 89:15-16 | Seneca, Letters 13.15 |
| 239 | Thirst | John 4:14 | Isaiah 55:1 | Qur'an 56:68-70 | Seneca, Letters 119.3 |
| 240 | Shelter | Psalms 61:3-4 | Isaiah 32:2 | Qur'an 16:81 | Seneca, Letters 90.10 |
| 241 | Appearance | 1 Samuel 16:7 | Proverbs 31:30 | Qur'an 7:26 | Meditations 7.60 |
| 242 | Being known | Psalms 139:1-2 | Isaiah 43:1 | Qur'an 50:16 | Meditations 2.8 |
| 243 | Dreams | Joel 2:28 | Genesis 28:12 | Qur'an 12:4 | Seneca, Letters 53.7 |
| 244 | Vision | Habakkuk 2:2-3 | Proverbs 29:18 | Qur'an 6:75 | Meditations 9.31 |
| 245 | Plans | Proverbs 19:21 | Proverbs 16:3 | Qur'an 53:24-25 | Seneca, Letters 52.1 |
| 246 | Decisions | 1 Kings 3:9 | Proverbs 4:26 | Qur'an 39:55 | Seneca, Letters 20.6 |
| 247 | Example | 1 Timothy 4:12 | Proverbs 20:7 | Qur'an 33:21 | Seneca, Letters 11.10 |
| 248 | Overcoming | Romans 12:21 | Psalms 18:30 | Qur'an 13:22 | Seneca, Letters 9.3 |
| 249 | Rewards | Hebrews 11:6 | Proverbs 11:18 | Qur'an 16:96 | Seneca, Letters 81.19 |
| 250 | Letters from home | 3 John 1:13-14 | Proverbs 25:25 | Qur'an 27:28-29 | Seneca, Letters 38.1 |
| 251 | Reunion | John 16:22 | Genesis 46:29 | Qur'an 12:99 | Seneca, Letters 35.3 |
| 252 | Guests | Luke 10:38 | Genesis 18:2-3 | Qur'an 15:51-52 | Seneca, Letters 64.1 |
| 253 | Weakness | Romans 8:26 | Psalms 73:26 | Qur'an 35:15 | Seneca, Letters 11.5 |
| 254 | Joy in work | Psalms 90:17 | Ecclesiastes 3:22 | Qur'an 9:105 | Meditations 6.33 |
| 255 | Praise | Proverbs 27:21 | Proverbs 31:31 | Qur'an 3:188 | Seneca, Letters 7.12 |
| 256 | Blame | Matthew 7:3 | Genesis 3:12 | Qur'an 6:164 | Meditations 7.62 |
| 257 | Fame | Matthew 6:1 | Jeremiah 9:22-23 | Qur'an 28:83 | Meditations 6.18 |
| 258 | Rank | Luke 14:10-11 | Proverbs 25:6-7 | Qur'an 58:11 | Seneca, Letters 44.4 |
| 259 | Equality | Galatians 3:28 | Malachi 2:10 | Qur'an 33:35 | Seneca, Letters 66.34 |
| 260 | Elders | 1 Timothy 5:1-2 | Job 12:12 | Qur'an 36:68 | Seneca, Letters 33.7 |
| 261 | Youth | Ecclesiastes 12:1 | Ecclesiastes 11:9 | Qur'an 18:13 | Seneca, Letters 4.2 |
| 262 | Teachers | Luke 6:40 | Psalms 119:99 | Qur'an 55:1-4 | Meditations 1.4 |
| 263 | Following | Matthew 4:19 | Deuteronomy 13:5 | Qur'an 3:31 | Seneca, Letters 6.5 |
| 264 | Interruptions | Mark 6:34 | Exodus 3:3-4 | Qur'an 80:1-4 | Seneca, Letters 56.4 |
| 265 | Mistakes | James 3:2 | Psalms 19:13 | Qur'an 33:5 | Meditations 9.38 |
| 266 | Endings | 2 Corinthians 13:11 | Deuteronomy 34:7 | Qur'an 110:1-3 | Meditations 7.69 |
| 267 | New places | Hebrews 11:8 | Genesis 12:1 | Qur'an 29:20 | Seneca, Letters 104.13 |
| 268 | Admiration | Philippians 3:17 | Proverbs 13:20 | Qur'an 6:90 | Seneca, Letters 64.6 |
| 269 | Believing in others | Philemon 1:21 | Judges 6:12 | Qur'an 18:28 | Seneca, Letters 29.4 |
| 270 | Completion | Philippians 1:6 | Genesis 2:1-2 | Qur'an 6:115 | Meditations 11.5 |

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
- **Self-harm screening (days 91–180):** every new passage was screened by script for words about death, killing, blood and suicide, and read in full. Dropped for this reason: 2 Corinthians 7:10 ("the sorrow of the world produces death"), Meditations 7.24 (ends "what reason is there for living any longer?"), Meditations 6.10, 7.33 and 8.2, Seneca 23.4, Enchiridion 7, and all of Seneca letters 12, 14 and 107 (12 ends on no one being forced to stay alive, 14.5 describes torture, 107 has "O for Death!"). Every Seneca letter used was scanned in full, because the Study view shows the whole letter. Still worth a look: Seneca, Letters 6.2 (day 170, Sacrifice) speaks of friends who "meet death" for each other; Meditations 6.46 (day 153, Boredom) ends "How long then?"; Qur'an 6:162 (day 108) mentions "my dying".
- **Day 156 (Despair):** every tradition's reflection names the app's Need to talk? screen and a chaplain. Days 121 (Sleepless nights), 139 (Pain), 167 (Overwhelm) and 177 (Being alive) also point to help. Check the wording of each.
- **Endings mid-sentence (days 91–180):** Christian Matthew 5:44, 2 Corinthians 5:18, Acts 2:46, Hebrews 12:28, 2 Timothy 1:16, Romans 12:11, 1 Thessalonians 4:11, Hebrews 12:1; Jewish Deuteronomy 10:12, Psalms 15:1-2, Proverbs 25:21, Exodus 13:21, Song of Songs 2:11-12, Psalms 30:3, Jeremiah 29:5, Psalms 92:15, Deuteronomy 30:19; Muslim Qur'an 53:43, 32:7, 23:1-2, 20:2-3, 25:71, 48:4, 42:38, 80:38-39, 73:8, 23:57-58, 21:83-84, 28:77. Starting mid-sentence (lowercase): Christian Mark 10:8-9, Psalms 63:6, Matthew 28:20, Matthew 25:35, Romans 12:11, 1 Peter 5:2-3, 1 Thessalonians 4:11; Jewish Deuteronomy 17:20. Kept as printed.
- **Source typos kept as printed (days 91–180):** Jewish Psalms 56:9 reads "Thou has counted"; Muslim Qur'an 29:56 reads "Therefor"; Jewish Psalms 1:1 starts "HAPPY IS" in capitals. Two passages were not used because of source errors: Qur'an 31:14 reads "concerning his partners" (for "parents") and Qur'an 36:12 has an unclosed bracket; Psalms 78:4 ends with a stray " .".
- **Jewish, Psalms numbering (days 91–180):** Hebrew numbering throughout, e.g. 4:2, 4:5, 42:6, 51:12, 51:19, 56:9, 62:2, 69:2, 84:3, 92:15 are one higher than English. Psalms 15:1-2 and 122:1 include their headings.
- **Muslim claims to confirm (days 91–180):** day 116 says Qur'an 43:13-14 is recited when setting out on a journey; day 121 says many recite Ayat al-Kursi (2:255) before sleep; day 154 links 2:185 to Eid; day 178 says many commentators connect surah 108 with Eid al-Adha; day 122 identifies the people of 59:9 as the people of Medina.
- **Muslim, Qur'an 6:108 (day 155, Tolerance)** and **4:59 (day 168, Those in authority):** check the reflections frame these carefully; 4:59 is often discussed in debates about obeying rulers.
- **Christian, Psalms 91:1-2 (day 134)** and **Jewish, Psalms 23:4 (day 134)**: the reflections say many service members pray these psalms. Psalm 91 is called a refuge, not a guarantee against harm.
- **Humanist, themes with weak matches:** Stoic texts say little directly about parents, laughter or celebration. Meditations 6.12 (day 105, Parents) uses mother and step-mother as an image for philosophy and the court; Seneca 23.5 (day 99, Laughter) contrasts shallow pleasure with deep joy; Seneca 73.10 (day 168) quotes Vergil calling a ruler "my god". A humanist reviewer may prefer other sections.
- **Humanist, Meditations 1.13 and 6.6** include Long's bracketed words. Kept as printed.
- **Length (days 91–180):** Muslim Qur'an 46:15 (562) and 2:185 (516); Humanist Seneca 49.1 (967), Meditations 2.1 (871), Seneca 41.3 (869), Seneca 115.3 (808), Enchiridion 4 (714) and ten more over 500 characters. These will be truncated in the medium widget.
- **Source supply (days 181–270):** the Stoic texts are running thin for good thematic matches. The Enchiridion has about 17 short clean sections left and none were used in this batch; the Meditations still has short sections, but many are on death or are fragments. This batch leans on Seneca, and several humanist passages are loose fits for their theme: Meditations 6.58 (Order), 6.8 (Sloth), 6.17 (Harvest), 9.31 (Vision), 11.5 (Completion), Seneca 11.5 (Weakness), 40.6 (Deception), 53.7 (Dreams), 95.49 (Grace), 33.7 (Elders). A humanist reviewer may prefer other sections. A fourth batch would likely need another public-domain Stoic source (for example Epictetus's Discourses or Musonius Rufus) or repeated themes.
- **Self-harm and polemic screening (days 181–270):** dropped Seneca 17.5 (ends "nothing forbids you to die nobly"), 82.3 ("Leisure without study is death; it is a tomb"), 122.3, Meditations 12.9 and 7.40, 1 Kings 18:21 (Elijah against Baal), Joshua 24:15 (other gods), Qur'an 4:100 ("death overtaketh him"), 21:30 and 30:36. Whole Seneca letters 30, 67 and 71 were avoided (dying, torture, Cato). Seneca letters 66 and 91 were used although they mention torture elsewhere in the abstract; check that this is acceptable for the Study view.
- **Day 209 (Dark times):** every reflection points to getting help. Day 199 (Lament), 190 (Self-compassion) and 253 (Weakness) are also emotionally heavy; check the tone.
- **Source typos and artifacts avoided (days 181–270):** Psalms 103:13 and Proverbs 13:11 carry a stray ". ." in the bundled JPS text; Qur'an 11:69 ("cam") and 24:12 ("own own") have typos. Kept as printed: Qur'an 76:11 "Therefor", Psalms 119:105 starts with the letter heading "NUN.".
- **Muslim, Qur'an 12:12 (day 188, Play)** is spoken by Joseph's brothers as part of their plot; **6:161 (day 211)** ends "who was no idolater"; **74:1-3 (day 181)** is described as an early call. Confirm the framing.
- **Jewish, Psalms 19:15 (day 184)** is said to close the Amidah; **Exodus 34:6 (day 187)** is called part of the Thirteen Attributes; **day 223** mentions bikur cholim and **day 252** hachnasat orchim. Confirm the wording.
- **Length (days 181–270):** Christian none; Jewish none; Muslim Qur'an 33:35 (582); Humanist Meditations 12.4 (506), Seneca, Letters 56.5 (619), Seneca, Letters 3.4 (510), Seneca, Letters 6.4 (512), Seneca, Letters 50.5 (507), Seneca, Letters 32.2 (646), Seneca, Letters 11.9 (632), Seneca, Letters 25.2 (726), Seneca, Letters 4.10 (606), Seneca, Letters 108.10 (501), Seneca, Letters 76.8 (539), Seneca, Letters 53.3 (577), Seneca, Letters 79.2 (1025), Seneca, Letters 94.47 (575), Seneca, Letters 2.2 (551), Seneca, Letters 119.3 (513), Seneca, Letters 81.19 (893), Seneca, Letters 38.1 (758), Seneca, Letters 35.3 (510), Seneca, Letters 33.7 (865), Seneca, Letters 4.2 (582), Seneca, Letters 6.5 (562).
- **Themes 3 (Fear) and 10 (Loneliness):** check that reflections encourage people to reach out, and do not read as a substitute for getting help.

## First-pass review: days 1–45 (AI, 2026-11-24)

Claude made a first pass over all 180 entries for days 1–45 before any human review. **This is not a sign-off: every entry stays DRAFT** until a reviewer from its tradition approves it.

For each entry it checked four things: the passage matches the bundled source text (`check_texts.py`, 180/180), the reflection is accurate and respectful, the tone suits service members, and there are no errors in citation, theme or duplication. No reference repeats within a tradition, and no verse ranges overlap.

| Tradition | Checked | Fixed | Flagged (new) |
|---|---|---|---|
| Christian | 45 | 4 | 6 |
| Jewish | 45 | 9 | 6 |
| Muslim | 45 | 2 | 10 |
| Humanist | 45 | 9 | 8 |
| **Total** | **180** | **24** | **30** |

Flags already listed in "Points for reviewers" above (for example days 13, 28, 35 and 41) still stand and are not counted again.

### Fixed (reflections and prompts only; no passage text was changed)

- **Wording that did not match the passage shown:** Christian day 6 said the hope will "overflow"; the WEB text says "abound". Jewish day 31 said justice is "rolling down like waters" (the King James wording); JPS reads "well up as waters".
- **Attribution:** Jewish day 30 said "Job concludes"; Job 28 is a poem on wisdom whose speaker is debated, so it now reads "The poem on wisdom in Job 28 concludes".
- **Grammar and repetition:** Christian day 11 prompt ("Who could you let comfort you, or comfort, this week?"), Humanist day 16 ("show them kindly" was missing "their error"), Muslim day 39 (the same sentence was said twice).
- **Spelling:** the rest of the catalog uses American spelling (124 to 11), so British spellings in days 1–45 reflections and prompts were changed: behavior, fulfill, traveling, neighbor, practice, honoring, skillful, recognizes, judgment, criticize. Christian 33, 41; Jewish 4, 8, 9, 12, 25, 28, 44; Muslim 22; Humanist 2, 19, 20, 22, 28, 39, 43, 44. The Jewish day 8 prompt keeps 'neighbour' because it quotes the JPS text.

### Flagged for a reviewer's judgment

**All traditions**
- **Day 32 (Mortality):** each passage speaks of death directly (Meditations 4.17: "Death hangs over thee"; Qur'an 3:185 also names the Fire). The theme is deliberate. Check the tone for anyone who has lost comrades, and consider pointing to the Need to talk? screen.
- **House style:** pronouns for God are capitalized in some reflections and not others (Christian 33 "Him"; also Christian 184, 195, 240, 243, 249). Pick one style for the whole catalog.

**Christian**
- **Day 21, John 15:13** ("lay down his life for his friends"): the reflection says many in uniform understand this. It is a powerful verse for service members, and a painful one for anyone grieving a friend. Decide whether the wording is gentle enough.
- **Days 18, 20 and 24** (Luke 15:20, John 14:1, Luke 6:36) open a quotation mark that never closes, because the speech continues past the verse. Kept as printed.

**Jewish**
- **Day 28, Psalms 78:72** reads "And lead them by the skilfulness of his hands"; "led" is expected. Sefaria and Mechon Mamre both read "lead", so this may be in the 1917 printing. Check a printed copy. If it is a digital error, fix both the passage and the bundled text, because the integrity test compares them.
- **Day 12, Ecclesiastes 9:10** ends "in the grave, whither thou goest". On a Duty day, for people on deployment, that line may land hard. Consider whether the reflection should acknowledge it.
- **Days 11 and 38:** Psalms 34:19 and 30:6 use Hebrew numbering (English 34:18 and 30:5). They are not in the numbering list above.
- **Day 37** uses "teshuvah" without explaining it. Consider adding "(return, repentance)".
- **General:** the reflections write "God" and "the LORD" in full. Some observant readers prefer "G-d" or "Hashem". This is the reviewer's call.

**Muslim**
- **Day 15, Qur'an 103:2** reads "Lo! man is a state of loss"; "is in a state of loss" is expected. quran.com and sacred-texts.com both read "is a state", so check the 1930 printing before changing anything.
- **Day 41, Qur'an 20:29** has Moses ask for "a henchman". This is Pickthall's word for a helper, but today it suggests a criminal's sidekick. Decide whether the passage is still suitable, or add a note.
- **Day 23, Qur'an 20:131** ("some wedded pairs among them") reads oddly out of context. The reflection explains the meaning, but confirm it is clear.
- **Passages that start mid-sentence:** days 1 (13:28 "Who have believed"), 3 (65:3 "And will provide for him"), 17 (67:2), 19 (3:134), 29 (76:8-9) and 44 (39:18 "Who hear advice") continue from the verse before. Kept as printed; check that each reads well on its own.
- **General:** the reflections name the Prophet, Moses and Jacob without an honorific such as "(peace be upon him)". Decide whether to add one.

**Humanist**
- **Day 39, Enchiridion 5** contains "death is nothing terrible". The days 91–180 screening would have dropped this line, because it could read as dismissing death to someone at risk. **Recommend replacing** it with another passage on Responsibility.
- **Day 42, Seneca, Letters 9.10** speaks of a friend "for whom I may die" and staking "my own life" against their death. This is the same screening concern, and a heavy one for anyone who has lost comrades. **Recommend replacing it** or adding careful framing.
- **Day 7, Meditations 5.18** ("Nothing happens to any man which he is not formed by nature to bear"), with a reflection ending "reasoned resolve can as well", could make someone who is struggling feel they are failing. Consider adding a line that getting help is part of bearing hard things.
- **Day 11 (Grief):** unlike the other three traditions, the prompts do not suggest sharing grief with someone. Consider changing one prompt.
- **Day 36, Meditations 7.22** ("soon both of you will die") and **day 12, Enchiridion 17** ("if short, of a short one", life as a short play) are mild mentions of death. Check the tone.
- **Day 18 (Homecoming), Meditations 6.11** is about regaining your balance, not about coming home. It is a loose fit for the theme.
- **Long's bracketed insertions** not in the list above: Meditations 8.33 (day 14), 6.39 (day 21), 11.4 (day 29), 7.45 (day 35). Kept as printed.

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
