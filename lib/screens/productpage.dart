import 'package:demand_supply/main.dart';
import 'package:demand_supply/screens/homePage.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:gscarousel/gscarousel.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  String adcategory = "Trial";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_outlined),
              onPressed: () => Navigator.pop(context)),
          title: Text("Product name"),
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
                    child: new Container(
                        child: new SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 0.93,
                      child: new GSCarousel(
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
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Product Name",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
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
                        "Category:$adcategory",
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
