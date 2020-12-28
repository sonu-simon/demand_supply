import 'dart:async';

import 'package:demand_supply/firebase/firebaseData.dart';
import 'package:demand_supply/firebase/firebaseDataProfiles.dart';
import 'package:demand_supply/models/policeProfile.dart';
import 'package:demand_supply/screens/admin/giveAdminPrivs.dart';
import 'package:demand_supply/screens/admin/listUnverifiedPosts.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tagging/flutter_tagging.dart';

import '../../data.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  PoliceProfile policeProfileToFirebase = PoliceProfile();
  @override
  void initState() {
    super.initState();
    policeProfileToFirebase.phoneNumber = "";
    retrieveListOfLocalities().then((_) {
      setState(() {
        print(
            'setState after retrieve listOfLocalities() in giveAdminPrivsPage');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Admin Priviledges",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                elevation: 4,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //ENTER PHONE NUMBER
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16.0, left: 10, right: 10, bottom: 8),
                        child: TextFormField(
                          onChanged: (value) => policeProfileToFirebase
                              .phoneNumber = '+91' + value,
                          autofocus: true,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null)
                              return 'Enter a phone number to continue';
                            else if (value.length != 10)
                              return 'Please enter a valid phone number';
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(10),
                              ),
                            ),
                            filled: true,
                            prefixIcon: Icon(
                              Icons.phone_iphone,
                              color: Colors.cyan,
                            ),
                            hintStyle: new TextStyle(color: Colors.grey[800]),
                            hintText: "Phone number to grant admin rights",
                            fillColor: Colors.white70,
                            suffixIcon: IconButton(
                              icon: Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: Icon(Icons.arrow_forward_ios),
                              ),
                              onPressed: () => setAdminPrivs(
                                  policeProfileToFirebase, context),
                            ),
                          ),
                          textInputAction: TextInputAction.go,
                          onFieldSubmitted: (_) =>
                              setAdminPrivs(policeProfileToFirebase, context),
                        ),
                      ),
                      //Picture
                      Card(
                          elevation: 50,
                          child: Center(
                              child: Image.asset("asset/bg/admeen.png"))),
                      //SELECT LOCALITY
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 16.0, left: 24, right: 24, top: 5),
                        child: FlutterTagging<Locality>(
                          findSuggestions: Localities.getLocality,
                          configureChip: (lang) {
                            return ChipConfiguration(
                              label: Text(lang),
                              labelStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300),
                              backgroundColor: Colors.lightBlue,
                            );
                          },
                          configureSuggestion: (loc) {
                            return SuggestionConfiguration(
                                title: Text(loc),
                                additionWidget: Chip(
                                  avatar: Icon(
                                    Icons.add_circle_outline,
                                    color: Colors.white,
                                  ),
                                  label: Text(loc),
                                  labelStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w300),
                                  backgroundColor: Colors.lightBlue,
                                ));
                          },
                          initialItems: ["1", "2", "3", "4"],
                          textFieldConfiguration: TextFieldConfiguration(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                filled: true,
                                fillColor: Colors.lightBlue[400]),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 16.0, left: 24, right: 24, top: 5),
                        child: DropdownSearch<String>(
                            showSearchBox: true,
                            dropdownSearchDecoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(20),
                                ),
                              ),
                              filled: true,
                              prefixIcon: Icon(
                                Icons.location_city,
                                color: Colors.cyan,
                              ),
                              hintStyle: new TextStyle(color: Colors.grey[800]),
                              hintText: "Select Locality from the list",
                              fillColor: Colors.white70,
                            ),
                            onChanged: (locality) =>
                                policeProfileToFirebase.localities = [locality],
                            searchBoxDecoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(20),
                                ),
                              ),
                              filled: true,
                              prefixIcon: Icon(
                                Icons.location_city,
                                color: Colors.cyan,
                              ),
                              hintStyle: new TextStyle(color: Colors.grey[800]),
                              hintText: "Select Locality from the list",
                              fillColor: Colors.white70,
                            ),
                            hint: "Locality",
                            autoFocusSearchBox: false,
                            showSelectedItem: true,
                            showClearButton: true,
                            items: listOfLocalities),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                elevation: 4,
                child: ListTile(
                  title: Text('Verify Posts'),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ListUnverifiedPosts())),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

/// LanguageService
class Localities {
  /// Mocks fetching language from network API with delay of 500ms.
  static Future<List<String>> getLocality(String query) async {
    await Future.delayed(Duration(milliseconds: 500), null);
    return <String>["1", "2", "3", "4", "5"];
  }
}

class Locality extends Taggable {
  final String name;
  Locality({this.name});
  List<Object> get props => [name];
  String toJson()=>
}
