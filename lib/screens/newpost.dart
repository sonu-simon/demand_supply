import 'dart:io';

import 'package:demand_supply/models/post.dart';
import 'package:demand_supply/screens/dialogs.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import '../data.dart';
import '../firebase/firebaseData.dart';

class NewPost extends StatefulWidget {
  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  File _image;
  String title;
  String description;
  String category;

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
          "New Post",
          style: TextStyle(color: Colors.blue),
        ),
        actions: [
          RaisedButton(
            color: Colors.white,
            hoverColor: Colors.white,
            splashColor: Colors.white,
            elevation: 0,
            onPressed: () {
              showLoading(context, true);
              Post newPost;
              String tempPostId = currentUserID.substring(0, 12) +
                  '_' +
                  DateTime.now().toString().replaceAll('.', '_');
              uploadPostImage(currentUserID, tempPostId, _image)
                  .then((_imgSrc) {
                print('_imgSrc: $_imgSrc');
                newPost = Post(
                    id: tempPostId,
                    title: title,
                    category: category,
                    imageUrl: _imgSrc,
                    description: description,
                    userProfile: myProfile);
                postToFirebase(newPost, context);
                print('new post completed');
                // showLoading(context, false);
                showCompletedDialog(
                    context, '    New post created successfully!');
              });
            },
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
                  onChanged: ((value) {
                    title = value;
                  }),
                ),
                SizedBox(
                  height: 25,
                ),
                //Description
                TextFormField(
                  style: TextStyle(fontSize: 18, color: Colors.black87),
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
                  onChanged: ((value) {
                    description = value;
                  }),
                ),
                SizedBox(
                  height: 25,
                ),
                //category
                DropdownSearch<String>(
                  showSearchBox: false,
                  maxHeight: 340,
                  searchBoxDecoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    // border: InputBorder.none,
                  ),
                  hint: "Category",
                  autoFocusSearchBox: true,
                  showSelectedItem: true,
                  showClearButton: false,
                  items: listofCategories,
                  onChanged: ((value) {
                    category = value;
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
