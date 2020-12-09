import 'dart:io';

import 'package:demand_supply/firebase.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'New Post',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          RaisedButton(
            onPressed: () {
              print("POSTING");
            },
            color: Colors.white,
            elevation: 0,
            textColor: Colors.black,
            child: Text("POST"),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //image part
              Container(
                height: MediaQuery.of(context).size.height / 3,
                child: Scaffold(
                  body: Center(
                    child: _image != null
                        ? Container(
                            height: MediaQuery.of(context).size.height / 4,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Image.file(
                              _image,
                              fit: BoxFit.fill,
                            ),
                          )
                        : Container(
                            color: Colors.grey,
                            height: MediaQuery.of(context).size.height / 4,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Center(child: Text("No image selected")),
                          ),
                  ),
                  floatingActionButton: FloatingActionButton(
                    child: Icon(Icons.photo_album_outlined),
                    onPressed: openGallery,
                  ),
                ),
              ),
              //textboxes
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      //title
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 1.0, horizontal: 14),
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null)
                              return 'Phone number cannot be empty';
                            return null;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(20),
                                ),
                              ),
                              filled: true,
                              hintStyle: new TextStyle(color: Colors.grey[800]),
                              hintText: "Title",
                              fillColor: Colors.white70),
                          onChanged: (value) {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 14),
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null)
                              return 'Phone number cannot be empty';
                            return null;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(20),
                                ),
                              ),
                              filled: true,
                              hintStyle: new TextStyle(color: Colors.grey[800]),
                              hintText: "Description",
                              fillColor: Colors.white70),
                          onChanged: (value) {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 14),
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null)
                              return 'Phone number cannot be empty';
                            return null;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(20),
                                ),
                              ),
                              filled: true,
                              hintStyle: new TextStyle(color: Colors.grey[800]),
                              hintText: "Locality",
                              fillColor: Colors.white70),
                          onChanged: (value) {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 14),
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null)
                              return 'Phone number cannot be empty';
                            return null;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(20),
                                ),
                              ),
                              filled: true,
                              hintStyle: new TextStyle(color: Colors.grey[800]),
                              hintText: "10 digit phone number",
                              fillColor: Colors.white70),
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    onPressed: () {
                      uploadimage(userID, 'postID', _image);
                    },
                    color: Colors.red,
                    child: Text("Cancel"),
                  ),
                  RaisedButton(
                    onPressed: () => Navigator.pop(context),
                    color: Colors.green,
                    child: Text("Post"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
