@file:OptIn(ExperimentalMaterial3Api::class)

package com.example.dutifuldailydevotional

import android.content.Context
import android.content.Intent
import android.net.Uri
import androidx.activity.compose.BackHandler
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.selection.selectable
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.ArrowBack
import androidx.compose.material.icons.filled.DateRange
import androidx.compose.material.icons.filled.Favorite
import androidx.compose.material.icons.filled.FavoriteBorder
import androidx.compose.material.icons.filled.Home
import androidx.compose.material.icons.filled.Phone
import androidx.compose.material.icons.filled.Settings
import androidx.compose.material.icons.filled.Share
import androidx.compose.material3.Button
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.ListItem
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.NavigationBar
import androidx.compose.material3.NavigationBarItem
import androidx.compose.material3.OutlinedButton
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.RadioButton
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBar
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.semantics.Role
import androidx.compose.ui.semantics.heading
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import java.time.LocalDate
import java.time.format.DateTimeFormatter
import java.time.format.FormatStyle

private enum class Tab(val label: String) { TODAY("Today"), ARCHIVE("Archive"), FAVORITES("Favorites"), SETTINGS("Settings") }

/** Screens pushed over the tabs, saved as strings so they survive rotation: "detail:<id>", "study:<id>", "talk", "about". */
@Composable
fun App(userData: UserData) {
    val context = LocalContext.current
    var tradition by remember { mutableStateOf(userData.tradition) }
    var stack by rememberSaveable { mutableStateOf(listOf<String>()) }
    var tab by rememberSaveable { mutableStateOf(Tab.TODAY) }
    val push: (String) -> Unit = { stack = stack + it }
    val back: () -> Unit = { stack = stack.dropLast(1) }
    BackHandler(enabled = stack.isNotEmpty(), onBack = back)

    val current = tradition
    if (current == null) {
        OnboardingScreen { chosen ->
            userData.tradition = chosen
            tradition = chosen
            DevotionalWidget.updateAll(context)
        }
        return
    }

    val top = stack.lastOrNull()
    when {
        top == "talk" -> PushedScreen("Need to talk?", back) { NeedToTalkContent() }
        top == "about" -> PushedScreen("Sources and privacy", back) { AboutContent() }
        top != null && top.startsWith("detail:") -> {
            val d = ContentRepository.byId(context, top.removePrefix("detail:"))
            PushedScreen(d?.theme ?: "", back) {
                if (d == null) Unavailable() else DevotionalContent(d, userData) { push("study:${d.id}") }
            }
        }
        top != null && top.startsWith("study:") -> {
            val d = ContentRepository.byId(context, top.removePrefix("study:"))
            PushedScreen("Study", back) { if (d == null) Unavailable() else StudyContent(d, userData) }
        }
        else -> Scaffold(
            topBar = {
                TopAppBar(
                    title = { Text(tab.label) },
                    actions = {
                        if (tab == Tab.TODAY) {
                            IconButton(onClick = { push("talk") }) { Icon(Icons.Filled.Phone, "Need to talk?") }
                        }
                    },
                )
            },
            bottomBar = {
                NavigationBar {
                    Tab.entries.forEach { t ->
                        NavigationBarItem(
                            selected = t == tab,
                            onClick = { tab = t },
                            icon = { Icon(t.icon(), null) },
                            label = { Text(t.label) },
                        )
                    }
                }
            },
        ) { padding ->
            Box(Modifier.padding(padding)) {
                when (tab) {
                    Tab.TODAY -> TodayContent(current, userData) { push("study:$it") }
                    Tab.ARCHIVE -> ArchiveContent(current) { push("detail:$it") }
                    Tab.FAVORITES -> FavoritesContent(userData) { push("detail:$it") }
                    Tab.SETTINGS -> SettingsContent(
                        selected = current,
                        onSelect = {
                            userData.tradition = it
                            tradition = it
                            DevotionalWidget.updateAll(context)
                        },
                        onNeedToTalk = { push("talk") },
                        onAbout = { push("about") },
                    )
                }
            }
        }
    }
}

private fun Tab.icon() = when (this) {
    Tab.TODAY -> Icons.Filled.Home
    Tab.ARCHIVE -> Icons.Filled.DateRange
    Tab.FAVORITES -> Icons.Filled.Favorite
    Tab.SETTINGS -> Icons.Filled.Settings
}

@Composable
private fun PushedScreen(title: String, onBack: () -> Unit, content: @Composable () -> Unit) {
    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text(title) },
                navigationIcon = {
                    IconButton(onClick = onBack) { Icon(Icons.AutoMirrored.Filled.ArrowBack, "Back") }
                },
            )
        },
    ) { padding -> Box(Modifier.padding(padding)) { content() } }
}

@Composable
private fun Heading(text: String) {
    Text(text, style = MaterialTheme.typography.titleMedium, modifier = Modifier.semantics { heading() })
}

