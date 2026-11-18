package com.example.dutifuldailydevotional

import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertNotNull
import org.junit.Assert.assertNull
import org.junit.Assert.assertTrue
import org.junit.Test
import java.io.File
import java.time.LocalDate

/** Mirrors the iOS DevotionalProvider, SourceReference, content and LocalTextStore tests. */
class ContentTest {
    // Unit tests run with the module directory (android/app) as the working directory.
    private val repoRoot = File("../..")

    private fun entries(t: Tradition) =
        DevotionalParser.parse(File(repoRoot, "Shared/Resources/Devotionals/${t.key}.json").readText(), t)

    private fun index(y: Int, m: Int, d: Int) = DevotionalProvider.index(LocalDate.of(y, m, d).dayOfYear, 90)

    @Test fun dayIndexMatchesSpec() {
        assertEquals(1, index(2027, 1, 1))
        assertEquals(365 % 90, index(2026, 12, 31))
        assertEquals(366 % 90, index(2028, 12, 31))
        assertEquals(60, index(2028, 2, 29))
        assertEquals(index(2027, 1, 1), index(2026, 12, 27)) // accepted year-rollover repeat
        assertEquals(0, DevotionalProvider.index(5, 0))
    }

    @Test fun archiveDatesRunFromJanuaryFirstThroughToday() {
        val dates = DevotionalProvider.datesThisYear(LocalDate.of(2028, 3, 1))
        assertEquals(61, dates.size)
        assertEquals(LocalDate.of(2028, 1, 1), dates.first())
        assertEquals(LocalDate.of(2028, 3, 1), dates.last())
    }

    @Test fun everyTraditionDecodesWithContiguousDaysAndSharedThemes() {
        val christian = entries(Tradition.CHRISTIAN)
        assertFalse(christian.isEmpty())
        for (t in Tradition.entries) {
            val e = entries(t)
            assertEquals("$t days", (1..christian.size).toList(), e.map { it.day })
            assertEquals("$t themes", christian.map { it.theme }, e.map { it.theme })
            assertTrue(e.size <= 180)
            for (d in e) {
                assertEquals(d.id, 3, d.studyPrompts.size)
                assertTrue(d.id, (d.studyPrompts + listOf(d.theme, d.reference, d.passageText, d.reflection)).all { it.isNotBlank() })
                assertNotNull(d.id, SourceReference.parse(d.reference, t))
            }
        }
    }

    @Test fun wrongTraditionOrMalformedJsonGivesNoEntries() {
        val christianJson = File(repoRoot, "Shared/Resources/Devotionals/christian.json").readText()
        assertTrue(DevotionalParser.parse(christianJson, Tradition.JEWISH).isEmpty())
        assertTrue(DevotionalParser.parse("{not json", Tradition.CHRISTIAN).isEmpty())
    }

    @Test fun referencesParseLikeIos() {
        assertEquals(SourceReference("John", 14, 27..27), SourceReference.parse("John 14:27", Tradition.CHRISTIAN))
        assertEquals(SourceReference("1 John", 4, 19..19), SourceReference.parse("1 John 4:19", Tradition.CHRISTIAN))
        assertEquals(SourceReference("Philippians", 4, 6..7), SourceReference.parse("Philippians 4:6-7", Tradition.CHRISTIAN))
        assertEquals(SourceReference("94", 94, 5..6), SourceReference.parse("Qur'an 94:5-6", Tradition.MUSLIM))
        assertEquals(SourceReference("94", 94, 5..5), SourceReference.parse("Qur’an 94:5", Tradition.MUSLIM))
        assertEquals(SourceReference("Meditations", 4, 3..3), SourceReference.parse("Meditations 4.3", Tradition.HUMANIST))
        assertEquals(SourceReference("Enchiridion", 5, null), SourceReference.parse("Enchiridion 5", Tradition.HUMANIST))
        assertEquals(SourceReference("Letters", 13, 4..4), SourceReference.parse("Seneca, Letters 13.4", Tradition.HUMANIST))
        for (bad in listOf("", "John", "John 14", "John 14:9-3", "John 0:1")) {
            assertNull(bad, SourceReference.parse(bad, Tradition.CHRISTIAN))
        }
        assertNull(SourceReference.parse("Qur'an 115:1", Tradition.MUSLIM))
        assertNull(SourceReference.parse("Meditations 4:3", Tradition.HUMANIST))
        assertNull(SourceReference.parse("Enchiridion 0", Tradition.HUMANIST))
    }

    @Test fun fullTextLookupUsesSharedFixture() {
        val json = File(repoRoot, "DutifulDailyDevotionalTests/Fixtures/Texts/web/John.json").readText()
        val division = LocalText.division(json, 14)!!
        assertEquals(listOf(26, 27, 28), division.verses.map { it.number })
        val text = LocalText.passageText(division, SourceReference("John", 14, 27..28))!!
        assertTrue(text.startsWith("Peace I leave with you.") && text.endsWith("for the Father is greater than I."))
        assertNull(LocalText.passageText(division, SourceReference("John", 14, 28..30)))
        assertNull(LocalText.division(json, 15))
    }
}
