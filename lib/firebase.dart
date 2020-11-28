import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';

String firebaseState = '';

initializeFirebaseApp() {
  Firebase.initializeApp().then((_) {
    print('Firebase gets initialized');
    firebaseState = 'Firebase initialized successfully';
  });
}
