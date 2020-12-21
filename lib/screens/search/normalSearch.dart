import 'package:demand_supply/data.dart';
import 'package:demand_supply/screens/productPage/productpage.dart';
import 'package:flutter/material.dart';

import 'package:demand_supply/firebase/firebaseDataPosts.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchTerm;
  searchFn() {
    searchForPostsByTitleInDistrict(
            uDistrict: myProfile.district, title: searchTerm)
        .then(
      (_) => setState(() {
        print('search completed!');
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    postsInDistrictFilterByTitle = [];
    searchTerm = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context)),
        ),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
          child: TextFormField(
            style: TextStyle(fontSize: 20, color: Colors.black87),
            autofocus: true,
            maxLines: 1,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.blue,
                    ),
                    onPressed: searchFn),
                focusColor: Colors.black,
                hintText: "Search here",
                hintStyle: TextStyle(fontSize: 20)),
            initialValue: "",
            textInputAction: TextInputAction.search,
            onFieldSubmitted: (value) {
              searchTerm = value;
              searchFn();
              print('search term $value');
            },
          ),
        ),
      ),
      body: postsInDistrictFilterByTitle.isEmpty
          ? Center(
              child: Text('No results found'),
            )
          : ListView.separated(
              itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Material(
                      elevation: 3,
                      color: Colors.grey[100],
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductPage(
                                      postsInDistrictFilterByTitle[index])));
                        },
                        title: Text(
                          postsInDistrictFilterByTitle[index].title,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
              separatorBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Divider(
                    color: Colors.grey,
                  ),
                );
              },
              itemCount: postsInDistrictFilterByTitle.length),
    );
  }
}
