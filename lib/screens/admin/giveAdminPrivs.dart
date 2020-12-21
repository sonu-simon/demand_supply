import 'package:demand_supply/data.dart';
import 'package:demand_supply/firebase/firebaseDataProfiles.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class GiveAdminPrivsPage extends StatefulWidget {
  @override
  _GiveAdminPrivsPageState createState() => _GiveAdminPrivsPageState();
}

class _GiveAdminPrivsPageState extends State<GiveAdminPrivsPage> {
  String toAdminPhoneNumber;
  String toAdminLocality;

  @override
  void initState() {
    super.initState();
    toAdminPhoneNumber = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Give Admin Rights'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //SELECT LOCALITY
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24),
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
                onChanged: (locality) => toAdminLocality = locality,
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
          //ENTER PHONE NUMBER
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24),
            child: TextFormField(
              onChanged: (value) => toAdminPhoneNumber = value,
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
                    const Radius.circular(20),
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
                      '+91' + toAdminPhoneNumber, toAdminLocality, context),
                ),
              ),
              textInputAction: TextInputAction.go,
              onFieldSubmitted: (_) => setAdminPrivs(
                  '+91' + toAdminPhoneNumber, toAdminLocality, context),
            ),
          ),
        ],
      ),
    );
  }
}
