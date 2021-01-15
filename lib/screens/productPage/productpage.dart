import 'package:demand_supply/data.dart';
import 'package:demand_supply/firebase/firebaseDataProfiles.dart';
import 'package:demand_supply/models/post.dart';
import 'package:demand_supply/screens/dialogs.dart';
import 'package:demand_supply/screens/post/editPost.dart';
import 'package:demand_supply/screens/profile/userprofilePage.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductPage extends StatefulWidget {
  final Post passedOnPost;
  ProductPage(this.passedOnPost);
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool isOwner = false;

  isOwnerCheck() {
    if (widget.passedOnPost.uUserID == myProfile.userID) isOwner = true;
  }

  @override
  void initState() {
    super.initState();
    isOwnerCheck();
  }

  @override
  Widget build(BuildContext context) {
    var selectedPost = widget.passedOnPost;

    return Scaffold(
        appBar: AppBar(
          title: Text(selectedPost.title),
          actions: [
            Visibility(
              visible: isOwner,
              child: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditPost(selectedPost)),
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Card(
                  elevation: 15,
                  shadowColor: Colors.grey,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.857,
                    child: Column(
                      children: [
                        //product images
                        Center(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.3,
                              width: MediaQuery.of(context).size.width * 0.93,
                              child: Image(
                                image: NetworkImage(selectedPost.imageUrl),
                              ),
                            ),
                          ),
                        ),
                        //tags
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            (selectedPost.uIsProfileVerified == "Verified")
                                ? Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      // color: Colors.blue[100],
                                      borderRadius: BorderRadius.circular(
                                          MediaQuery.of(context).size.height *
                                              0.05),
                                    ),
                                    child: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                        child: Image.asset(
                                            "asset/image/verified.png")))
                                : Container(
                                    child: Text(" "),
                                  ),
                            Container(
                                padding: const EdgeInsets.all(10),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: Colors.blue[300],
                                    borderRadius: BorderRadius.circular(
                                        MediaQuery.of(context).size.height *
                                            0.05)),
                                child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.03,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.location_on_outlined,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          selectedPost.uLocality,
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.026,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )))
                          ],
                        ),
                        //text
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            selectedPost.title,
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.w400),
                          ),
                        ),
                        //
                        //contact
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 5,
                              // height: MediaQuery.of(context).size.height * 0.07,
                              child: IconButton(
                                  icon: Icon(Icons.message),
                                  onPressed: () async {
                                    var whatsappUrl =
                                        "whatsapp://send?phone=${selectedPost.uWhatsappNumber}}";
                                    await canLaunch(whatsappUrl)
                                        ? launch(whatsappUrl)
                                        : print(
                                            "open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
                                  }),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 5,
                              // height: MediaQuery.of(context).size.height * 0.07,
                              child: IconButton(
                                  icon: Icon(
                                    Icons.call,
                                    color: Colors.green,
                                  ),
                                  onPressed: () {
                                    var phone = selectedPost.uPhoneNumber;
                                    launch("tel://$phone");
                                  }),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 5,
                              // height: MediaQuery.of(context).size.height * 0.07,
                              child: IconButton(
                                icon: Icon(
                                  Icons.person,
                                ),
                                onPressed: () {
                                  showLoading(context, true);
                                  retrieveUserProfileFromFirebase(
                                          selectedPost.uUserID)
                                      .then(
                                    (postProfile) {
                                      showLoading(context, false);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => UserProfilePage(
                                            postProfile,
                                            isToVerify: false,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        //date
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: Center(
                            child: Row(children: <Widget>[
                              Expanded(
                                child: new Container(
                                    margin: const EdgeInsets.only(
                                        left: 10.0, right: 20.0),
                                    child: Divider(
                                      color: Colors.grey[500],
                                      height: 36,
                                    )),
                              ),
                              Text(
                                "Date Posted: ${selectedPost.postDate.substring(0, 10)}",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.grey[500]),
                                textAlign: TextAlign.center,
                              ),
                              Expanded(
                                child: new Container(
                                    margin: const EdgeInsets.only(
                                        left: 20.0, right: 10.0),
                                    child: Divider(
                                      color: Colors.grey[500],
                                      height: 36,
                                    )),
                              ),
                            ]),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        //category
                        ListTile(
                          // elevation: 5,
                          // shadowColor: Colors.grey,
                          // child: Container(
                          //   width: MediaQuery.of(context).size.width * 0.9,
                          //   height: MediaQuery.of(context).size.height * 0.07,
                          //   child: Center(
                          //     child: Text(
                          //       "Category: ${selectedPost.category}",
                          //       style: TextStyle(fontSize: 20),
                          //     ),
                          //   ),
                          // ),
                          title: Text(
                            "Category: ${selectedPost.category}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        //Description
                        Card(
                          elevation: 5,
                          shadowColor: Colors.grey,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            // height: MediaQuery.of(context).size.height * 0.28,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: selectedPost.description == null
                                  ? Text("Description is not given")
                                  : Text(
                                      selectedPost.description,
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(fontSize: 18),
                                    ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
