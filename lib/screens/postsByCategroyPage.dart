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
        actions: [Icon(Icons.location_pin), Text(myProfile.locality)],
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
