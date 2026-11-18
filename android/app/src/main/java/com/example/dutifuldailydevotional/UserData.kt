package com.example.dutifuldailydevotional

import android.content.Context

/**
 * App-private storage (excluded from backup and device transfer in the manifest).
 * The widget reads only the selected tradition, never favorites or notes.
 */
class UserData(context: Context) {
    private val settings = context.getSharedPreferences("settings", Context.MODE_PRIVATE)
    private val data = context.getSharedPreferences("user_data", Context.MODE_PRIVATE)

    var tradition: Tradition?
        get() = Tradition.fromKey(settings.getString(KEY_TRADITION, null))
        set(value) = settings.edit().putString(KEY_TRADITION, value?.key).apply()

    fun isFavorite(id: String): Boolean = data.contains(FAVORITE + id)

    fun setFavorite(id: String, favorite: Boolean) {
        val editor = data.edit()
        if (favorite) editor.putLong(FAVORITE + id, System.currentTimeMillis()) else editor.remove(FAVORITE + id)
        editor.apply()
    }

    /** Favorite ids, newest first. */
    fun favorites(): List<String> = data.all
        .filterKeys { it.startsWith(FAVORITE) }
        .entries.sortedByDescending { it.value as? Long ?: 0L }
        .map { it.key.removePrefix(FAVORITE) }

    fun note(id: String): String = data.getString(NOTE + id, "") ?: ""

    fun setNote(id: String, text: String) {
        val editor = data.edit()
        if (text.isEmpty()) editor.remove(NOTE + id) else editor.putString(NOTE + id, text)
        editor.apply()
    }

    private companion object {
        const val KEY_TRADITION = "selectedTradition"
        const val FAVORITE = "favorite:"
        const val NOTE = "note:"
    }
}
