package com.icdatinnovations.coventry_phoenix_fc

import android.content.Context
import android.graphics.Color
import android.view.View
import android.widget.TextView
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

internal class MainViewModel(context: Context, id: Int, creationParams: Map<String?, Any?>?) : PlatformView {

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

//class DemoNativeViewFactory : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
//    override fun create(context: Context?, id: Int, args: Any?): PlatformView {
//        if (context == null) {
//            throw IllegalArgumentException("Context must not be null")
//        }
//        return MainViewModel(context, id)
//    }
//}

class DemoNativeViewFactory : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context?, id: Int, args: Any?): PlatformView {
        val creationParams = args as Map<String?, Any?>?
        return MainViewModel(context!!, id, creationParams)
    }
}