@Composable
private fun OnboardingScreen(onChoose: (Tradition) -> Unit) {
    Scaffold { padding ->
        Column(
            Modifier.padding(padding).verticalScroll(rememberScrollState()).padding(16.dp),
            verticalArrangement = Arrangement.spacedBy(16.dp),
        ) {
            Text(
                "Dutiful Daily Devotional",
                style = MaterialTheme.typography.headlineLarge,
                modifier = Modifier.semantics { heading() },
            )
            Text("Choose the tradition for your daily reading. You can change it any time in Settings.")
            Tradition.entries.forEach { tradition ->
                OutlinedButton(onClick = { onChoose(tradition) }, modifier = Modifier.fillMaxWidth()) {
                    Column(Modifier.fillMaxWidth().padding(vertical = 6.dp)) {
                        Text(tradition.displayName, style = MaterialTheme.typography.titleMedium)
                        Text(tradition.sourceName, style = MaterialTheme.typography.bodySmall)
                    }
                }
            }
            Text(
                "Works fully offline. Nothing you read or write here leaves your device.",
                style = MaterialTheme.typography.bodySmall,
            )
        }
    }
}

@Composable
private fun TodayContent(tradition: Tradition, userData: UserData, onStudy: (String) -> Unit) {
    val context = LocalContext.current
    // shortcut: "today" is read whenever this tab is shown; an app left open across midnight updates on the next tab switch.
    val devotional = ContentRepository.today(context, tradition)
    if (devotional == null) {
        Unavailable()
    } else {
        DevotionalContent(devotional, userData) { onStudy(devotional.id) }
    }
}

@Composable
private fun Unavailable() {
    Text("Content unavailable", modifier = Modifier.padding(16.dp))
}

/** One reading with its actions. Used by Today, Archive and Favorites. */
@Composable
private fun DevotionalContent(devotional: Devotional, userData: UserData, onStudy: () -> Unit) {
    val context = LocalContext.current
    var favorite by remember(devotional.id) { mutableStateOf(userData.isFavorite(devotional.id)) }
    Column(
        Modifier.fillMaxSize().verticalScroll(rememberScrollState()).padding(16.dp),
        verticalArrangement = Arrangement.spacedBy(16.dp),
    ) {
        Text(
            devotional.theme,
            style = MaterialTheme.typography.headlineMedium,
            fontWeight = FontWeight.Bold,
            modifier = Modifier.semantics { heading() },
        )
        Column(Modifier.semantics(mergeDescendants = true) {}, verticalArrangement = Arrangement.spacedBy(6.dp)) {
            Text(devotional.passageText, style = MaterialTheme.typography.titleLarge)
            Text(devotional.reference, style = MaterialTheme.typography.bodyMedium, color = MaterialTheme.colorScheme.onSurfaceVariant)
        }
        HorizontalDivider()
        Text(devotional.reflection, style = MaterialTheme.typography.bodyLarge)
        Button(onClick = onStudy) { Text("Study this") }
        Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
            OutlinedButton(onClick = {
                favorite = !favorite
                userData.setFavorite(devotional.id, favorite)
            }) {
                Icon(if (favorite) Icons.Filled.Favorite else Icons.Filled.FavoriteBorder, null)
                Text(if (favorite) "  Remove from favorites" else "  Add to favorites")
            }
            OutlinedButton(onClick = { share(context, devotional.shareText) }) {
                Icon(Icons.Filled.Share, null)
                Text("  Share")
            }
        }
    }
}

/** User-initiated only, through the system share sheet. */
private fun share(context: Context, text: String) {
    val send = Intent(Intent.ACTION_SEND).setType("text/plain").putExtra(Intent.EXTRA_TEXT, text)
    context.startActivity(Intent.createChooser(send, null))
}

@Composable
private fun StudyContent(devotional: Devotional, userData: UserData) {
    val context = LocalContext.current
    var note by rememberSaveable(devotional.id) { mutableStateOf(userData.note(devotional.id)) }
    val inContext = remember(devotional.id) { ContentRepository.division(context, devotional) }
    Column(
        Modifier.fillMaxSize().verticalScroll(rememberScrollState()).padding(16.dp),
        verticalArrangement = Arrangement.spacedBy(20.dp),
    ) {
        Column(verticalArrangement = Arrangement.spacedBy(4.dp)) {
            Text(devotional.theme, style = MaterialTheme.typography.headlineSmall, modifier = Modifier.semantics { heading() })
            Text(devotional.reference, color = MaterialTheme.colorScheme.onSurfaceVariant)
        }
        Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
            Heading("Questions for reflection")
            devotional.studyPrompts.forEachIndexed { i, prompt -> Text("${i + 1}. $prompt") }
        }
        Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
            Heading("Private note")
            OutlinedTextField(
                value = note,
                onValueChange = {
                    note = it
                    userData.setNote(devotional.id, it)
                },
                modifier = Modifier.fillMaxWidth().heightIn(min = 160.dp),
                label = { Text("Private note") },
            )
            Text("Stored only on this device. Never shown in the widget.", style = MaterialTheme.typography.bodySmall)
        }
        Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
            Heading("In context")
            if (inContext == null) {
                // Full texts not bundled yet, or the reference can't be parsed: show the passage alone.
                Text(devotional.passageText)
                Text(devotional.reference, color = MaterialTheme.colorScheme.onSurfaceVariant)
            } else {
                val (reference, division) = inContext
                division.verses.forEach { verse ->
                    val highlighted = reference.contains(verse.number)
                    Surface(
                        color = if (highlighted) MaterialTheme.colorScheme.primaryContainer else MaterialTheme.colorScheme.surface,
                        shape = MaterialTheme.shapes.small,
                        modifier = Modifier.fillMaxWidth().semantics(mergeDescendants = true) {},
                    ) {
                        Text("${verse.number}  ${verse.text}", modifier = Modifier.padding(if (highlighted) 6.dp else 0.dp))
                    }
                }
            }
        }
    }
}

