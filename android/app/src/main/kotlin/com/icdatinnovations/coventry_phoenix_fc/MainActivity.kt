package com.icdatinnovations.coventry_phoenix_fc

import android.window.SplashScreen
import io.flutter.embedding.android.FlutterActivity
//import io.flutter.embedding.android.SplashScreen
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {

    fun provideSplashScreen(): SplashView = SplashView()

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        flutterEngine
                .platformViewsController
                .registry
                .registerViewFactory("demo_native_view",
                        DemoNativeViewFactory()
                )
    }

}

