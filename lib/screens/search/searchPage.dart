import 'package:demand_supply/data.dart';
import 'package:demand_supply/screens/dialogs.dart';
import 'package:demand_supply/screens/productpage.dart';
import 'package:flutter/material.dart';

import 'package:demand_supply/firebase/firebaseData.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchTerm;
  searchFn() {
    advancedSearchForPostsByTitle(searchTerm).then(
      (_) => setState(() {
        print('search completed!');
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    advancedSearchList = [];
    searchTerm = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            actions: [
              IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.grey,
                    size: 40,
                  ),
                  onPressed: searchFn)
            ],
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                style: TextStyle(fontSize: 20, color: Colors.black87),
                autofocus: true,
                maxLines: 1,
                decoration: InputDecoration(
                    focusColor: Colors.black,
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    hintText: "Search",
                    hintStyle: TextStyle(fontSize: 20)),
                initialValue: "",
                textInputAction: TextInputAction.search,
                onFieldSubmitted: (value) {
                  searchTerm = value;
                  searchFn();
                  print('search term $value');
                },
                onChanged: ((String newValue) {
                  // uName = newValue;
                }),
              ),
            ),
          ),
          body: advancedSearchList.isEmpty
              ? Center(
                  child: Text('No results found'),
                )
              : ListView.separated(
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Material(
                          elevation: 2,
                          child: ListTile(
                            onTap: () {
                              showLoading(context, true);
                              postByPostPath(advancedSearchList[index].postPath)
                                  .then((post) {
                                showLoading(context, false);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProductPage(post)));
                              });
                            },
                            title: Text(
                              advancedSearchList[index].title,
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                  separatorBuilder: (context, index) {
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Divider(
                        color: Colors.grey,
                      ),
                    );
                  },
                  itemCount: advancedSearchList.length)),
    );
  }
}
