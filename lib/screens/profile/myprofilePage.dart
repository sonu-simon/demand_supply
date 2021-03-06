import 'dart:io';
import 'dart:ui';

import 'package:demand_supply/data.dart';
import 'package:demand_supply/firebase/firebaseDataPosts.dart';
import 'package:demand_supply/firebase/firebaseDataProfiles.dart';
import 'package:demand_supply/models/post.dart';
import 'package:demand_supply/screens/dialogs.dart';
import 'package:demand_supply/screens/productPage/productpage.dart';
import 'package:demand_supply/screens/profile/viewpropic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
    SchedulerBinding.instance.addPostFrameCallback((_) {
      showLoading(context, true);
      retrieveMyUserProfileFromFirebase(currentUserID)
          .then((_) => showLoading(context, false));
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
                            child: myProfile.proPicUrl != null
                                ? CircleAvatar(
                                    radius: 60.0,
                                    backgroundImage:
                                        NetworkImage(myProfile.proPicUrl),
                                  )
                                : CircleAvatar(
                                    radius: 60.0,
                                    backgroundImage:
                                        AssetImage("asset/image/propic.png"))),
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
            ExpansionTile(
              title: Text("Details"),
              children: [
                ListTile(
                  title: Text("Name"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(myProfile.phoneNumber),
                        Text(myProfile.locality),
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
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: myProfile.posts.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 6.0),
                            child: ListTile(
                              onTap: () async {
                                //navigate to post logic
                                showLoading(context, true);
                                Post postToShow = await postByPostPath(
                                    myProfile.posts[index].postPath);

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProductPage(postToShow)));
                              },
                              tileColor: Colors.blue[100],
                              title: Text(myProfile.posts[index].title),
                            ),
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
