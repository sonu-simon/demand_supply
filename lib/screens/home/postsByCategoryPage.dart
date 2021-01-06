import 'package:demand_supply/data.dart';
import 'package:demand_supply/firebase/firebaseDataPosts.dart';
import 'package:demand_supply/screens/dialogs.dart';
import 'package:demand_supply/screens/post/newPost.dart';
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
                : GridView.count(
                    crossAxisCount: 2,
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    children: List.generate(
                        postsInDistrictFilterByCategory.length, (index) {
                      return Container(
                        child: InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductPage(
                                      postsInDistrictFilterByCategory[index]))),
                          child: FlipCard(
                            front: Stack(
                              children: [
                                Card(
                                  color: Colors.grey[350],
                                  child: Container(
                                    height: MediaQuery.of(context).size.height,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.fitWidth,
                                            image: NetworkImage(
                                                postsInDistrictFilterByCategory[
                                                        index]
                                                    .imageUrl))),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 16,
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.white.withOpacity(0.75),
                                    child: Center(
                                      child: Text(
                                        postsInDistrictFilterByCategory[index]
                                            .title
                                            .toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                30),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            back: Card(
                              child: Container(
                                color: Colors.grey[200],
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        postsInDistrictFilterByCategory[index]
                                            .title
                                            .toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                30),
                                      ),
                                      Text(
                                        postsInDistrictFilterByCategory[index]
                                            .description,
                                        maxLines: 3,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                35),
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
                                                (postsInDistrictFilterByCategory[
                                                                index]
                                                            .uIsProfileVerified ==
                                                        "Verified")
                                                    ? Colors.green
                                                    : Colors.red,
                                          ),
                                          IconButton(
                                              icon: Icon(
                                                  Icons.open_in_new_outlined),
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
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ));
  }
}
