import 'package:demand_supply/data.dart';
import 'package:flutter/material.dart';

class SearchPageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
      ),
      body: Scaffold(
        drawer: Drawer(),
        //searchbar
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                  icon: Icon(
                    Icons.sort,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    //draweril advanced search parameters vekka
                    //allel drawer mati dialogue box aaka
                    Scaffold.of(context).openDrawer();
                  });
            },
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                onPressed: () {
                  print("Search clicked");
                  //array change cheyyal in set state
                })
          ],
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          title: TextFormField(
            style: TextStyle(fontSize: 20, color: Colors.black87),
            autofocus: true,
            maxLines: 1,
            maxLength: 50,
            decoration: InputDecoration(
                focusColor: Colors.black,
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue)),
                hintText: "Search title",
                hintStyle: TextStyle(fontSize: 20)),
            initialValue: "",
            validator: (String value) {
              value = value.trim();
              if (value.isEmpty) {
                return 'Name is Required';
              }
              return null;
            },
            onChanged: ((String newValue) {
              print("Maari");
            }),
          ),
        ),
        //searchresult
        body: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                  itemCount: listOfDistricts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        title: Text(listOfDistricts[index]),
                        onTap: () {
                          print(index);
                        },
                      ),
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
