import 'package:demand_supply/data.dart';
import 'package:demand_supply/screens/dialogs.dart';
import 'package:demand_supply/screens/productPage/productpage.dart';
import 'package:demand_supply/screens/search/filteredResults.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:demand_supply/firebase/firebaseDataPosts.dart';

class AdvSearchPage extends StatefulWidget {
  @override
  _AdvSearchPageState createState() => _AdvSearchPageState();
}

class _AdvSearchPageState extends State<AdvSearchPage> {
  String searchTitle;

  String filterLocality;
  String filterPoliceStation;
  String filterDistrict;
  String filterCategory;
  String filterVerified;

  searchFn() {
    advancedSearchForPostsByTitle(searchTitle).then(
      (_) => setState(() {
        print('search completed!');
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    advancedSearchList = [];
    searchTitle = "";
    // advancedSearchByFilters();
  }

  bool boolval = false;
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
              searchTitle = value;
              searchFn();
              print('search term $value');
            },
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ExpansionTile(
                  title: Text("Filter Results"),
                  children: [
                    //postcategory
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 10),
                      child: DropdownSearch<String>(
                          showSearchBox: true,
                          onChanged: (category) {
                            filterCategory = category;
                          },
                          searchBoxDecoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              helperText: 'Select your target category'),
                          hint: "Select your target category",
                          autoFocusSearchBox: true,
                          showSelectedItem: true,
                          showClearButton: true,
                          items: listofCategories),
                    ),
                    //userpolice station
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 10),
                      child: DropdownSearch<String>(
                          showSearchBox: true,
                          onChanged: (policeStation) {
                            filterPoliceStation = policeStation;
                          },
                          searchBoxDecoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              // border: InputBorder.none,
                              helperText: 'Police Station'),
                          hint: "Police Station",
                          autoFocusSearchBox: true,
                          showSelectedItem: true,
                          showClearButton: true,
                          items: listOfPoliceStaions),
                    ),
                    //userlocality
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 10),
                      child: DropdownSearch<String>(
                          showSearchBox: true,
                          onChanged: (locality) {
                            filterLocality = locality;
                          },
                          searchBoxDecoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              // border: InputBorder.none,
                              helperText: 'Select your locality'),
                          hint: "Select your Locality",
                          autoFocusSearchBox: true,
                          showSelectedItem: true,
                          showClearButton: true,
                          items: listOfLocalities),
                    ),
                    //userdistrict
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 10),
                      child: DropdownSearch<String>(
                          showSearchBox: true,
                          onChanged: (district) {
                            filterDistrict = district;
                          },
                          searchBoxDecoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              helperText: 'Select your district'),
                          hint: "Select your district",
                          autoFocusSearchBox: true,
                          showSelectedItem: true,
                          showClearButton: true,
                          items: listOfDistricts),
                    ),
                    //verified user
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: CheckboxListTile(
                        value: boolval,
                        onChanged: (bool val) {
                          val == true
                              ? setState(() {
                                  boolval = true;
                                  filterVerified = 'Verified';
                                })
                              : setState(() {
                                  boolval = false;
                                  filterVerified = 'Pending';
                                });
                        },
                        title: Text("Verified Users only"),
                      ),
                    ),
                    //Apply Filter button
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        onPressed: () {
                          print('applyFilter()');

                          applyFilters(
                              filterCategory: filterCategory,
                              filterDistrict: filterDistrict,
                              filterLocality: filterLocality,
                              filterPoliceStation: filterPoliceStation,
                              filterVerified: filterVerified);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FilteredResultsPage()));
                        },
                        child: Text(
                          "Apply Filters",
                          style: TextStyle(color: Colors.white),
                        ),
                        elevation: 7.0,
                        color: Colors.cyan,
                      ),
                    ),
                  ],
                ),
              ),
              advancedSearchList.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: Text('No results found'),
                      ),
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.separated(
                          physics: ScrollPhysics(),
                          itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Material(
                                  elevation: 3,
                                  color: Colors.grey[100],
                                  child: ListTile(
                                    onTap: () {
                                      showLoading(context, true);
                                      postByPostPath(advancedSearchList[index]
                                              .postPath)
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
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Divider(
                                color: Colors.grey,
                              ),
                            );
                          },
                          itemCount: advancedSearchList.length),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
