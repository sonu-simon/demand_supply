import 'dart:io';
import 'dart:ui';

import 'package:demand_supply/data.dart';
import 'package:demand_supply/screens/profile/viewpropic.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
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
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                onPressed: () {},
                color: Colors.red,
                child: Container(
                  height: 25,
                  width: MediaQuery.of(context).size.width / 3,
                  child: Center(
                      child: Text(
                    "Decline",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  )),
                ),
              ),
              RaisedButton(
                onPressed: () {},
                color: Colors.green,
                child: Container(
                  height: 25,
                  width: MediaQuery.of(context).size.width / 3,
                  child: Center(
                      child: Text(
                    "Verify",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  )),
                ),
              )
            ],
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      image:
                          DecorationImage(image: propic(), fit: BoxFit.cover)),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      child: Container(
                        alignment: Alignment(0.0, 2.5),
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                                onTap: () {
                                  buildShowDialog(context);
                                },
                                child: myProfile.proPicUrl == null
                                    ? CircleAvatar(
                                        radius: 60.0,
                                        backgroundImage:
                                            NetworkImage(myProfile.proPicUrl))
                                    : CircleAvatar(
                                        radius: 60.0,
                                        backgroundImage:
                                            NetworkImage(myProfile.proPicUrl),
                                      )),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 60,
                ),
                Text(
                  myProfile.name,
                  style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.blueGrey,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  myProfile.locality,
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black45,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.w300),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Profile Designation",
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black45,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.w300),
                ),
                SizedBox(
                  height: 10,
                ),
                // /Contact
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        icon: Icon(Icons.message),
                        onPressed: () async {
                          var phone = myProfile.phoneNumber;
                          var whatsappUrl = "whatsapp://send?phone=$phone";
                          await canLaunch(whatsappUrl)
                              ? launch(whatsappUrl)
                              : print(
                                  "open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
                        }),
                    IconButton(
                        icon: Icon(
                          Icons.call,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          var phone = myProfile.phoneNumber;
                          launch("tel://$phone");
                        }),
                    Icon(
                      Icons.assignment_turned_in_outlined,
                      color: Colors.red,
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),

                ExpansionTile(
                  title: Text("Your Posts"),
                  children: [
                    myProfile.posts == null
                        ? ListTile(
                            tileColor: Colors.grey,
                            title: Text("No posts Yet"),
                          )
                        : ListView.builder(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: myProfile.posts.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                title: Text(" "),
                                onTap: () {
                                  //navigate to post logic
                                },
                              );
                            })
                  ],
                )
              ],
            ),
          ),
        ));
  }

  Future buildShowDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListTile(
                      title: Text("View Profile Picture"),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewProPic()));
                      },
                    ),
                    ListTile(
                      title: Text("Change Profile Picture"),
                      onTap: () {
                        openGallery();
                      },
                    )
                  ],
                )),
          );
        });
  }

  NetworkImage propic() {
    return NetworkImage(
        "https://cdn1.iconfinder.com/data/icons/avatar-97/32/avatar-02-512.png");
  }

  Future editPostDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text("Alert"),
              content: Text("Do you want to edit your post"),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text("Okay")),
                FlatButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text("Cancel"))
              ],
            ));
  }

  Future deletePostDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text("Alert"),
              content: Text("Are you sure you want to delete your post"),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text("Okay")),
                FlatButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text("Cancel"))
              ],
            ));
  }
}
