import 'package:demand_supply/data.dart';
import 'package:demand_supply/firebase/firebaseDataPosts.dart';
import 'package:demand_supply/screens/dialogs.dart';
import 'package:demand_supply/screens/newpost.dart';
import 'package:demand_supply/screens/productPage/productpage.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PostsByCategory extends StatefulWidget {
  final String qDistrict = myProfile.district;
  final String qCategory;

  PostsByCategory({this.qCategory});
  @override
  _PostsByCategoryState createState() => _PostsByCategoryState();
}

class _PostsByCategoryState extends State<PostsByCategory> {
  bool statusRetrieveFromFirebase = false;
  @override
  void initState() {
    super.initState();

    retrievePostsFromFirebaseByDistrictFilterByCategory(
            uDistrict: widget.qDistrict, category: widget.qCategory)
        .then((_) {
      setState(() {
        statusRetrieveFromFirebase = true;
        print('after retrieval setState()');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Posts in ${widget.qCategory}"),
        actions: [
          Icon(Icons.location_pin),
          Padding(
            padding: const EdgeInsets.only(left: 4.0, right: 8.0),
            child: Center(child: Text(myProfile.locality)),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NewPost()));
        },
        splashColor: Colors.cyan,
        child: Icon(Icons.add),
      ),
      body: !statusRetrieveFromFirebase
          ? Center(
              child: CircularProgressIndicator(),
            )
          : postsInDistrictFilterByCategory.isEmpty
              ? Center(
                  child: Text("No posts available here !"),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: postsInDistrictFilterByCategory.length,
                  itemBuilder: (context, index) {
                    print(postsInDistrictFilterByCategory[index].postDate);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: FlipCard(
                            front: Card(
                                elevation: 5,
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 4,
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: Stack(children: [
                                    //image
                                    Center(
                                      child:
                                          postsInDistrictFilterByCategory[index]
                                                      .imageUrl !=
                                                  null
                                              ? Image(
                                                  image: NetworkImage(
                                                      postsInDistrictFilterByCategory[
                                                              index]
                                                          .imageUrl),
                                                  alignment: Alignment.center,
                                                  repeat: ImageRepeat.noRepeat,
                                                )
                                              : Text(
                                                  'No image available',
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                    ),
                                    //text
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          color: Colors.white.withOpacity(0.5),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Center(
                                              child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Text(
                                              postsInDistrictFilterByCategory[
                                                      index]
                                                  .title,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          )),
                                        )
                                      ],
                                    )
                                  ]),
                                )),
                            back: Card(
                              elevation: 5,
                              child: Container(
                                color: Colors.white,
                                height: MediaQuery.of(context).size.height / 4,
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Padding(
                                    //   padding: const EdgeInsets.only(top: 8),
                                    //   child: Text(
                                    //     "Description:",
                                    //     style: TextStyle(fontSize: 16),
                                    //   ),
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 8.0),
                                      child: Text(
                                        postsInDistrictFilterByCategory[index]
                                                    .description ==
                                                null
                                            ? ""
                                            : postsInDistrictFilterByCategory[
                                                    index]
                                                .description,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 4,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        IconButton(
                                            icon: Icon(Icons.message),
                                            onPressed: () async {
                                              if (postsInDistrictFilterByCategory[
                                                          index]
                                                      .uWhatsappNumber !=
                                                  null) {
                                                var whatsappUrl =
                                                    "whatsapp://send?phone=${postsInDistrictFilterByCategory[index].uWhatsappNumber}";
                                                await canLaunch(whatsappUrl)
                                                    ? launch(whatsappUrl)
                                                    : print(
                                                        "open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
                                              } else
                                                showErrorDialog(context,
                                                    'Whatsapp contact not available');
                                            }),
                                        IconButton(
                                            icon: Icon(
                                              Icons.call,
                                              color: Colors.green,
                                            ),
                                            onPressed: () {
                                              launch(
                                                  "tel://${postsInDistrictFilterByCategory[index].uPhoneNumber}");
                                            }),
                                        Icon(
                                          Icons.assignment_turned_in_outlined,
                                          color:
                                              postsInDistrictFilterByCategory[
                                                          index]
                                                      .isVerified
                                                  ? Colors.green
                                                  : Colors.red,
                                        ),
                                        IconButton(
                                            icon: Icon(Icons.more),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ProductPage(
                                                              postsInDistrictFilterByCategory[
                                                                  index])));
                                            })
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ),
                    );
                  }),
    );
  }
}
