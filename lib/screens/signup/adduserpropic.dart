import 'dart:io';

// import 'package:demand_supply/models/userProfile.dart';
import 'package:flutter/material.dart';
import 'package:demand_supply/main.dart';
import 'package:image_picker/image_picker.dart';

import '../homePage.dart';

class AddUserProPic extends StatefulWidget {
  @override
  _AddUserProPicState createState() => _AddUserProPicState();
}

class _AddUserProPicState extends State<AddUserProPic> {
  Image image;
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
      body: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                //text above image
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Welcome",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: MediaQuery.of(context).size.height * 0.06,
                          letterSpacing: 4),
                    ),
                    Text(
                      "Snap your profile picture",
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.cyan,
                        fontSize: MediaQuery.of(context).size.height * 0.023,
                        letterSpacing: 4,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
              //image
              Center(
                child: Container(
                  child: _image == null
                      ? Image.asset(
                          "asset/bg/photo.jpg",
                          scale: 2,
                        )
                      : Stack(
                          children: [
                            Image.asset(
                              "asset/bg/photo.jpg",
                              scale: 2,
                            ),
                            Image.asset(
                              "asset/bg/photo.jpg",
                              scale: 2,
                            ),
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: Center(
                                child: Container(
                                  child: CircleAvatar(
                                    minRadius: 40,
                                    maxRadius: 150,
                                    backgroundColor: Colors.black,
                                    backgroundImage: FileImage(_image),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              InkWell(
                onTap: () {
                  print("NJENGI");
                  setState(() {
                    openGallery();
                    if (_image == null) {
                      image = null;
                    } else {
                      print("MAARI");
                      image = Image(image: FileImage(_image));
                    }
                  });
                },
                child: Icon(
                  Icons.camera,
                  size: 100,
                  color: Colors.blue,
                ),
              )
            ],
          ))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
          myprofile.propic = Image(image: FileImage(_image));
        },
        backgroundColor: Colors.white,
        child: Center(
          child: Icon(
            Icons.arrow_forward_ios,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
