// Firebase initialization

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future initializeFirebaseApp(BuildContext context) async {
  await Firebase.initializeApp().then((_) {
    print('Firebase gets initialized');
  });
}
