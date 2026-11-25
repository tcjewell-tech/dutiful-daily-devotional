package com.example.dutifuldailydevotional

import androidx.compose.ui.geometry.Rect
import androidx.compose.ui.geometry.Size
import org.junit.Assert.assertEquals
import org.junit.Assert.assertNull
import org.junit.Test

class OrientationTest {
    private val size = Size(400f, 800f)

    @Test
    fun spotlightSurroundsAReportedControl() {
        val rects = mapOf(OrientationTarget.STUDY to Rect(20f, 300f, 140f, 340f))
        assertEquals(Rect(14f, 294f, 146f, 346f), spotlight(listOf(OrientationTarget.STUDY), rects, size, pad = 6f))
    }

    @Test
    fun spotlightCoversEveryTargetOfAStep() {
        val rects = mapOf(
            OrientationTarget.ARCHIVE_TAB to Rect(100f, 720f, 200f, 800f),
            OrientationTarget.FAVORITES_TAB to Rect(200f, 720f, 300f, 800f),
        )
        val both = listOf(OrientationTarget.ARCHIVE_TAB, OrientationTarget.FAVORITES_TAB)
        assertEquals(Rect(100f, 720f, 300f, 800f), spotlight(both, rects, size, pad = 0f))
    }

    @Test
    fun noSpotlightWhenAControlIsUnknownEmptyOrOffScreen() {
        val study = listOf(OrientationTarget.STUDY)
        assertNull(spotlight(study, emptyMap(), size, pad = 6f))
        // A control scrolled out of view reports empty (clipped) bounds.
        assertNull(spotlight(study, mapOf(OrientationTarget.STUDY to Rect.Zero), size, pad = 6f))
        assertNull(spotlight(study, mapOf(OrientationTarget.STUDY to Rect(20f, 900f, 140f, 940f)), size, pad = 6f))
    }

    @Test
    fun everyStepHasAUniqueTitle() {
        val titles = OrientationStep.all.map { it.title }
        assertEquals(titles.size, titles.toSet().size)
    }
}
