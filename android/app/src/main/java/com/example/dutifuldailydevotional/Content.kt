package com.example.dutifuldailydevotional

import android.content.Context
import org.json.JSONException
import org.json.JSONObject
import java.io.IOException
import java.time.LocalDate

/** Mirrors `Shared/Tradition.swift`; `key` matches the JSON file names and `tradition` field. */
enum class Tradition(
    val displayName: String,
    val sourceName: String,
    val sourceAttribution: String,
    val textDirectory: String,
) {
    CHRISTIAN(
        "Christian", "World English Bible",
        "Scripture from the World English Bible (WEB), which is in the public domain.", "web",
    ),
    JEWISH(
        "Jewish", "JPS 1917 Tanakh",
        "Scripture from The Holy Scriptures According to the Masoretic Text (Jewish Publication Society, 1917), " +
            "which is in the public domain. Verse numbers follow the Hebrew text.", "jps1917",
    ),
    MUSLIM(
        "Muslim", "The Qur'an, Pickthall translation",
        "Qur'an text from The Meaning of the Glorious Koran, translated by Marmaduke Pickthall (1930), " +
            "in the public domain in the United States.", "pickthall",
    ),
    HUMANIST(
        "Humanist", "Stoic writings: Marcus Aurelius, Epictetus, Seneca",
        "Marcus Aurelius, Meditations, and Epictetus, Enchiridion, translated by George Long; Seneca, Moral " +
            "Letters to Lucilius, translated by Richard M. Gummere. All in the public domain.", "stoics",
    );

    val key: String get() = name.lowercase()

    companion object {
        fun fromKey(key: String?): Tradition? = entries.firstOrNull { it.key == key }
    }
}

data class Devotional(
    val tradition: Tradition,
    val day: Int,
    val theme: String,
    val reference: String,
    val passageText: String,
    val reflection: String,
    val studyPrompts: List<String>,
) {
    /** Same id format as iOS, e.g. "christian-1". Keys favorites and notes. */
    val id: String get() = "${tradition.key}-$day"
    val shareText: String get() = "$passageText\n— $reference"
}

object DevotionalParser {
    /** Entries sorted by day; malformed content yields an empty list (tests catch it before release). */
    fun parse(json: String, tradition: Tradition): List<Devotional> = try {
        val root = JSONObject(json)
        if (root.getString("tradition") != tradition.key) {
            emptyList()
        } else {
            val entries = root.getJSONArray("entries")
            (0 until entries.length()).map { i ->
                val e = entries.getJSONObject(i)
                val prompts = e.getJSONArray("studyPrompts")
                Devotional(
                    tradition, e.getInt("day"), e.getString("theme"), e.getString("reference"),
                    e.getString("passageText"), e.getString("reflection"),
                    (0 until prompts.length()).map(prompts::getString),
                )
            }.sortedBy { it.day }
        }
    } catch (e: JSONException) {
        emptyList()
    }
}

/** Same rule as iOS (spec §5), so both platforms show the same entry on the same date. */
object DevotionalProvider {
    fun index(dayOfYear: Int, count: Int): Int = if (count > 0) dayOfYear % count else 0

    /** `entries` must be sorted by day, as `DevotionalParser` returns them. */
    fun devotional(entries: List<Devotional>, date: LocalDate): Devotional? =
        entries.getOrNull(index(date.dayOfYear, entries.size))

    /** Jan 1 of `through`'s year through `through`. */
    fun datesThisYear(through: LocalDate): List<LocalDate> =
        generateSequence(through.withDayOfYear(1)) { it.plusDays(1) }.takeWhile { !it.isAfter(through) }.toList()
}

/** Mirrors `SourceReference.swift`: `work` is the file name under `<textDirectory>/`. */
data class SourceReference(val work: String, val division: Int, val verses: IntRange?) {
    fun contains(verse: Int): Boolean = verses?.contains(verse) ?: true

