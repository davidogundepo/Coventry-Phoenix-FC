package com.icdatinnovations.coventry_phoenix_fc

import android.content.Context
import android.graphics.Color
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.FrameLayout
import android.window.SplashScreen
//import io.flutter.embedding.android.SplashScreen

class SplashView : SplashScreen {

    private val nullParent: ViewGroup? = null

    fun createSplashView(context: Context, savedInstanceState: Bundle?): View {
        val rootView = FrameLayout(context)
        rootView.apply {
            layoutParams = FrameLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT,
                ViewGroup.LayoutParams.MATCH_PARENT
            )

            setBackgroundColor(Color.parseColor("#212529"))
            addView(LayoutInflater.from(context).inflate(R.layout.splash_view, nullParent, false))

        }
        return rootView
    }


    fun transitionToFlutter(onTransitionComplete: Runnable) {
        Handler(Looper.getMainLooper()).postDelayed(onTransitionComplete,5700)
    }

    override fun setOnExitAnimationListener(p0: SplashScreen.OnExitAnimationListener) {
        TODO("Not yet implemented")
    }

    override fun clearOnExitAnimationListener() {
        TODO("Not yet implemented")
    }

    override fun setSplashScreenTheme(p0: Int) {
        TODO("Not yet implemented")
    }
}