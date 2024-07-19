package com.icdatinnovations.coventry_phoenix_fc

import android.os.Bundle
import androidx.core.splashscreen.SplashScreen.Companion.installSplashScreen
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Install the splash screen
        installSplashScreen()

        // Initialize the splash screen
        val splashView = SplashView(this)
        setContentView(splashView.createSplashView())

        splashView.transitionToFlutter {
            // Your logic after splash screen transition
            runOnUiThread {
                // Transition to Flutter UI or remove splash screen
                // For example, you can use finish() if you want to close this activity
                finish()
            }
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        flutterEngine
            .platformViewsController
            .registry
            .registerViewFactory("demo_native_view", DemoNativeViewFactory())
    }
}
