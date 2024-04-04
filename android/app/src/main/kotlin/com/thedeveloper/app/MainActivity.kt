package com.thedeveloper.app

import android.os.Build
import android.os.Bundle
import androidx.core.view.WindowCompat
import io.flutter.embedding.android.FlutterActivity
import com.yandex.mapkit.MapKitFactory


class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        MapKitFactory.setApiKey("bb5785d2-1dc5-4340-95f0-f4bd70f70baa");
        // Aligns the Flutter view vertically with the window.
        WindowCompat.setDecorFitsSystemWindows(getWindow(), false)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            // Disable the Android splash screen fade out animation to avoid
            // a flicker before the similar frame is drawn in Flutter.
            splashScreen.setOnExitAnimationListener { splashScreenView -> splashScreenView.remove() }
        }

        super.onCreate(savedInstanceState)
    }
}
