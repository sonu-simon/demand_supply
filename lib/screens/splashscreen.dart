import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vaiga_farmcare/firebase/firebase_services.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      //TODO: implement logic
      () => null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'asset/image/demand_icon.png',
              scale: 2,
              fit: BoxFit.contain,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "   FARM - CARE",
              style: TextStyle(fontSize: 24, letterSpacing: 2.0),
            )
          ],
        ),
      ),
    );
  }
}
