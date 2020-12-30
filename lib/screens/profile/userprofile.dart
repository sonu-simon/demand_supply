import 'dart:ui';

import 'package:demand_supply/firebase/firebaseDataPosts.dart';
import 'package:demand_supply/models/post.dart';
import 'package:demand_supply/models/userProfile.dart';
import 'package:demand_supply/screens/dialogs.dart';
import 'package:demand_supply/screens/productPage/productpage.dart';
import 'package:demand_supply/screens/profile/viewpropic.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UserProfilePage extends StatefulWidget {
  final UserProfile passedProfile;
  final bool isToVerify;
  UserProfilePage(this.passedProfile, {this.isToVerify});

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: widget.isToVerify
            ? BottomAppBar(
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
              )
            : Container(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(widget.passedProfile.proPicUrl),
                          fit: BoxFit.cover)),
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
                              child: widget.passedProfile.proPicUrl == null
                                  ? CircleAvatar(
                                      radius: 60.0,
                                      backgroundImage: NetworkImage(
                                          //TODO: do no proPic stuff
                                          widget.passedProfile.proPicUrl),
                                    )
                                  : CircleAvatar(
                                      radius: 60.0,
                                      backgroundImage: NetworkImage(
                                          widget.passedProfile.proPicUrl),
                                    ),
                            ),
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
                  widget.passedProfile.name,
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
                  widget.passedProfile.locality,
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
                          var phone = widget.passedProfile.phoneNumber;
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
                          var phone = widget.passedProfile.phoneNumber;
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
                  title: Text("Posts by user"),
                  children: [
                    widget.passedProfile.posts == null
                        ? ListTile(
                            tileColor: Colors.grey,
                            title: Text("No posts Yet"),
                          )
                        : ListView.builder(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: widget.passedProfile.posts.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 6.0),
                                child: ListTile(
                                  title: Text(
                                      widget.passedProfile.posts[index].title),
                                  tileColor: Colors.blue[100],
                                  onTap: () async {
                                    //navigate to post logic
                                    showLoading(context, true);
                                    Post postToShow = await postByPostPath(
                                        widget.passedProfile.posts[index]
                                            .postPath);

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProductPage(postToShow)));
                                  },
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
                  ],
                )),
          );
        });
  }
}
