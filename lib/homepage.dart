import 'package:demand_supply/firebase.dart';
import 'package:demand_supply/providerData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final firebaseProvider = Provider.of<FirebaseProvider>(context);
    print(firebaseProvider.getFirebaseState);
    return Scaffold(
      body: Center(
        child: FlatButton(
          child: Text('LOGIN'),
          onPressed: () => loginWithPhoneNumber('+919061254111', context),
        ),
      ),
    );
  }
}
