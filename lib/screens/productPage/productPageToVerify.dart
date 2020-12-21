import 'package:demand_supply/models/post.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:demand_supply/firebase/firebaseDataPosts.dart';

class ProductPageToVerify extends StatefulWidget {
  final Post passedOnPost;
  ProductPageToVerify(this.passedOnPost);
  @override
  _ProductPageToVerifyState createState() => _ProductPageToVerifyState();
}

class _ProductPageToVerifyState extends State<ProductPageToVerify> {
  @override
  Widget build(BuildContext context) {
    var selectedPost = widget.passedOnPost;

    return Scaffold(
        appBar: AppBar(
          title: Text(selectedPost.title),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.901,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.010,
                ),
                //product images
                Center(
                  child: Card(
                    elevation: 5,
                    shadowColor: Colors.grey,
                    child: Container(
                        child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.width * 0.93,
                            child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Image(
                                  image: NetworkImage(selectedPost.imageUrl),
                                )))),
                  ),
                ),
                //text
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: Text(
                    selectedPost.title,
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w400),
                  ),
                ),
                //
                //contact
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Card(
                      elevation: 5,
                      shadowColor: Colors.grey,
                      child: Container(
                        width: MediaQuery.of(context).size.width / 5,
                        // height: MediaQuery.of(context).size.height * 0.07,
                        child: IconButton(
                            icon: Icon(Icons.message),
                            onPressed: () {
                              print("WhatsApp");
                              print(
                                  '${selectedPost.userProfile.whatsappNumber}');
                            }),
                      ),
                    ),
                    Card(
                      elevation: 5,
                      shadowColor: Colors.grey,
                      child: Container(
                        width: MediaQuery.of(context).size.width / 5,
                        // height: MediaQuery.of(context).size.height * 0.07,
                        child: IconButton(
                            icon: Icon(
                              Icons.call,
                              color: Colors.green,
                            ),
                            onPressed: () {
                              print("Calling...");
                              print('${selectedPost.userProfile.phoneNumber}');
                            }),
                      ),
                    ),
                    Card(
                      elevation: 5,
                      shadowColor: Colors.grey,
                      child: Container(
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
                    ),
                    Card(
                      elevation: 5,
                      shadowColor: Colors.grey,
                      child: Container(
                        width: MediaQuery.of(context).size.width / 5,
                        // height: MediaQuery.of(context).size.height * 0.07,
                        child: IconButton(
                          icon: selectedPost.isVerified != null
                              ? Icon(
                                  Icons.verified_user_outlined,
                                  color: Colors.green,
                                )
                              : Icon(
                                  Icons.verified_user_outlined,
                                  color: Colors.red,
                                ),
                          onPressed: () {},
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                //
                //category
                Card(
                  elevation: 5,
                  shadowColor: Colors.grey,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: Center(
                      child: Text(
                        "Category:${selectedPost.category}",
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
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  color: Colors.green,
                  child: InkWell(
                    child: Center(
                      child: Text(
                        'VERIFY POST',
                        style: TextStyle(
                          fontSize: 24,
                          letterSpacing: 2,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    onTap: () =>
                        verifyPostByAdmin(selectedPost.postInPathCollection),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}