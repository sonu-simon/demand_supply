import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import '../firebase/firebaseData.dart';
import '../data.dart';

class NewPost extends StatefulWidget {
  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  File _image;

  void openGallery() async {
    final picker = ImagePicker();
    PickedFile pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      print('in .then()');
      _image = File(pickedFile.path);
    });
  }

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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                //image
                InkWell(
                  onTap: openGallery,
                  onLongPress: () {
                    setState(() {
                      _image = null;
                    });
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: _image != null
                        ? Container(
                            // height: MediaQuery.of(context).size.height / 4,
                            width: MediaQuery.of(context).size.width,
                            child: Image.file(
                              _image,
                              fit: BoxFit.fill,
                            ),
                          )
                        : Container(
                            color: Colors.grey,
                            // height: MediaQuery.of(context).size.height / 4,
                            width: MediaQuery.of(context).size.width,
                            child: Image(
                              image: AssetImage("asset/image/nill.jpg"),
                            ),
                          ),
                  ),
                ),
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
                      helperText: "Title for your Ad",
                      hintText: "Title",
                      hintStyle: TextStyle(fontSize: 30)),
                  onChanged: ((String value) {
                    print(value);
                  }),
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
                  onChanged: ((String value) {
                    print(value);
                  }),
                ),
                SizedBox(
                  height: 25,
                ),

                //locality
                DropdownSearch<String>(
                  showSearchBox: true,
                  searchBoxDecoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    // border: InputBorder.none,
                  ),
                  hint: "Category",
                  autoFocusSearchBox: true,
                  showSelectedItem: true,
                  showClearButton: true,
                  items: listofCategories,
                  onChanged: ((String value) {
                    print(value);
                  }),
                ),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
