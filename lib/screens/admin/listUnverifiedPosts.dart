import 'package:demand_supply/data.dart';
import 'package:demand_supply/screens/dialogs.dart';
import 'package:demand_supply/screens/productPage/productPageToVerify.dart';
import 'package:flutter/material.dart';

import 'package:demand_supply/firebase/firebaseDataPosts.dart';

class ListUnverifiedPosts extends StatefulWidget {
  @override
  _ListUnverifiedPostsState createState() => _ListUnverifiedPostsState();
}

class _ListUnverifiedPostsState extends State<ListUnverifiedPosts> {
  searchFn() {
    retrievePostsByVillageNotVerified(
            uDistrict: myProfile.district, uLocality: myProfile.locality)
        .then(
      (_) => setState(() {
        print(
            'search completed! in ${myProfile.district} - ${myProfile.locality}');
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    notVerifiedPostsForAdminByLocality = [];
    searchFn();
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
          title: Text('Unverified Posts in Locality')),
      body: notVerifiedPostsForAdminByLocality.isEmpty
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
                          showLoading(context, true);
                          postByPostPath(
                                  notVerifiedPostsForAdminByLocality[index]
                                      .postInPathCollection)
                              .then((post) {
                            showLoading(context, false);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ProductPageToVerify(post)));
                          });
                        },
                        title: Text(
                          notVerifiedPostsForAdminByLocality[index].title,
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
              itemCount: notVerifiedPostsForAdminByLocality.length),
    );
  }
}
