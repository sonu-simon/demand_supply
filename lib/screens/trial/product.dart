import 'package:demand_supply/models/post.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductPageTrial extends StatefulWidget {
  final Post passedOnPost;
  ProductPageTrial(this.passedOnPost);
  @override
  _ProductPageTrialState createState() => _ProductPageTrialState();
}

class _ProductPageTrialState extends State<ProductPageTrial> {
  @override
  Widget build(BuildContext context) {
    var selectedPost = widget.passedOnPost;

    return Scaffold(
        appBar: AppBar(
          title: Text(selectedPost.title),
        ),
        body: Container(
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
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                width: MediaQuery.of(context).size.width * 0.93,
                                child: FittedBox(
                                    fit: BoxFit.fitHeight,
                                    child: Image(
                                      image:
                                          NetworkImage(selectedPost.imageUrl),
                                    )))),
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
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => ProductPage(
                                //             postsInDistrictFilterByCategory[
                                //                 index]))
                                // );
                              },
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 5,
                            // height: MediaQuery.of(context).size.height * 0.07,
                            child: IconButton(
                              icon: if(selectedPost.uIsProfileVerified=="true"){Icon(
                                      Icons.verified_user_outlined,
                                      color: Colors.green,
                                    )
                              }
                                  ? 
                                  : Icon(
                                      Icons.verified_user_outlined,
                                      color: Colors.red,
                                    ),
                              onPressed: () {
                                print(selectedPost.isVerified);
                              },
                            ),
                          )
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
                      Card(
                        elevation: 5,
                        shadowColor: Colors.grey,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: Center(
                            child: Text(
                              "Category: ${selectedPost.category}",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      //Details

                      FlipCard(
                          front: Card(
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
                                      ),
                              ),
                            ),
                          ),
                          back: Card(
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
                                        ),
                                ),
                              )))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
