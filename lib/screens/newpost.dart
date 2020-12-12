import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:demand_supply/models/post.dart';

import '../firebase/firebaseData.dart';
import '../data.dart';

class NewPost extends StatefulWidget {
  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  List<Image> post_images = [];
  int count = 1;

  @override
  void initState() {
    super.initState();
    retrieveListOfLocalities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
          title: Text(
            "NewPost",
            style: TextStyle(color: Colors.blue),
          ),
          actions: [
            RaisedButton(
              color: Colors.white,
              hoverColor: Colors.white,
              splashColor: Colors.white,
              elevation: 0,
              onPressed: () {},
              child: Text(
                "POST",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        body: Form(
          onChanged: () {
            print("Maari");
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    //title
                    TextFormField(
                      style: TextStyle(fontSize: 30, color: Colors.black87),
                      autofocus: true,
                      maxLines: 1,
                      maxLength: 50,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0)),
                          focusColor: Colors.black,
                          border: InputBorder.none,
                          helperText:
                              "This is what other users will see along with pictures",
                          hintText: "Title",
                          hintStyle: TextStyle(fontSize: 30)),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    //Description
                    TextFormField(
                      style: TextStyle(fontSize: 15, color: Colors.black87),
                      autofocus: true,
                      maxLines: 4,
                      maxLength: 170,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0)),
                          helperText: "Give a brief Description",
                          hintText: "Description",
                          hintStyle: TextStyle(fontSize: 20)),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    //phone&whatsapp
                    TextFormField(
                      style: TextStyle(fontSize: 20, color: Colors.black87),
                      autofocus: true,
                      maxLines: 1,
                      maxLength: 10,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0)),
                          focusColor: Colors.black,
                          border: InputBorder.none,
                          helperText:
                              "Phone number to be given for contacting you",
                          hintText: 'Enter phone number',
                          hintStyle: TextStyle(fontSize: 20)),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    //locality
                    DropdownSearch<String>(
                        showSearchBox: true,
                        searchBoxDecoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(10)),
                            // border: InputBorder.none,
                            helperText: 'Target Location for your Ad'),
                        hint: "Select your Locality",
                        autoFocusSearchBox: true,
                        showSelectedItem: true,
                        showClearButton: true,
                        items: listOfLocalities),
                    SizedBox(
                      height: 25,
                    ),
                    //images
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Container(
                              height: MediaQuery.of(context).size.height * 0.15,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: count,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    if (count == 1) {
                                      return Card(
                                        child: InkWell(
                                          onTap: () {
                                            //image kayataanulla code
                                            //add image to post_image
                                            setState(() {
                                              count++;
                                            });
                                            print("Njengi");
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.15,
                                            child: Image(
                                              image: AssetImage(
                                                  "asset/image/nill.jpg"),
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Card(
                                        child: InkWell(
                                          onTap: () {
                                            //image kayataanulla code
                                            //add image to post_image
                                            setState(() {
                                              count++;
                                            });
                                            print("Njengi");
                                          },
                                          child: Container(
                                              alignment: Alignment.center,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.15,
                                              child: post_images[index]),
                                        ),
                                      );
                                    }
                                  })),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "Add images for your post",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
