# Dutiful Daily Devotional MVP Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Ship the offline, multi-faith daily reflection app (app + WidgetKit extension + tests) described by the spec.

**Architecture:** One XcodeGen project with three targets. `Shared/` (models, content loading, day selection, preferences) compiles into both the app and the widget, so both always pick the same entry. The app adds SwiftUI views, a private SwiftData store for favorites and journal notes, and bundled full source texts for the Study view. Nothing touches the network.

**Tech Stack:** Swift 5.9+, SwiftUI, WidgetKit, SwiftData, XCTest, XcodeGen, GitHub Actions macOS runner.

**Spec:** `docs/specs/2026-11-01-dutiful-daily-devotional-design.md`

## Global Constraints

- iOS 17.0 minimum; Swift 5.9+; SwiftUI only.
- Targets: `DutifulDailyDevotional`, `DutifulDailyDevotionalWidget`, `DutifulDailyDevotionalTests`; project from `project.yml` (no committed `.xcodeproj`).
- Bundle ID `com.example.dutifuldailydevotional` (widget: `.widget`); App Group `group.com.example.dutifuldailydevotional`.
- Display name "Dutiful Daily Devotional"; short name "Dutiful Devotional".
- No networking, accounts, analytics, ads or third-party SDKs. No `URLSession`, `WKWebView` or `http(s)://` in Swift sources.
- Public-domain source texts only: WEB, JPS 1917, Pickthall (1930), Long's Marcus Aurelius and Epictetus, Gummere's Seneca.
- No military seals, insignia or branch logos.
- System fonts, Dynamic Type, VoiceOver, light and dark mode.
- No force unwraps in production code.
- App Group defaults hold only `selectedTradition` and `discreetLockScreen` (default `true`).

## Review Focus

1. **Day changes while the app stays open** (past local midnight): Today must move to the new entry without a relaunch. Task 4 listens for `UIApplication.significantTimeChangeNotification`; check on device.
2. **App Group not provisioned** (signing mistake): `UserDefaults(suiteName:)` returns nil. The app must still work; the widget then shows "Open the app to choose a tradition". Task 1 falls back to `.standard`; check on device that the widget follows the app once signing is right.
3. **A reference that runs past the end of a chapter** (`John 14:30-33`): `passageText` must return nil, not a shorter passage. Task 3 test `testRangePastEndOfDivisionReturnsNil`.
4. **Very large Dynamic Type sizes:** onboarding buttons and the Study view must scroll, not clip. Task 4 wraps every screen in `ScrollView`/`List`; check in the simulator at AX5.
5. **Store cannot open** (disk full, protection error): favorites and notes must not crash the app. Task 4 falls back to an in-memory store; notes written in that state are lost on quit (accepted, noted in README).

---

### Task 1: Project skeleton and shared core

**Files:**
- Create: `project.yml`, `.gitignore`, `Shared/{AppConstants,Tradition,Devotional,DevotionalStore,DevotionalProvider,UserPreferences}.swift`
- Create: `DutifulDailyDevotional/Resources/{Assets.xcassets,PrivacyInfo.xcprivacy}`, `DutifulDailyDevotional/Resources/Texts/.gitkeep`
- Test: `DutifulDailyDevotionalTests/DevotionalProviderTests.swift`

**Interfaces (Produces):**
- `enum AppConstants { appGroupID, urlScheme = "dutifuldevotional", widgetKind, todayURL: URL? }`
- `enum Tradition: String, CaseIterable, Codable, Identifiable { christian, jewish, muslim, humanist }` with `displayName`, `sourceName`, `sourceAttribution`, `textDirectory` (`web`, `jps1917`, `pickthall`, `stoics`).
- `struct Devotional: Hashable, Identifiable { tradition, day, theme, reference, passageText, reflection, studyPrompts; id = "\(tradition.rawValue)-\(day)"; shareText }`
- `struct DevotionalFile: Decodable` (the on-disk shape from spec §4.2).
- `struct DevotionalStore { bundle; devotionals(for:) -> [Devotional] (sorted by day, [] on any failure); devotional(id:) -> Devotional? }`
- `enum DevotionalProvider { index(dayOfYear:count:), index(for:calendar:count:), devotional(from:on:calendar:), today(for:store:date:calendar:), nextMidnight(after:calendar:), datesThisYear(through:calendar:) }`
- `enum UserPreferences { selectedTraditionKey, discreetLockScreenKey, defaults, selectedTradition, discreetLockScreen }`

