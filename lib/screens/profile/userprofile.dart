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
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(image: propic(), fit: BoxFit.cover)),
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
                                    backgroundImage: NetworkImage(
                                        "https://cdn1.iconfinder.com/data/icons/avatar-97/32/avatar-02-512.png"))
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
            ExpansionTile(
              title: Text("Details"),
              children: [
                ListTile(
                  title: Text("Name"),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              scrollable: true,
                              title: Text('Details'),
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Form(
                                  child: Column(
                                    children: <Widget>[
                                      TextFormField(
                                        decoration: InputDecoration(
                                          labelText: 'Name',
                                        ),
                                      ),
                                      TextFormField(
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          labelText: 'Phone',
                                        ),
                                      ),
                                      TextFormField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          labelText: 'Email',
                                        ),
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          labelText: 'Locality',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              actions: [
                                RaisedButton(
                                    child: Text("Submit"),
                                    onPressed: () {
                                      // your code
                                    })
                              ],
                            );
                          });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(myProfile.phoneNumber),
                        Text(myProfile.locality),
                        // Text(myProfile.emailId),
                      ],
                    ),
                  ),
                )
              ],
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
                        itemCount: myProfile.posts.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading: IconButton(
                              icon: Icon(Icons.delete_forever_outlined),
                              onPressed: () {
                                return deletePostDialog(context);
                              },
                            ),
                            title: Text(" "),
                            trailing: IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  return editPostDialog(context);
                                }),
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
