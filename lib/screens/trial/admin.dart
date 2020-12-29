// import 'dart:async';

// import 'package:demand_supply/data.dart';
// import 'package:demand_supply/firebase/firebaseData.dart';
// import 'package:demand_supply/firebase/firebaseDataProfiles.dart';
// import 'package:demand_supply/models/policeProfile.dart';
// import 'package:demand_supply/screens/admin/listUnverifiedPosts.dart';
// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_tagging/flutter_tagging.dart';

// class AdminScreen extends StatefulWidget {
//   @override
//   _AdminScreenState createState() => _AdminScreenState();
// }

// class _AdminScreenState extends State<AdminScreen> {
//   PoliceProfile policeProfileToFirebase = PoliceProfile();
//   List<Locality> listofLocalititesModel = [];
//   List<String> selectedLocalities = [];

//   @override
//   void initState() {
//     listofLocalititesModel = [];
//     Future.delayed(Duration(seconds: 3))
//         .then((_) => retrieveListOfLocalities());
//     super.initState();
//     policeProfileToFirebase.phoneNumber = "";
//     retrieveListOfLocalities().then((_) {
//       setState(() {
//         print(
//             'setState after retrieve listOfLocalities() in giveAdminPrivsPage');
//       });
//     });
//   }

//   @override
//   void dispose() {
//     listofLocalititesModel.clear();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter Tagging Demo'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Material(
//                 elevation: 4,
//                 child: Container(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       //ENTER PHONE NUMBER
//                       Padding(
//                         padding: const EdgeInsets.only(
//                             top: 16.0, left: 10, right: 10, bottom: 8),
//                         child: TextFormField(
//                           onChanged: (value) => policeProfileToFirebase
//                               .phoneNumber = '+91' + value,
//                           autofocus: true,
//                           keyboardType: TextInputType.phone,
//                           validator: (value) {
//                             if (value == null)
//                               return 'Enter a phone number to continue';
//                             else if (value.length != 10)
//                               return 'Please enter a valid phone number';
//                             return null;
//                           },
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(
//                               borderRadius: const BorderRadius.all(
//                                 const Radius.circular(10),
//                               ),
//                             ),
//                             filled: true,
//                             prefixIcon: Icon(
//                               Icons.phone_iphone,
//                               color: Colors.cyan,
//                             ),
//                             hintStyle: new TextStyle(color: Colors.grey[800]),
//                             hintText: "Phone number to grant admin rights",
//                             fillColor: Colors.white70,
//                             suffixIcon: IconButton(
//                               icon: Padding(
//                                 padding: const EdgeInsets.only(right: 16),
//                                 child: Icon(Icons.arrow_forward_ios),
//                               ),
//                               onPressed: () => setAdminPrivs(
//                                   policeProfileToFirebase, context),
//                             ),
//                           ),
//                           textInputAction: TextInputAction.go,
//                           onFieldSubmitted: (_) =>
//                               setAdminPrivs(policeProfileToFirebase, context),
//                         ),
//                       ),
//                       //Picture
//                       Card(
//                           elevation: 50,
//                           child: Center(
//                               child: Image.asset("asset/bg/admeen.png"))),
//                       //SELECT LOCALITY

//                       Column(
//                         children: <Widget>[
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: FlutterTagging<Locality>(
//                               initialItems: listofLocalititesModel,
//                               textFieldConfiguration: TextFieldConfiguration(
//                                 decoration: InputDecoration(
//                                   border: InputBorder.none,
//                                   filled: true,
//                                   fillColor: Colors.lightBlue.withAlpha(30),
//                                   hintText: 'Search Tags',
//                                   labelText: 'Select Tags',
//                                 ),
//                               ),
//                               findSuggestions: LocalityService.getLocalities,
//                               additionCallback: (value) {
//                                 return Locality(
//                                   locality: value,
//                                 );
//                               },
//                               onAdded: (locality) {
//                                 return Locality();
//                               },
//                               configureSuggestion: (loc) {
//                                 return SuggestionConfiguration(
//                                   title: Text(loc.locality),
//                                   additionWidget: Chip(
//                                     avatar: Icon(
//                                       Icons.add_circle,
//                                       color: Colors.white,
//                                     ),
//                                     label: Text('Add New Tag'),
//                                     labelStyle: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 14.0,
//                                       fontWeight: FontWeight.w300,
//                                     ),
//                                     backgroundColor: Colors.lightBlue,
//                                   ),
//                                 );
//                               },
//                               configureChip: (loc) {
//                                 return ChipConfiguration(
//                                   label: Text(loc.locality),
//                                   backgroundColor: Colors.lightBlue,
//                                   labelStyle: TextStyle(color: Colors.white),
//                                   deleteIconColor: Colors.white,
//                                 );
//                               },
//                               onChanged: () {
//                                 print(listofLocalititesModel);
//                                 selectedLocalities = [];
//                                 List.from(listofLocalititesModel)
//                                     .forEach((element) {
//                                   selectedLocalities.add(element.locality);
//                                 });
//                                 print(selectedLocalities);
//                               },
//                             ),
//                           ),
//                           SizedBox(
//                             height: 20.0,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Material(
//                 elevation: 4,
//                 child: ListTile(
//                   title: Text('Verify Posts'),
//                   onTap: () => Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => ListUnverifiedPosts())),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// /// LanguageService
// class LocalityService {
//   /// Mocks fetching language from network API with delay of 500ms.
//   static Future<List<Locality>> getLocalities(String query) async {
//     await Future.delayed(Duration(milliseconds: 500), null);
//     List<Locality> _listofLocalititesModel = [];
//     List.from(listOfLocalities).forEach((element) {
//       _listofLocalititesModel.add(Locality(locality: element));
//     });
//     return _listofLocalititesModel
//         .where(
//             (loc) => loc.locality.toLowerCase().contains(query.toLowerCase()))
//         .toList();
//   }
// }

// /// Language Class
// class Locality extends Taggable {
//   final String locality;

//   Locality({this.locality});

//   @override
//   List<Object> get props => [locality];

//   /// Converts the class to json string.
//   String toJson() => '''  {
//     "locality": $locality,\n
//   }''';
// }
