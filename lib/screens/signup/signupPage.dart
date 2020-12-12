import 'package:demand_supply/screens/signup/addpropic.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PhotoPage()));
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
