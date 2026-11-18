import XCTest
@testable import DutifulDailyDevotional

/// Every devotional's passage must match the bundled full text for its reference.
final class ContentIntegrityTests: XCTestCase {
    private func normalized(_ text: String) -> String {
        text.split(whereSeparator: \.isWhitespace).joined(separator: " ")
    }

    func testEveryPassageMatchesBundledFullText() throws {
        let texts = LocalTextStore()
        var checked = 0
        for tradition in Tradition.allCases {
            // A tradition whose full texts are not converted yet (scripts/) is skipped, not failed.
            let bundled = Bundle.main.urls(forResourcesWithExtension: "json", subdirectory: "Texts/\(tradition.textDirectory)") ?? []
            guard !bundled.isEmpty else { continue }
            for entry in DevotionalStore().devotionals(for: tradition) {
                let reference = try XCTUnwrap(SourceReference.parse(entry.reference, tradition: tradition), entry.id)
                let full = texts.passageText(for: reference, tradition: tradition)
                XCTAssertEqual(full.map(normalized), normalized(entry.passageText), entry.id)
                checked += 1
            }
        }
        try XCTSkipIf(checked == 0, "Full source texts are not bundled yet")
    }
}
