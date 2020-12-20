import 'package:demand_supply/firebase/firebaseData.dart';
import 'package:demand_supply/screens/dialogs.dart';
import 'package:demand_supply/screens/home/homePage.dart';
import 'package:demand_supply/screens/login/loginPage.dart';
import 'package:demand_supply/screens/login/otpPage.dart';

import '../providerData.dart';
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
    } else {
      print('User is signed in!');
      currentUserID = user.uid;
      firebaseProvider.mUserLoginState(true);
    }
  });
}

authSignOut(BuildContext context) {
  print('signing out');
  auth.signOut();
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => LoginScreen()));
}

loginWithPhoneNumber(String phoneNumber, BuildContext context) async {
  showLoading(context, true);
  await auth.verifyPhoneNumber(
    phoneNumber: phoneNumber,
    verificationCompleted: (PhoneAuthCredential credential) async {
      //TODO: implement AutoVerficationCompleted callback

      //only on ANDROID ____ Sign the user in with auto-generated credential

      // await auth.signInWithCredential(credential).then((_) async {
      //   // if (auth.currentUser != null) {
      //   //   if (await checkIfUserProfileExists(auth.currentUser.uid))
      //   //     Navigator.pushReplacement(
      //   //         context, MaterialPageRoute(builder: (context) => HomePage()));
      //   //   else
      //   //     Navigator.pushReplacement(
      //   //         context, MaterialPageRoute(builder: (context) => SignUpPage()));
      //   // }
      // });
    },
    verificationFailed: (FirebaseAuthException e) {
      print('The following error occurred: $e');
      if (e.code == 'invalid-phone-number')
        showErrorDialog(context,
            'The mobile number entered is invalid. Please enter a valid phone number.');
      else
        showErrorDialog(context, e.message);
    },
    codeSent: (String verificationId, int resendToken) {
      showLoading(context, false);
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

splashScreenLogic(BuildContext context) {
  if (auth.currentUser == null)
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  else {
    checkIfUserProfileExistsAndAdmin(auth.currentUser.uid);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }
}
