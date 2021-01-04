import 'dart:io';

import 'package:demand_supply/models/post.dart';
import 'package:demand_supply/screens/dialogs.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import '../../data.dart';
import '../../firebase/firebaseDataPosts.dart';
import '../../firebase/firebaseData.dart';

class EditPost extends StatefulWidget {
  final Post initialPostData;

  EditPost(this.initialPostData);
  @override
  _EditPostState createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
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
          "Edit Post",
          style: TextStyle(color: Colors.blue),
        ),
        actions: [
          RaisedButton(
            color: Colors.white,
            hoverColor: Colors.white,
            splashColor: Colors.white,
            elevation: 0,
            onPressed: () {
              if (_image == null ||
                  title == null ||
                  description == null ||
                  category == null)
                showErrorDialog(context,
                    'All fields are mandatory! Please fill in the required details');
              else {
                showLoading(context, true);

                Post newPost;
                uploadPostImage(
                        currentUserID, widget.initialPostData.id, _image)
                    .then((_imgSrc) {
                  print('_imgSrc: $_imgSrc');

                  newPost = Post(
                      id: widget.initialPostData.id,
                      title: title,
                      postDate: widget.initialPostData.postDate,
                      category: category,
                      imageUrl: _imgSrc,
                      isVerified: false,
                      description: description,
                      userProfile: myProfile);
                  // AdvancedSearchModel postToAddToUser = AdvancedSearchModel(
                  //     newPost.title, newPost.postInPathCollection);
                  // myProfile.addPosts(postToAddToUser);
                  // print('myProfile.posts: ${myProfile.posts}');
                  // postToFirebase(newPost);
                  editPostInFirebase(newPost);

                  print('new post completed');
                  // showLoading(context, false);
                  showCompletedDialog(
                      context, '    New post created successfully!');
                });
              }
            },
            child: Text(
              "SAVE",
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
                              image:
                                  NetworkImage(widget.initialPostData.imageUrl),
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
                  initialValue: widget.initialPostData.title,
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
                  initialValue: widget.initialPostData.description,
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
                  hint: widget.initialPostData.category,
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
