import 'package:demand_supply/firebase/firebaseServices.dart';
import 'package:demand_supply/providerData.dart';
import 'package:custom_progress_dialog/custom_progress_dialog.dart';
import 'package:demand_supply/screens/homePage.dart';
import 'package:demand_supply/screens/login/loginPage.dart';
import 'package:demand_supply/screens/signup/signupPage.dart';
import 'package:demand_supply/screens/signup/userlocation.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => FirebaseProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initializeFirebaseApp(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserLocation(),
    );
  }
}

List<NetworkImage> productimages = [
  NetworkImage(
      'https://www.blibli.com/page/wp-content/uploads/Ulas-Puas-Banner-utama1.jpg'),
  NetworkImage('https://www.blibli.com/friends/assets/banner2.jpg'),
  NetworkImage(
      'https://www.static-src.com/siva/asset//06_2017/microsite-banner--1200x460.jpg'),
  NetworkImage(
      'https://www.static-src.com/siva/asset//03_2017/brandedbabytoy-toy-header.jpg'),
  NetworkImage(
      'https://www.static-src.com/siva/asset//03_2017/brandedbabytoy-toy-header.jpg'),
];

ProgressDialog progressDialog = ProgressDialog();
