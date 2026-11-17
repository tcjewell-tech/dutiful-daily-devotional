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

The Study view shows the whole chapter, surah or section from `DutifulDailyDevotional/Resources/Texts/<source>/<work>.json` (spec section 4.3). These files are not generated yet: until they are, the Study view shows the passage on its own and the content-integrity test is skipped. The converters still have to be written in `scripts/` (plan Task 3).

## Known limits

- If the private data store cannot open (for example, the device is full), the app keeps running with a temporary store, and favorites and notes made in that state are lost when the app quits.
- There is no app icon yet.
