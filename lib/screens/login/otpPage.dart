import 'package:demand_supply/firebase/firebaseData.dart';
import 'package:demand_supply/firebase/firebaseServices.dart';
import 'package:demand_supply/screens/signup/signupPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:demand_supply/screens/homePage.dart';

String _smsCode;
codeSentFunction(String verificationId, int resendToken, BuildContext context) {
  PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
      verificationId: verificationId, smsCode: _smsCode);
  auth.signInWithCredential(phoneAuthCredential).then((_) async {
    if (auth.currentUser != null) {
      if (await checkIfUserProfileExists(auth.currentUser.uid))
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      else
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
    }
  });
}

class EnterOtpScreen extends StatefulWidget {
  final String verificationId;
  final int resendToken;

  EnterOtpScreen({this.resendToken, this.verificationId});

  @override
  _EnterOtpScreenState createState() => _EnterOtpScreenState();
}

class _EnterOtpScreenState extends State<EnterOtpScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: height * 0.05,
              ),
              Text(
                "Enter OTP received on your phone",
                style: TextStyle(
                  color: Colors.cyan,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: height * 0.04,
              ),
              Image.asset(
                "asset/bg/g.png",
                scale: 2,
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24),
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null)
                      return 'Enter the OTP received to continue';
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
                      hintText: "One Time Password",
                      fillColor: Colors.white70),
                  onChanged: (value) {
                    //Process the input phone number
                    _smsCode = value;
                  },
                ),
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                onPressed: () => codeSentFunction(
                    widget.verificationId, widget.resendToken, context),
                child: Text(
                  "Submit OTP",
                  style: TextStyle(color: Colors.white),
                ),
                elevation: 7.0,
                color: Colors.cyan,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