@Composable
private fun ArchiveContent(tradition: Tradition, onOpen: (String) -> Unit) {
    val context = LocalContext.current
    val entries = ContentRepository.devotionals(context, tradition)
    if (entries.isEmpty()) return Unavailable()
    val dates = remember { DevotionalProvider.datesThisYear(LocalDate.now()).reversed() }
    val format = remember { DateTimeFormatter.ofLocalizedDate(FormatStyle.MEDIUM) }
    LazyColumn(contentPadding = PaddingValues(vertical = 8.dp)) {
        items(dates) { date ->
            DevotionalProvider.devotional(entries, date)?.let { d ->
                ListItem(
                    overlineContent = { Text(date.format(format)) },
                    headlineContent = { Text(d.theme) },
                    modifier = Modifier.clickable { onOpen(d.id) },
                )
            }
        }
    }
}

@Composable
private fun FavoritesContent(userData: UserData, onOpen: (String) -> Unit) {
    val context = LocalContext.current
    val favorites = remember { userData.favorites().mapNotNull { ContentRepository.byId(context, it) } }
    if (favorites.isEmpty()) {
        Text("No favorites yet. Tap the heart on any reading to keep it here.", modifier = Modifier.padding(16.dp))
        return
    }
    LazyColumn {
        items(favorites, key = { it.id }) { d ->
            ListItem(
                headlineContent = { Text(d.theme) },
                supportingContent = { Text(d.reference) },
                modifier = Modifier.clickable { onOpen(d.id) },
            )
        }
    }
}

@Composable
private fun SettingsContent(
    selected: Tradition,
    onSelect: (Tradition) -> Unit,
    onNeedToTalk: () -> Unit,
    onAbout: () -> Unit,
) {
    Column(Modifier.verticalScroll(rememberScrollState()).padding(vertical = 8.dp)) {
        Text("Tradition", style = MaterialTheme.typography.titleSmall, modifier = Modifier.padding(horizontal = 16.dp))
        Tradition.entries.forEach { tradition ->
            ListItem(
                headlineContent = { Text(tradition.displayName) },
                leadingContent = { RadioButton(selected = tradition == selected, onClick = null) },
                modifier = Modifier.selectable(tradition == selected, role = Role.RadioButton) { onSelect(tradition) },
            )
        }
        HorizontalDivider()
        ListItem(headlineContent = { Text("Need to talk?") }, modifier = Modifier.clickable(onClick = onNeedToTalk))
        ListItem(headlineContent = { Text("Sources and privacy") }, modifier = Modifier.clickable(onClick = onAbout))
    }
}

/** Static and offline. The only action opens the phone dialer; the user places the call. */
@Composable
private fun NeedToTalkContent() {
    val context = LocalContext.current
    Column(
        Modifier.verticalScroll(rememberScrollState()).padding(16.dp),
        verticalArrangement = Arrangement.spacedBy(16.dp),
    ) {
        Text("If you are struggling or thinking about harming yourself, you don't have to face it alone. Help is available 24 hours a day.")
        Heading("Military/Veterans Crisis Line")
        Button(onClick = { context.startActivity(Intent(Intent.ACTION_DIAL, Uri.parse("tel:988"))) }) {
            Icon(Icons.Filled.Phone, null)
            Text("  Call 988, then press 1")
        }
        Text("Or text 838255.")
        Heading("Chaplain")
        Text("You can also talk with your unit chaplain, whatever your faith or none.")
    }
}

@Composable
private fun AboutContent() {
    Column(
        Modifier.verticalScroll(rememberScrollState()).padding(16.dp),
        verticalArrangement = Arrangement.spacedBy(12.dp),
    ) {
        Heading("Privacy")
        Text("This app has no network access, no accounts, no analytics and no ads. Favorites and notes stay on this device and are excluded from backups.")
        Heading("Sources")
        Tradition.entries.forEach {
            Text(it.displayName, fontWeight = FontWeight.Bold)
            Text(it.sourceAttribution)
        }
        Heading("Reflections")
        Text("Daily reflections and study questions are written for this app.")
    }
}
