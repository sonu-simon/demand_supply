import 'dart:io';

import 'package:demand_supply/data.dart';
import 'package:demand_supply/models/userProfile.dart';
import 'package:demand_supply/screens/dialogs.dart';
import 'package:demand_supply/screens/login/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:demand_supply/firebase/firebaseData.dart';

class AddUserProPic extends StatefulWidget {
  final String uName;
  final String uWhatsappNumber;
  final String uEmailId;
  final String uLocality;
  final String uDistrict;
  final String uPoliceStation;

  AddUserProPic(
      {this.uName,
      this.uWhatsappNumber,
      this.uEmailId,
      this.uLocality,
      this.uDistrict,
      this.uPoliceStation});

  @override
  _AddUserProPicState createState() => _AddUserProPicState();
}

class _AddUserProPicState extends State<AddUserProPic> {
  Image image;
  File _image;
  String userProPicUrl;

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
                        : Center(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 24),
                              child: CircleAvatar(
                                minRadius: 40,
                                maxRadius: 150,
                                backgroundColor: Colors.black,
                                backgroundImage: FileImage(_image),
                              ),
                            ),
                          )),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              InkWell(
                onTap: () {
                  openGallery();
                  setState(() {
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
          showLoading(context, true);
          UserProfile signupProfile;
          uploadUserProPicImage(currentUserID, _image).then((_imgSrc) {
            print('_imgSrc: $_imgSrc');
            signupProfile = UserProfile(
                userID: currentUserID,
                name: widget.uName,
                proPicUrl: _imgSrc,
                phoneNumber: uPhoneNumber,
                locality: widget.uLocality,
                district: widget.uDistrict,
                policeStation: widget.uLocality,
                whatsappNumber: widget.uWhatsappNumber,
                emailId: widget.uEmailId,
                posts: []);
            print(signupProfile.userID);
            userToFirebase(signupProfile, context);
            // showLoading(context, false);
            showCompletedDialog(
                context, '    User Profile successfully created!');
          });
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
