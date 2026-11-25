package com.example.dutifuldailydevotional

import androidx.activity.compose.BackHandler
import androidx.compose.foundation.Canvas
import androidx.compose.foundation.gestures.detectTapGestures
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.BoxWithConstraints
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.offset
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Button
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.compositionLocalOf
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.mutableStateMapOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.geometry.CornerRadius
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.geometry.Rect
import androidx.compose.ui.geometry.RoundRect
import androidx.compose.ui.geometry.Size
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.Path
import androidx.compose.ui.graphics.PathFillType
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.input.pointer.pointerInput
import androidx.compose.ui.layout.boundsInRoot
import androidx.compose.ui.layout.onGloballyPositioned
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.semantics.heading
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp

/** What a walkthrough step points at. */
internal enum class OrientationTarget { READING, STUDY, ACTIONS, ARCHIVE_TAB, FAVORITES_TAB, SETTINGS_TAB, SOS, HELP }

/** One walkthrough step. The same list fills the Help screen, so the two always agree. Copy matches the iPhone app. */
internal class OrientationStep(val tab: Tab, val targets: List<OrientationTarget>, val title: String, val text: String) {
    companion object {
        val all = listOf(
            OrientationStep(
                Tab.TODAY, listOf(OrientationTarget.READING), "Today",
                "Each day brings one short passage and a reflection on it. It changes at midnight and needs no signal.",
            ),
            OrientationStep(
                Tab.TODAY, listOf(OrientationTarget.STUDY), "Study this",
                "Opens questions for reflection, a private note that never leaves this device, and the passage in context.",
            ),
            OrientationStep(
                Tab.TODAY, listOf(OrientationTarget.ACTIONS), "Add to favorites and Share",
                "Add to favorites keeps a reading for later. Share sends it to someone.",
            ),
            OrientationStep(
                Tab.ARCHIVE, listOf(OrientationTarget.ARCHIVE_TAB, OrientationTarget.FAVORITES_TAB), "Archive and Favorites",
                "Archive lists every reading from this year so far. Favorites lists the ones you kept.",
            ),
            // Android has no lock screen widget, so this step differs from the iPhone's.
            OrientationStep(
                Tab.SETTINGS, listOf(OrientationTarget.SETTINGS_TAB), "Settings",
                "Change your tradition here, or read about sources and privacy.",
            ),
            OrientationStep(
                Tab.TODAY, listOf(OrientationTarget.SOS), "SOS",
                "At the top of each tab. Lists crisis and support lines you can call, day or night.",
            ),
            OrientationStep(
                Tab.TODAY, listOf(OrientationTarget.HELP), "?",
                "At the top of each tab. Opens this guide again.",
            ),
        )
    }
}

/** Exists only while the walkthrough is showing: where each target is on screen, and which ones the current step lights. */
internal class OrientationState {
    val rects = mutableStateMapOf<OrientationTarget, Rect>()
    var targets by mutableStateOf(emptyList<OrientationTarget>())
}

internal val LocalOrientation = compositionLocalOf<OrientationState?> { null }

/** Reports this element's on-screen bounds while the walkthrough is showing; does nothing otherwise. */
internal fun Modifier.orientationTarget(state: OrientationState?, target: OrientationTarget?): Modifier =
    if (state == null || target == null) this else onGloballyPositioned { state.rects[target] = it.boundsInRoot() }

/**
 * The cut-out around every target of a step, or null when any of them is unknown or off screen
 * (then the card shows on its own).
 */
internal fun spotlight(targets: List<OrientationTarget>, rects: Map<OrientationTarget, Rect>, size: Size, pad: Float): Rect? {
    val found = targets.mapNotNull { rects[it] }.filter { !it.isEmpty }
    if (found.isEmpty() || found.size != targets.size) return null
    val hole = found.reduce { a, b ->
        Rect(minOf(a.left, b.left), minOf(a.top, b.top), maxOf(a.right, b.right), maxOf(a.bottom, b.bottom))
    }.inflate(pad)
    return if (hole.overlaps(Rect(Offset.Zero, size))) hole else null
}

