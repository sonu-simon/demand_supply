import 'package:demand_supply/screens/newpost.dart';
import 'package:demand_supply/screens/productpage.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class RecentPage extends StatefulWidget {
  @override
  _RecentPageState createState() => _RecentPageState();
}

class _RecentPageState extends State<RecentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demands and Supplies Near You"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NewPost()));
        },
        splashColor: Colors.cyan,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: 10,
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
                                    'https://www.blibli.com/friends/assets/banner2.jpg'),
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
                                      "Product Name",
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
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                "Description:",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "Some of the main reasons include the addition of a flagship Snapgragon 865 processor, yes finally Samsung have given us one of their devices with a Snapgragon processor in the UK! An awesome triple lens camera system which is versatile and takes great images/video even in low light. Also the amazing 6.5 120hz super amoled screen adds to the superfast feeling of the phone, with bright vibrant colours and decent outdoor brightness. The battery life is superb and I get almost 7 hours of screen on time with medium/heavy use, I wish it came with a superfast 25w charger but you have to buy that separate. The software skin",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 4,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