- [ ] **Step 1: Write `DevotionalProviderTests`** (calendar fixed to `America/Los_Angeles`, count 90):
  `testJanuaryFirstIsIndexOne` (2027-01-01 → 1), `testDecember31InCommonYear` (2026-12-31 → 5), `testDecember31InLeapYear` (2028-12-31 → 6), `testFebruary29` (2028-02-29 → 60), `testYearRolloverRepeatsEarlyEntries` (2026-12-27 == 2027-01-01), `testLocalMidnightBoundary` (2027-01-01 07:59:59Z → 5, 08:00:00Z → 1), `testNoEntriesGivesNil`, `testNextMidnightIsStartOfNextLocalDay`, `testArchiveDatesRunFromJanuaryFirstThroughToday` (2028-03-01 → 61 dates).
- [ ] **Step 2: Implement** the Shared files. `index = dayOfYear % count`, `dayOfYear = calendar.ordinality(of: .day, in: .year, for: date)`.
- [ ] **Step 3: Generate and test on CI/Mac:** `xcodegen && xcodebuild test -scheme DutifulDailyDevotional -destination 'platform=iOS Simulator,name=<iPhone>'` → all provider tests pass.
- [ ] **Step 4: Commit.**

### Task 2: Devotional content files (batch 1)

**Files:**
- Create: `Shared/Resources/Devotionals/{christian,jewish,muslim,humanist}.json`, `docs/CONTENT_REVIEW.md`
- Test: `DutifulDailyDevotionalTests/DevotionalContentTests.swift`

**Interfaces:** Consumes `DevotionalStore`, `SourceReference.parse` (Task 3).

- [ ] **Step 1: Write tests:** `testEveryTraditionDecodesWithContiguousDays` (days == 1...N, N ≤ 90), `testTraditionsShareDayCountAndThemes`, `testEveryEntryHasThreeNonEmptyPromptsAndText`, `testEveryReferenceParses`, `testIDsRoundTripThroughStore`, `testFullCatalogHasNinetyDays` (skips with `XCTSkip` while N < 90; becomes the release gate).
- [ ] **Step 2: Write entries.** Same theme per day across files. `passageText` copied programmatically from the source (never typed by hand). Every file keeps `_reviewNote`.
- [ ] **Step 3: Record** each entry in `docs/CONTENT_REVIEW.md` with its review status.
- [ ] **Step 4: Run tests** → pass, with `testFullCatalogHasNinetyDays` skipped.
- [ ] **Step 5: Commit.** Repeat Steps 2–5 for days 11–45, then 46–90.

### Task 3: References and local full texts

**Files:**
- Create: `DutifulDailyDevotional/Scripture/{SourceReference,LocalTextStore}.swift`
- Test: `DutifulDailyDevotionalTests/{SourceReferenceTests,LocalTextStoreTests,ContentIntegrityTests}.swift`, fixture `DutifulDailyDevotionalTests/Fixtures/Texts/web/John.json`

**Interfaces (Produces):**
- `struct SourceReference: Equatable { work: String; division: Int; verses: ClosedRange<Int>?; contains(verse:) -> Bool; static parse(_:tradition:) -> SourceReference? }`. `work` is the file name in `Texts/<textDirectory>/`: book name (`1 John`), surah number (`2`), `Meditations`, `Letters` (Seneca), `Enchiridion`. `Enchiridion N` parses to division N with `verses == nil` (whole chapter).
- `struct TextWork/TextDivision/TextVerse: Decodable` (spec §4.3 shape).
- `struct LocalTextStore { bundle; division(for:tradition:) -> TextDivision?; passageText(for:tradition:) -> String? }`

