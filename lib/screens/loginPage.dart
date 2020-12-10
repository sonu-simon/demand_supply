import 'package:demand_supply/providerData.dart';
import 'package:demand_supply/screens/homePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../firebaseServices.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String phoneNumber;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final firebaseProvider = Provider.of<FirebaseProvider>(context);

    return firebaseProvider.getFirebaseState
        ? Scaffold(
            body: SingleChildScrollView(
              child: Container(
                height: height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      height: height * 0.16,
                    ),
                    Text(
                      "Login with phone number",
                      style: TextStyle(
                        color: Colors.cyan,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Image.asset(
                      "asset/image/demand_icon.png",
                      scale: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 24),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null)
                            return 'Phone number cannot be empty';
                          return null;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(20),
                              ),
                            ),
                            filled: true,
                            prefixIcon: Icon(
                              Icons.phone_iphone,
                              color: Colors.cyan,
                            ),
                            hintStyle: new TextStyle(color: Colors.grey[800]),
                            hintText: "10 digit phone number",
                            fillColor: Colors.white70),
                        onChanged: (value) {
                          //Process the input phone number
                          phoneNumber = '+91' + value;
                        },
                      ),
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      onPressed: () =>
                          loginWithPhoneNumber(phoneNumber, context),
                      onLongPress: () => authSignOut(),
                      child: Text(
                        "Generate OTP",
                        style: TextStyle(color: Colors.white),
                      ),
                      elevation: 7.0,
                      color: Colors.cyan,
                    ),
                    SizedBox(
                      height: height * 0.005,
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage())),
                      onLongPress: () => authSignOut(),
                      child: Text(
                        "NEXT",
                        style: TextStyle(color: Colors.white),
                      ),
                      elevation: 7.0,
                      color: Colors.cyan,
                    ),
                    SizedBox(
                      height: height * 0.005,
                    ),
                    Text("Need Help?"),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      firebaseProvider.getUserLoginState
                          ? "User Logged in!"
                          : "Not logged in!",
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ),
            ),
          )
        : Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
