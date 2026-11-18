# Dutiful Daily Devotional

An offline iOS daily reflection app and widget for U.S. service members of Christian, Jewish, Muslim and Humanist traditions. It contains no networking code.

- Design: [docs/specs/2026-11-01-dutiful-daily-devotional-design.md](docs/specs/2026-11-01-dutiful-daily-devotional-design.md)
- Build plan: [docs/plans/2026-11-17-dutiful-daily-devotional-mvp.md](docs/plans/2026-11-17-dutiful-daily-devotional-mvp.md)
- Content review status: [docs/CONTENT_REVIEW.md](docs/CONTENT_REVIEW.md)

## Building

The Xcode project is generated from `project.yml`; it is not committed.

**On a Mac** (Xcode 16 or later, iOS 17 SDK):

```bash
brew install xcodegen
xcodegen generate
open DutifulDailyDevotional.xcodeproj
```

**From Windows:** push the branch to GitHub. `.github/workflows/ios.yml` generates the project, refuses any networking code, builds, and runs the tests on a macOS runner.

## Android version

`android/` holds an Android app (Kotlin, Jetpack Compose, min Android 8.0) with the same features apart from the lock screen widget: tradition picker, Today, Study with a private note, Favorites, Archive, Settings, Need to talk?, and a home screen widget named "Daily Reflection". It reads the **same** content files as the iPhone app (`Shared/Resources/Devotionals/` and, once they exist, `DutifulDailyDevotional/Resources/Texts/`), so entries are written once, and it uses the same rule to pick the day's entry, so both phones show the same reading on the same date.

It requests no permissions at all (no INTERNET). Favorites and notes are stored privately on the phone and excluded from backups. `.github/workflows/android.yml` runs the tests and lint, and fails if the built app ever asks for INTERNET.

Build on Windows with Android Studio (open the `android` folder), or from a terminal:

```bash
cd android && ./gradlew testDebugUnitTest assembleDebug
```

Differences from iOS: Android has no lock screen widgets, so there is no discreet lock screen setting; the widget refreshes every 30 minutes, so it can lag up to half an hour after midnight; the app ID `com.example.dutifuldailydevotional` and the missing app icon must be replaced before Play Store release.

## App Group and signing

The app and the widget share two settings (`selectedTradition`, `discreetLockScreen`) through the App Group `group.com.example.dutifuldailydevotional`. Before running on a device:

1. Replace `com.example` in `project.yml` with your own bundle ID prefix, in the bundle IDs and both App Group entries.
2. Set your development team in Xcode (Signing & Capabilities) for both targets, then check the App Group is ticked for both.

If the App Group is missing, the app still works but the widget keeps saying "Open the app to choose a tradition."

## Editing daily entries

Entries live in `Shared/Resources/Devotionals/<tradition>.json` (format in spec section 4.2). Rules:

- `day` runs 1…N with no gaps, and the same day has the same `theme` in all four files.
- `passageText` must be copied exactly from the source text, never retyped. The content tests check this against the bundled full texts once those exist.
- Every new or changed entry is listed in `docs/CONTENT_REVIEW.md` and stays draft until a reviewer from that tradition signs off.

## Full source texts

The Study view shows the whole chapter, surah or section from `DutifulDailyDevotional/Resources/Texts/<source>/<work>.json` (spec section 4.3). These files are generated once, on a computer with Python 3 and internet access, and committed; the app itself never downloads anything.

```
python -I scripts/build_texts.py      # downloads into scripts/downloads/, writes Texts/
python -I scripts/check_texts.py      # every devotional reference must match the texts
```

Sources: World English Bible from eBible.org (`eng-web` VPL, 66 books, no deuterocanon); JPS 1917 from Sefaria (Hebrew verse numbering; `I Samuel` is saved as `1 Samuel`, `Song of Songs` keeps that name); Pickthall from Tanzil, cross-checked word for word against a second copy; Long's Marcus Aurelius and Epictetus from Project Gutenberg (#15877, #10661, via the gutenberg.pglaf.org mirror); Gummere's Seneca from Wikisource, with its section numbers as verses. Run `check_texts.py` again after adding entries: a reference that does not resolve, or a `passageText` that differs from the source, fails it.

## Known limits

- If the private data store cannot open (for example, the device is full), the app keeps running with a temporary store, and favorites and notes made in that state are lost when the app quits.
- There is no app icon yet.
