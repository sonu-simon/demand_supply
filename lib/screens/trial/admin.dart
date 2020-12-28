import 'dart:async';

import 'package:demand_supply/data.dart';
import 'package:demand_supply/firebase/firebaseData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tagging/flutter_tagging.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  List<Locality> listofLocalititesModel = [];
  List<String> selectedLocalities = [];

  @override
  void initState() {
    listofLocalititesModel = [];
    Future.delayed(Duration(seconds: 3))
        .then((_) => retrieveListOfLocalities());
    super.initState();
  }

  @override
  void dispose() {
    listofLocalititesModel.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Tagging Demo'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlutterTagging<Locality>(
              initialItems: listofLocalititesModel,
              textFieldConfiguration: TextFieldConfiguration(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.green.withAlpha(30),
                  hintText: 'Search Tags',
                  labelText: 'Select Tags',
                ),
              ),
              findSuggestions: LocalityService.getLocalities,
              additionCallback: (value) {
                return Locality(
                  locality: value,
                );
              },
              onAdded: (locality) {
                return Locality();
              },
              configureSuggestion: (loc) {
                return SuggestionConfiguration(
                  title: Text(loc.locality),
                  additionWidget: Chip(
                    avatar: Icon(
                      Icons.add_circle,
                      color: Colors.white,
                    ),
                    label: Text('Add New Tag'),
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w300,
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              configureChip: (loc) {
                return ChipConfiguration(
                  label: Text(loc.locality),
                  backgroundColor: Colors.green,
                  labelStyle: TextStyle(color: Colors.white),
                  deleteIconColor: Colors.white,
                );
              },
              onChanged: () {
                print(listofLocalititesModel);
                selectedLocalities = [];
                List.from(listofLocalititesModel).forEach((element) {
                  selectedLocalities.add(element.locality);
                });
                print(selectedLocalities);
              },
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}

/// LanguageService
class LocalityService {
  /// Mocks fetching language from network API with delay of 500ms.
  static Future<List<Locality>> getLocalities(String query) async {
    await Future.delayed(Duration(milliseconds: 500), null);
    List<Locality> _listofLocalititesModel = [];
    List.from(listOfLocalities).forEach((element) {
      _listofLocalititesModel.add(Locality(locality: element));
    });
    return _listofLocalititesModel
        .where(
            (loc) => loc.locality.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}

/// Language Class
class Locality extends Taggable {
  final String locality;

  Locality({this.locality});

  @override
  List<Object> get props => [locality];

  /// Converts the class to json string.
  String toJson() => '''  {
    "locality": $locality,\n
  }''';
}
