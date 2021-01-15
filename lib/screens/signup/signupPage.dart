import 'package:demand_supply/firebase/firebaseData.dart';
import 'package:demand_supply/screens/signup/userLocationPage.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String uName;
  String uWhatsappNumber;
  String uEmailId;
  String uLocality;
  String uDistrict;
  String uPoliceStation;

  @override
  void initState() {
    super.initState();
    retrieveLocationRelatedLists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                //text above image
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Welcome",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: MediaQuery.of(context).size.height * 0.06,
                          letterSpacing: 4),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Enter details for creating your free account",
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.cyan,
                        fontSize: MediaQuery.of(context).size.height * 0.023,
                        letterSpacing: 4,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
              //image
              Image.asset(
                "asset/bg/details.jpg",
                scale: 2,
              ),
              Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //Name
                        TextFormField(
                          style: TextStyle(fontSize: 20, color: Colors.black87),
                          autofocus: false,
                          maxLines: 1,
                          maxLength: 50,
                          decoration: InputDecoration(
                              focusColor: Colors.black,
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue)),
                              hintText: "Name",
                              hintStyle: TextStyle(fontSize: 20)),
                          initialValue: "",
                          validator: (String value) {
                            value = value.trim();
                            if (value.isEmpty) {
                              return 'Name is Required';
                            }
                            return null;
                          },
                          onChanged: ((String newValue) {
                            uName = newValue;
                          }),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        //whatsapp
                        TextFormField(
                          style: TextStyle(fontSize: 20, color: Colors.black87),
                          autofocus: false,
                          maxLines: 1,
                          maxLength: 10,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              focusColor: Colors.black,
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue)),
                              hintText: "WhatsApp Number",
                              hintStyle: TextStyle(fontSize: 20)),
                          initialValue: "",
                          validator: (String value) {
                            value = value.trim();
                            if (value.isEmpty) {
                              return 'Number is Required';
                            }
                            return null;
                          },
                          onChanged: ((String newValue) {
                            uWhatsappNumber = '+91' + newValue;
                          }),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        //EMAIL
                        TextFormField(
                          style: TextStyle(fontSize: 20, color: Colors.black87),
                          autofocus: false,
                          maxLines: 1,
                          maxLength: 50,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              focusColor: Colors.black,
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue)),
                              hintText: "Email",
                              hintStyle: TextStyle(fontSize: 20)),
                          initialValue: "",
                          // validator: (String value) {
                          //   value = value.trim();
                          //   if (value.isEmpty) {
                          //     return 'Email is Required';
                          //   }
                          //   return null;
                          // },
                          onChanged: ((String newValue) {
                            uEmailId = newValue;
                          }),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UserLocationPage(
                          uEmailId: uEmailId,
                          uName: uName,
                          uWhatsappNumber: uWhatsappNumber,
                        )));
          }
        },
        backgroundColor: Colors.white,
        child: Center(
          child: Icon(
            Icons.arrow_forward_ios,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
