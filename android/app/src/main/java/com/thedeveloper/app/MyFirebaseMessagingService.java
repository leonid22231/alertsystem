package com.thedeveloper.app;

import android.util.Log;

import androidx.annotation.NonNull;

import com.google.firebase.messaging.FirebaseMessagingService;
import com.google.firebase.messaging.RemoteMessage;
public class MyFirebaseMessagingService extends FirebaseMessagingService {
    private static final String TAG = "MyFirebaseMsgService";

    @Override
    public void onMessageReceived(@NonNull RemoteMessage message) {
        Log.d(TAG, "From: " + message.getFrom());

    }

    @Override
    public void onNewToken(@NonNull String token) {
        Log.d(TAG, "New token created "+token);
    }
}
