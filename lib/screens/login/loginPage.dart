import 'package:demand_supply/providerData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../firebase/firebaseServices.dart';

String uPhoneNumber;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    uPhoneNumber = "";
  }

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
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                          fillColor: Colors.white70,
                          suffixIcon: IconButton(
                            icon: Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Icon(Icons.login_sharp),
                            ),
                            onPressed: () =>
                                loginWithPhoneNumber(uPhoneNumber, context),
                          ),
                        ),
                        onChanged: (value) {
                          //Process the input phone number
                          uPhoneNumber = '+91' + value;
                        },
                      ),
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      onPressed: () =>
                          loginWithPhoneNumber(uPhoneNumber, context),
                      onLongPress: () => authSignOut(context),
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
                    SizedBox(
                      height: height * 0.2,
                    )
                  ],
                ),
              ),
            ),
          )
        : Scaffold(
            body: Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Estabilishing connection with backend!'),
                  )
                ],
              ),
            ),
          );
  }
}
