import 'package:flutter/material.dart';

class FirebaseProvider with ChangeNotifier {
  bool isFirebaseStateInitialized = false;
  bool userLoginState = false;

  get getFirebaseState => isFirebaseStateInitialized;
  get getUserLoginState => userLoginState;

  mFirebaseState(bool value) {
    isFirebaseStateInitialized = value;
    print('notifyListeners firebaseState: $isFirebaseStateInitialized');
    notifyListeners();
  }

  mUserLoginState(bool value) {
    userLoginState = value;
    print('notifyListener userLoginState: $userLoginState');
    notifyListeners();
  }
}