- [ ] **Step 1: Write tests.** `SourceReferenceTests`: each spec format, ranges, `1 John 4:19`, curly apostrophe `Qur’an`, invalid inputs (`""`, `John`, `John 14`, `John 14:9-3`, `Meditations 4:3`, `Qur'an 0:1`). `LocalTextStoreTests`: `testLoadsDivision`, `testHighlightsOnlyReferencedVerses`, `testPassageTextJoinsRange`, `testRangePastEndOfDivisionReturnsNil`, `testMissingWorkReturnsNil`. `ContentIntegrityTests.testEveryPassageMatchesBundledFullText` (whitespace-normalized; skips a tradition whose texts are not bundled yet; skips entirely if none are).
- [ ] **Step 2: Implement** with `#/…/#` regex literals (no bare-slash flag needed).
- [ ] **Step 3: Write converters in `scripts/`** that turn the downloaded public-domain sources into `DutifulDailyDevotional/Resources/Texts/<dir>/<work>.json`: WEB from eBible.org `eng-web` (USFM or VPL), JPS 1917 from Sefaria ("The Holy Scriptures: A New Translation (JPS 1917)"), Pickthall (cross-check two sources), Long's Marcus Aurelius (Gutenberg #15877) and Epictetus (Gutenberg #10661), Gummere's Seneca (Wikisource). Strip Gutenberg headers, footnote markers and Wikisource page-break characters. Run once on a dev machine; the app never downloads.
- [ ] **Step 4: Run tests** → integrity test now compares every entry; fix any mismatch at the source.
- [ ] **Step 5: Commit.**

### Task 4: App shell, persistence and views

**Files:**
- Create: `DutifulDailyDevotional/App/{DutifulDailyDevotionalApp,DeepLink}.swift`, `Persistence/{UserDataModels,ModelContainerFactory}.swift`, `Views/{RootView,OnboardingView,TodayView,DevotionalCardView,StudyView,PassageTextView,FavoritesView,ArchiveView,SettingsView,NeedToTalkView}.swift`
- Test: `DutifulDailyDevotionalTests/DeepLinkTests.swift`

**Interfaces:**
- `enum DeepLink: Equatable { case today; init?(url: URL) }` (scheme `dutifuldevotional`, host `today`).
- `@Model FavoriteMark { @Attribute(.unique) devotionalID; createdAt }`, `@Model JournalNote { @Attribute(.unique) devotionalID; text; updatedAt }`.
- `ModelContainerFactory.shared`: store at `Application Support/UserData/UserData.store`, directory protection `.complete`, `isExcludedFromBackup = true`, `cloudKitDatabase: .none`; in-memory fallback.
- `DevotionalDetailView(devotional:)` (card + Study / favorite / share), reused by Today, Archive and Favorites.

- [ ] **Step 1: Write `DeepLinkTests`:** `today` URL parses; wrong scheme or host → nil.
- [ ] **Step 2: Implement** views. Root shows Onboarding until a tradition is stored, then tabs Today / Archive / Favorites / Settings. `onChange` of either preference → `WidgetCenter.shared.reloadAllTimelines()`. Need to talk? is reachable from the Today toolbar and Settings; only `tel:988` is tappable.
- [ ] **Step 3: Run tests; launch in the simulator** in airplane mode: onboarding → Today → Study → favorite → note → Archive → Settings.
- [ ] **Step 4: Commit.**

### Task 5: Widget extension

**Files:**
- Create: `DutifulDailyDevotionalWidget/{DutifulDailyDevotionalWidgetBundle,DevotionalWidget,DevotionalTimelineProvider}.swift`, `Views/{Small,Medium,LockScreen}WidgetView.swift`, `PrivacyInfo.xcprivacy`

**Interfaces:** `struct DevotionalEntry: TimelineEntry { date; devotional: Devotional?; discreet: Bool }`. Timeline: one entry, `.after(DevotionalProvider.nextMidnight(after:calendar:))`. Families `.systemSmall`, `.systemMedium`, `.accessoryRectangular`; gallery name "Daily Reflection" (nothing faith-identifying). Lock screen content is `.privacySensitive()`; discreet shows theme only.

- [ ] **Step 1: Build**, add each widget family on the simulator, confirm content matches Today.
- [ ] **Step 2: Toggle tradition and discreet mode in the app** → widgets update without re-adding.
- [ ] **Step 3: Commit.**

### Task 6: CI, docs and release gate

**Files:** `.github/workflows/ios.yml`, `README.md`

- [ ] **Step 1:** Workflow on `macos-15`: install XcodeGen, run the no-network grep (fails on `URLSession`, `WKWebView`, `http://`, `https://` in Swift), `xcodegen`, `xcodebuild test` on the first available iPhone simulator with `CODE_SIGNING_ALLOWED=NO`.
- [ ] **Step 2:** README: setup, App Group configuration, editing entries, regenerating texts.
- [ ] **Step 3:** Before release: all 90 days written and reviewed (`docs/CONTENT_REVIEW.md` sign-off), `testFullCatalogHasNinetyDays` no longer skipped, public-domain status confirmed per territory, app icon added.
