import 'package:demand_supply/screens/dialogs.dart';
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
                  autovalidateMode: AutovalidateMode.disabled,
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
                              onChanged: (district) {
                                uDistrict = district;
                                print('$uDistrict $uLocality $uPoliceStation');
                              },
                              searchBoxDecoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 1),
                                      borderRadius: BorderRadius.circular(10)),
                                  helperText: 'Select your district'),
                              hint: "Select your district",
                              autoFocusSearchBox: true,
                              showSelectedItem: true,
                              showClearButton: true,
                              items: listOfDistricts),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        //locality
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: DropdownSearch<String>(
                              showSearchBox: true,
                              onChanged: (locality) {
                                uLocality = locality;
                                print('$uDistrict $uLocality $uPoliceStation');
                              },
                              searchBoxDecoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 1),
                                      borderRadius: BorderRadius.circular(10)),
                                  helperText: 'Select your locality'),
                              hint: "Select your Locality",
                              autoFocusSearchBox: true,
                              showSelectedItem: true,
                              showClearButton: true,
                              items: listOfLocalities),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        //policeStation
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: DropdownSearch<String>(
                              showSearchBox: true,
                              onChanged: (policeStation) {
                                uPoliceStation = policeStation;
                                print('$uDistrict $uLocality $uPoliceStation');
                              },
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
          print('$uDistrict $uLocality $uPoliceStation');
          if (uDistrict == null || uLocality == null || uPoliceStation == null)
            showErrorDialog(context, 'You can\'t miss out any fields here!');
          else {
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
