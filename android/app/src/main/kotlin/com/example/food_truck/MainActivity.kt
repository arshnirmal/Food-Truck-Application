package com.example.food_truck

import io.flutter.embedding.android.FlutterActivity
import com.google.firebase.ktx.Firebase
import com.google.firebase.messaging.ktx.messaging

class MainActivity: FlutterActivity() {
    override fun onResume() {
        super.onResume()
        Firebase.messaging.isAutoInitEnabled = true
    }
}
