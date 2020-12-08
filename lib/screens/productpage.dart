import 'package:demand_supply/main.dart';
import 'package:demand_supply/models/post.dart';
import 'package:demand_supply/screens/homePage.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:gscarousel/gscarousel.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  Post selectedPost = posts[0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_outlined),
              onPressed: () => Navigator.pop(context)),
          title: Text(selectedPost.title),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height * 1,
          child: SingleChildScrollView(
            child: Column(
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
                      child: GSCarousel(
                        images: productimages,

                        indicatorSize: const Size.square(8.0),
                        indicatorActiveSize: const Size(18.0, 8.0),
                        indicatorColor: Colors.white,
                        indicatorActiveColor: Colors.redAccent,
                        autoPlayDuration: Duration(seconds: 3),
                        animationCurve: Curves.easeIn,
                        contentMode: BoxFit.cover,
                        // indicatorBackgroundColor: Colors.greenAccent,
                      ),
                    )),
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
                        width: MediaQuery.of(context).size.width / 4,
                        // height: MediaQuery.of(context).size.height * 0.07,
                        child: IconButton(
                            icon: Icon(Icons.message),
                            onPressed: () {
                              print("WhatsApp");
                              print('${selectedPost.user.whatsappNumber}');
                            }),
                      ),
                    ),
                    Card(
                      elevation: 5,
                      shadowColor: Colors.grey,
                      child: Container(
                        width: MediaQuery.of(context).size.width / 4,
                        // height: MediaQuery.of(context).size.height * 0.07,
                        child: IconButton(
                            icon: Icon(
                              Icons.call,
                              color: Colors.green,
                            ),
                            onPressed: () {
                              print("Calling...");
                              print('${selectedPost.user.phoneNumber}');
                            }),
                      ),
                    ),
                    Card(
                      elevation: 5,
                      shadowColor: Colors.grey,
                      child: Container(
                        width: MediaQuery.of(context).size.width / 4,
                        // height: MediaQuery.of(context).size.height * 0.07,
                        child: IconButton(
                          icon: Icon(
                            Icons.assignment_turned_in_outlined,
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
                        height: MediaQuery.of(context).size.height * 0.28,
                        child: Center(
                          child:
                              Text("What the product is quantity quality etc"),
                        ),
                      ),
                    ),
                    back: Card(
                      elevation: 5,
                      shadowColor: Colors.grey,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.28,
                        child: Center(
                          child: Text(
                              "where it is and anyither demands if der is"),
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
