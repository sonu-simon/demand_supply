import 'package:demand_supply/screens/signup/adduserpropic.dart';
import 'package:flutter/material.dart';
import 'package:demand_supply/main.dart';

class SignUpPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String username;
  String whatsappnum;
  String emailid;

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
                  autovalidateMode: AutovalidateMode.always,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextFormField(
                          style: TextStyle(fontSize: 20, color: Colors.black87),
                          autofocus: true,
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
                            username = newValue;
                            myprofile.name = newValue;
                          }),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          style: TextStyle(fontSize: 20, color: Colors.black87),
                          autofocus: true,
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
                          onChanged: ((String newValue) {
                            whatsappnum = newValue;
                            myprofile.whatsappnum = newValue;
                          }),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          style: TextStyle(fontSize: 20, color: Colors.black87),
                          autofocus: true,
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
                          onChanged: ((String newValue) {
                            emailid = newValue;
                            myprofile.emailid = newValue;
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddUserProPic()));
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
