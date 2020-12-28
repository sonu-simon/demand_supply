import 'package:demand_supply/firebase/firebaseServices.dart';
import 'package:demand_supply/providerData.dart';
import 'package:demand_supply/screens/splashscreen.dart';
import 'package:demand_supply/screens/trial/admin.dart';

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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AdminScreen(),
    );
  }
}
