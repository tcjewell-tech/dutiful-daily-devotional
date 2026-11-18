package com.example.dutifuldailydevotional

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.view.View
import android.widget.RemoteViews

/**
 * Home screen widget: theme, passage and reference for today. Never shows notes.
 * shortcut: refreshes every 30 minutes (updatePeriodMillis), so it can lag up to 30 minutes after midnight;
 * schedule an exact midnight alarm if that matters.
 */
class DevotionalWidget : AppWidgetProvider() {
    override fun onUpdate(context: Context, manager: AppWidgetManager, ids: IntArray) {
        manager.updateAppWidget(ids, views(context))
    }

    companion object {
        /** Called by the app when the tradition changes. */
        fun updateAll(context: Context) {
            val manager = AppWidgetManager.getInstance(context)
            val ids = manager.getAppWidgetIds(ComponentName(context, DevotionalWidget::class.java))
            if (ids.isNotEmpty()) manager.updateAppWidget(ids, views(context))
        }

        private fun views(context: Context): RemoteViews {
            val views = RemoteViews(context.packageName, R.layout.widget_devotional)
            val devotional = UserData(context).tradition?.let { ContentRepository.today(context, it) }
            if (devotional == null) {
                views.setTextViewText(R.id.widget_theme, "Daily reflection")
                views.setTextViewText(R.id.widget_passage, "Open the app to choose a tradition.")
                views.setViewVisibility(R.id.widget_reference, View.GONE)
            } else {
                views.setTextViewText(R.id.widget_theme, devotional.theme)
                views.setTextViewText(R.id.widget_passage, devotional.passageText)
                views.setTextViewText(R.id.widget_reference, devotional.reference)
                views.setViewVisibility(R.id.widget_reference, View.VISIBLE)
            }
            val open = PendingIntent.getActivity(
                context, 0, Intent(context, MainActivity::class.java),
                PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT,
            )
            views.setOnClickPendingIntent(R.id.widget_root, open)
            return views
        }
    }
}
