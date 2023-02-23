package com.icdatinnovations.coventry_phoenix_fc

import android.content.Context
import android.graphics.Color
import android.view.View
import android.widget.TextView
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

internal class MainViewModel(context: Context, id: Int) : PlatformView {

    private val textView: TextView = TextView(context)

    override fun getView(): View {
        return textView
    }

    override fun dispose() {}

    init {
        textView.textSize = 32f
        textView.setBackgroundColor(Color.rgb(255, 255, 255))
        val text = context.getString(R.string.native_view_text, id)
        textView.text = text
    }
}

class DemoNativeViewFactory : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context?, id: Int, args: Any?): PlatformView {
        args as? Map<*, *> // Add type check
        return MainViewModel(context!!, id)
    }
}


