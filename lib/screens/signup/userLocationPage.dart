import 'package:demand_supply/screens/signup/adduserpropic.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import '../../data.dart';

class UserLocationPage extends StatefulWidget {
  final String uName;
  final String uWhatsappNumber;
  final String uEmailId;

  UserLocationPage({this.uName, this.uWhatsappNumber, this.uEmailId});

  @override
  _UserLocationPageState createState() => _UserLocationPageState();
}

class _UserLocationPageState extends State<UserLocationPage> {
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

  String uLocality;
  String uDistrict;
  String uPoliceStation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.2,
              //   //text above image
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: [
              //       SizedBox(
              //         height: 30,
              //       ),
              //       Text(
              //         "Welcome",
              //         style: TextStyle(
              //             fontWeight: FontWeight.bold,
              //             color: Colors.blue,
              //             fontSize: MediaQuery.of(context).size.height * 0.06,
              //             letterSpacing: 4),
              //       ),
              //       SizedBox(height: 10),
              //       Text(
              //         "Enter details for creating your free account",
              //         maxLines: 2,
              //         style: TextStyle(
              //           color: Colors.cyan,
              //           fontSize: MediaQuery.of(context).size.height * 0.023,
              //           letterSpacing: 4,
              //         ),
              //         textAlign: TextAlign.center,
              //       )
              //     ],
              //   ),
              // ),
              SizedBox(
                height: 20,
              ),
              //image
              Image.asset(
                "asset/bg/location.jpg",
                scale: 2,
              ),
              Form(
                  key: _formKey2,
                  autovalidateMode: AutovalidateMode.always,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        //district
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: DropdownSearch<String>(
                              showSearchBox: true,
                              onChanged: (locality) => uLocality = locality,
                              searchBoxDecoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 1),
                                      borderRadius: BorderRadius.circular(10)),
                                  // border: InputBorder.none,
                                  helperText: 'Select your district'),
                              hint: "Select your district",
                              autoFocusSearchBox: true,
                              showSelectedItem: true,
                              showClearButton: true,
                              items: listOfDistricts),
                        ),
                        SizedBox(
                          height: 10,
                        ), //locality
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: DropdownSearch<String>(
                              showSearchBox: true,
                              onChanged: (locality) => uLocality = locality,
                              searchBoxDecoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 1),
                                      borderRadius: BorderRadius.circular(10)),
                                  // border: InputBorder.none,
                                  helperText: 'Select your locality'),
                              hint: "Select your Locality",
                              autoFocusSearchBox: true,
                              showSelectedItem: true,
                              showClearButton: true,
                              items: listOfLocalities),
                        ),
                        SizedBox(
                          height: 10,
                        ), //policeStation
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: DropdownSearch<String>(
                              showSearchBox: true,
                              onChanged: (locality) => uLocality = locality,
                              searchBoxDecoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 1),
                                      borderRadius: BorderRadius.circular(10)),
                                  // border: InputBorder.none,
                                  helperText: 'Police Station'),
                              hint: "Police Station",
                              autoFocusSearchBox: true,
                              showSelectedItem: true,
                              showClearButton: true,
                              items: listOfPoliceStaions),
                        ),
                        SizedBox(
                          height: 10,
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
          if (_formKey2.currentState.validate()) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddUserProPic(
                          uEmailId: widget.uEmailId,
                          uName: widget.uName,
                          uWhatsappNumber: widget.uWhatsappNumber,
                          uLocality: uLocality,
                          uDistrict: uDistrict,
                          uPoliceStation: uPoliceStation,
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
