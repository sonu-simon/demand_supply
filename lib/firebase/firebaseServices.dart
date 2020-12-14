import 'package:demand_supply/firebase/firebaseData.dart';
import 'package:demand_supply/screens/login/otpPage.dart';
import 'package:demand_supply/screens/signup/signupPage.dart';

import '../providerData.dart';
import '../screens/homepage.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../data.dart';

// Firebase initialization

Future initializeFirebaseApp(BuildContext context) async {
  final firebaseProvider =
      Provider.of<FirebaseProvider>(context, listen: false);

  await Firebase.initializeApp().then((_) {
    print('Firebase gets initialized');
    firebaseProvider.mFirebaseState(true);
    setupFirebaseAuth(context);
  });
}

// FirebaseAUTH

FirebaseAuth auth;

setupFirebaseAuth(BuildContext context) {
  auth = FirebaseAuth.instance;

  final firebaseProvider =
      Provider.of<FirebaseProvider>(context, listen: false);

  //listen to changes in userLoginState.
  auth.authStateChanges().listen((User user) {
    if (user == null) {
      print('User is currently signed out!');
      firebaseProvider.mUserLoginState(false);

      Navigator.canPop(context);
    } else {
      print('User is signed in!');
      currentUserID = user.uid;
      firebaseProvider.mUserLoginState(true);
    }
  });
}

authSignOut() {
  print('signing out');
  auth.signOut();
}

loginWithPhoneNumber(String phoneNumber, BuildContext context) async {
  await auth.verifyPhoneNumber(
    phoneNumber: phoneNumber,
    verificationCompleted: (PhoneAuthCredential credential) async {
      //only on ANDROID ____ Sign the user in with auto-generated credential
      await auth.signInWithCredential(credential).then((_) async {
        // if (auth.currentUser != null) {
        //   if (await checkIfUserProfileExists(auth.currentUser.uid))
        //     Navigator.pushReplacement(
        //         context, MaterialPageRoute(builder: (context) => HomePage()));
        //   else
        //     Navigator.pushReplacement(
        //         context, MaterialPageRoute(builder: (context) => SignUpPage()));
        // }
      });
    },
    verificationFailed: (FirebaseAuthException e) {
      print('The following error occurred: $e');
    },
    codeSent: (String verificationId, int resendToken) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EnterOtpScreen(
                  verificationId: verificationId, resendToken: resendToken)));
    },
    codeAutoRetrievalTimeout: (String verificationId) {
      print('codeAutoRetrieval timed out');
    },
  );
}
