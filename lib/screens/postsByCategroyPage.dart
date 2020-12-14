import 'package:demand_supply/data.dart';
import 'package:demand_supply/firebase/firebaseData.dart';
import 'package:demand_supply/screens/newpost.dart';
import 'package:demand_supply/screens/productpage.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class PostsByCategory extends StatefulWidget {
  final String qLocality = myProfile.locality;
  final String qCategory;

  PostsByCategory({this.qCategory});
  @override
  _PostsByCategoryState createState() => _PostsByCategoryState();
}

class _PostsByCategoryState extends State<PostsByCategory> {
  @override
  void initState() {
    super.initState();

    retrievePostsFromFirebaseByLocalityFilterByCategory(
            uLocality: widget.qLocality, category: widget.qCategory)
        .then((value) {
      setState(() {
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
      body: postsInLocalityFilterByCategory.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: postsInLocalityFilterByCategory.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: FlipCard(
                        front: Card(
                            elevation: 5,
                            child: Container(
                              height: MediaQuery.of(context).size.height / 4,
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Stack(children: [
                                //image
                                Center(
                                  child: Image(
                                    image: NetworkImage(
                                        postsInLocalityFilterByCategory[index]
                                            .imageUrl),
                                    alignment: Alignment.center,
                                    repeat: ImageRepeat.noRepeat,
                                  ),
                                ),
                                //text
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      color: Colors.white.withOpacity(0.5),
                                      width: MediaQuery.of(context).size.width,
                                      child: Center(
                                          child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Text(
                                          postsInLocalityFilterByCategory[index]
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    postsInLocalityFilterByCategory[index]
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
                                        onPressed: () {
                                          print("WhatsApp");
                                        }),
                                    IconButton(
                                        icon: Icon(
                                          Icons.call,
                                          color: Colors.green,
                                        ),
                                        onPressed: () {
                                          print("Calling...");
                                        }),
                                    Icon(
                                      Icons.assignment_turned_in_outlined,
                                      color: Colors.red,
                                    ),
                                    IconButton(
                                        icon: Icon(Icons.more),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductScreen()));
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
