import 'package:flutter/material.dart';

class FirebaseProvider with ChangeNotifier {
  bool isFirebaseStateInitialized = false;
  bool userLoginState = false;
  bool isLoading = false;

  get getFirebaseState => isFirebaseStateInitialized;
  get getUserLoginState => userLoginState;
  get getLoadingState => isLoading;

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

  mLoadingState(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