    companion object {
        private val bible = Regex("""(.+?) (\d+):(\d+)(?:-(\d+))?""")
        private val quran = Regex("""Qur['’]an (\d+):(\d+)(?:-(\d+))?""")
        private val enchiridion = Regex("""Enchiridion (\d+)""")
        private val stoic = Regex("""(Meditations|Seneca, Letters) (\d+)\.(\d+)(?:-(\d+))?""")

        fun parse(reference: String, tradition: Tradition): SourceReference? {
            val text = reference.trim()
            return when (tradition) {
                Tradition.CHRISTIAN, Tradition.JEWISH -> bible.matchEntire(text)?.groupValues?.let {
                    make(it[1], it[2], it[3], it[4])
                }
                Tradition.MUSLIM -> quran.matchEntire(text)?.groupValues?.let {
                    val surah = it[1].toIntOrNull()
                    if (surah == null || surah !in 1..114) null else make(surah.toString(), it[1], it[2], it[3])
                }
                Tradition.HUMANIST -> {
                    val chapter = enchiridion.matchEntire(text)
                    if (chapter != null) {
                        chapter.groupValues[1].toIntOrNull()?.takeIf { it > 0 }
                            ?.let { SourceReference("Enchiridion", it, null) }
                    } else {
                        stoic.matchEntire(text)?.groupValues?.let {
                            make(if (it[1] == "Meditations") "Meditations" else "Letters", it[2], it[3], it[4])
                        }
                    }
                }
            }
        }

        private fun make(work: String, division: String, first: String, last: String): SourceReference? {
            val d = division.toIntOrNull() ?: return null
            val a = first.toIntOrNull() ?: return null
            val b = if (last.isEmpty()) a else last.toIntOrNull() ?: return null
            if (d <= 0 || a <= 0 || b < a) return null
            return SourceReference(work, d, a..b)
        }
    }
}

data class TextVerse(val number: Int, val text: String)
data class TextDivision(val number: Int, val verses: List<TextVerse>)

/** Spec §4.3 full-text files. */
object LocalText {
    fun division(json: String, number: Int): TextDivision? = try {
        val divisions = JSONObject(json).getJSONArray("divisions")
        (0 until divisions.length()).map { divisions.getJSONObject(it) }
            .firstOrNull { it.getInt("number") == number }
            ?.let { d ->
                val verses = d.getJSONArray("verses")
                TextDivision(number, (0 until verses.length()).map {
                    val v = verses.getJSONObject(it)
                    TextVerse(v.getInt("number"), v.getString("text"))
                })
            }
    } catch (e: JSONException) {
        null
    }

    /** The referenced verses joined with spaces, or null if any is missing. */
    fun passageText(division: TextDivision, reference: SourceReference): String? {
        val verses = division.verses.filter { reference.contains(it.number) }
        if (verses.isEmpty() || (reference.verses != null && reference.verses.count() != verses.size)) return null
        return verses.joinToString(" ") { it.text }
    }
}

/** Loads bundled assets, caching each tradition's entries for the life of the process. */
object ContentRepository {
    private val cache = mutableMapOf<Tradition, List<Devotional>>()

    fun devotionals(context: Context, tradition: Tradition): List<Devotional> = synchronized(cache) {
        cache.getOrPut(tradition) {
            readAsset(context, "Devotionals/${tradition.key}.json")?.let { DevotionalParser.parse(it, tradition) }
                ?: emptyList()
        }
    }

    fun today(context: Context, tradition: Tradition, date: LocalDate = LocalDate.now()): Devotional? =
        DevotionalProvider.devotional(devotionals(context, tradition), date)

    fun byId(context: Context, id: String): Devotional? {
        val parts = id.split("-")
        val tradition = Tradition.fromKey(parts.getOrNull(0)) ?: return null
        val day = parts.getOrNull(1)?.toIntOrNull() ?: return null
        return devotionals(context, tradition).firstOrNull { it.day == day }
    }

    fun division(context: Context, devotional: Devotional): Pair<SourceReference, TextDivision>? {
        val reference = SourceReference.parse(devotional.reference, devotional.tradition) ?: return null
        val json = readAsset(context, "${devotional.tradition.textDirectory}/${reference.work}.json") ?: return null
        return LocalText.division(json, reference.division)?.let { reference to it }
    }

    private fun readAsset(context: Context, path: String): String? = try {
        context.assets.open(path).bufferedReader().use { it.readText() }
    } catch (e: IOException) {
        null
    }
}