/** Dims the app, cuts a spotlight around the control being described, and points an arrow at it. */
@Composable
internal fun OrientationOverlay(state: OrientationState, onStep: (Tab) -> Unit, finish: () -> Unit) {
    val steps = OrientationStep.all
    var index by rememberSaveable { mutableIntStateOf(0) }
    val step = steps[index]
    LaunchedEffect(index) {
        state.targets = step.targets
        onStep(step.tab)
    }
    BackHandler(onBack = finish)

    val density = LocalDensity.current
    val cardColor = MaterialTheme.colorScheme.surfaceContainerHigh
    // The empty tap handler swallows touches everywhere, including inside the cut-out.
    BoxWithConstraints(Modifier.fillMaxSize().pointerInput(Unit) { detectTapGestures { } }) {
        val size = Size(constraints.maxWidth.toFloat(), constraints.maxHeight.toFloat())
        val hole = spotlight(step.targets, state.rects, size, pad = with(density) { 6.dp.toPx() })
        Canvas(Modifier.fillMaxSize()) {
            val corner = CornerRadius(12.dp.toPx())
            val dim = Path().apply {
                fillType = PathFillType.EvenOdd
                addRect(Rect(Offset.Zero, this@Canvas.size))
                if (hole != null) addRoundRect(RoundRect(hole, corner))
            }
            drawPath(dim, Color.Black.copy(alpha = 0.6f))
            if (hole != null) drawRoundRect(Color.White, hole.topLeft, hole.size, corner, style = Stroke(2.dp.toPx()))
        }

        // The card goes on whichever side of the spotlight has more room.
        val cardBelow = hole != null && hole.center.y < size.height / 2
        val arrowX = with(density) { (hole?.center?.x ?: 0f).toDp() }.coerceIn(40.dp, maxWidth - 40.dp)
        // Capped so a very tall spotlight can't push the card off the screen.
        val screenHeight = maxHeight
        val cap = screenHeight * 0.55f
        Column(Modifier.fillMaxSize()) {
            if (hole != null && cardBelow) {
                Spacer(Modifier.height(minOf(with(density) { hole.bottom.toDp() } + 4.dp, cap)))
                Arrow(up = true, centerX = arrowX, color = cardColor)
                Card(step, index, steps.size, cardColor, onNext = { index++ }, finish = finish)
            } else {
                Spacer(Modifier.weight(1f))
                if (hole != null) {
                    Card(step, index, steps.size, cardColor, onNext = { index++ }, finish = finish)
                    Arrow(up = false, centerX = arrowX, color = cardColor)
                    Spacer(Modifier.height(minOf(screenHeight - with(density) { hole.top.toDp() } + 4.dp, cap)))
                } else {
                    Card(
                        step, index, steps.size, cardColor, onNext = { index++ }, finish = finish,
                        modifier = Modifier.navigationBarsPadding().padding(bottom = 96.dp),
                    )
                }
            }
        }
    }
}

@Composable
private fun Arrow(up: Boolean, centerX: Dp, color: Color) {
    Canvas(Modifier.offset(x = centerX - 14.dp).size(28.dp, 14.dp)) {
        val triangle = Path().apply {
            if (up) {
                moveTo(size.width / 2, 0f); lineTo(size.width, size.height); lineTo(0f, size.height)
            } else {
                moveTo(0f, 0f); lineTo(size.width, 0f); lineTo(size.width / 2, size.height)
            }
            close()
        }
        drawPath(triangle, color)
    }
}

@Composable
private fun Card(
    step: OrientationStep,
    index: Int,
    count: Int,
    color: Color,
    onNext: () -> Unit,
    finish: () -> Unit,
    modifier: Modifier = Modifier,
) {
    val isLast = index == count - 1
    Surface(
        color = color,
        shape = RoundedCornerShape(16.dp),
        modifier = modifier.padding(horizontal = 16.dp).fillMaxWidth(),
    ) {
        Column(Modifier.padding(16.dp), verticalArrangement = Arrangement.spacedBy(12.dp)) {
            Text(step.title, style = MaterialTheme.typography.titleLarge, modifier = Modifier.semantics { heading() })
            Text(step.text)
            Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                Text(
                    "${index + 1} of $count",
                    style = MaterialTheme.typography.bodySmall,
                    color = MaterialTheme.colorScheme.onSurfaceVariant,
                    modifier = Modifier.weight(1f).padding(top = 14.dp),
                )
                if (!isLast) TextButton(onClick = finish) { Text("Skip") }
                Button(onClick = if (isLast) finish else onNext) { Text(if (isLast) "Done" else "Next") }
            }
        }
    }
}
