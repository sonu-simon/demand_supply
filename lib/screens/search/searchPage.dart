import 'package:demand_supply/data.dart';
import 'package:demand_supply/screens/search/postFromSearchPage.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[200],
        title: TextFormField(
          decoration: InputDecoration(
              suffixIcon: IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: searchFn,
          )),
          textInputAction: TextInputAction.search,
          onFieldSubmitted: (value) {
            searchTerm = value;
            searchFn();
            print('search term $value');
          },
        ),
      ),
      body: advancedSearchList.isEmpty
          ? Center(
              child: Text('No results found'),
            )
          : ListView.builder(
              itemCount: advancedSearchList.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(16.0),
                child: Material(
                  elevation: 2,
                  child: ListTile(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostAdvSearchPage(
                            advancedSearchList[index].postPath),
                      ),
                    ),
                    title: Text(
                      advancedSearchList[index].title,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
