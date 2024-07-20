package com.icdatinnovations.coventry_phoenix_fc

import android.content.Context
import android.graphics.Color
import android.os.Handler
import android.os.Looper
import android.view.LayoutInflater
import android.view.View
import android.widget.FrameLayout

class SplashView(private val context: Context) {

    private val rootView: FrameLayout by lazy {
        FrameLayout(context).apply {
            layoutParams = FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.MATCH_PARENT,
                FrameLayout.LayoutParams.MATCH_PARENT
            )
            setBackgroundColor(Color.parseColor("#212529"))
        }
    }

    fun createSplashView(): View {
        val inflater = LayoutInflater.from(context)
        inflater.inflate(R.layout.splash_view, rootView, true)
        return rootView
    }

    fun transitionToFlutter(onTransitionComplete: Runnable) {
        Handler(Looper.getMainLooper()).postDelayed(onTransitionComplete, 5700)
    }
}
