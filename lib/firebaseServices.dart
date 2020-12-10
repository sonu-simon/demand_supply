import 'dart:io';

import 'package:demand_supply/firebaseData.dart';

import 'providerData.dart';
import 'screens/homepage.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Firebase initialization

Future initializeFirebaseApp(BuildContext context) {
  final firebaseProvider =
      Provider.of<FirebaseProvider>(context, listen: false);

  Firebase.initializeApp().then((_) {
    print('Firebase gets initialized');
    retrieveListOfLocalities();
    firebaseProvider.mFirebaseState(true);
    setupFirebaseAuth(context);
  });
}

// FirebaseAUTH

FirebaseAuth auth;
String userID;

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
      userID = user.uid;
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
      await auth.signInWithCredential(credential);
    },
    verificationFailed: (FirebaseAuthException e) {
      print('The following error occurred: $e');
    },

    codeSent: (String verificationId, int resendToken) {
      //Update UI - to show allow input from the user - SMS Code
      String smsCode;
      return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Enter your OTP'),
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10),
                      ),
                    ),
                  ),
                  onChanged: (value) => smsCode = value,
                ),
              ),
              contentPadding: EdgeInsets.all(10.0),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'CANCEL',
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    PhoneAuthCredential phoneAuthCredential =
                        PhoneAuthProvider.credential(
                            verificationId: verificationId, smsCode: smsCode);
                    auth.signInWithCredential(phoneAuthCredential).then((_) {
                      if (auth.currentUser != null) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                      }
                    });
                    if (auth.currentUser != null) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    }
                  },
                  child: Text(
                    'SUBMIT',
                  ),
                ),
              ],
            );
          });
    },

    // codeSent: ,
    codeAutoRetrievalTimeout: (String verificationId) {
      print('codeAutoRetrieval timed out');
    },
  );
}