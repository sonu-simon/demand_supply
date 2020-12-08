import 'package:demand_supply/screens/imagepicker.dart';
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
          new_post(context);
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

Future new_post(BuildContext context) {
  return showDialog(
      context: context,
      builder: (ctx) => Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Card(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //image part
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    child: Scaffold(
                      body: Center(
                        child: Container(
                          color: Colors.grey,
                          height: MediaQuery.of(context).size.height / 4,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Center(child: Text("Add Image")),
                        ),
                      ),
                      floatingActionButton: FloatingActionButton(
                        child: Icon(Icons.photo_album_outlined),
                        onPressed: () {
                          ImagePicker();
                        },
                      ),
                    ),
                  ),
                  //textboxes
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          //title
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 1.0, horizontal: 14),
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null)
                                  return 'Phone number cannot be empty';
                                return null;
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(20),
                                    ),
                                  ),
                                  filled: true,
                                  hintStyle:
                                      new TextStyle(color: Colors.grey[800]),
                                  hintText: "Title",
                                  fillColor: Colors.white70),
                              onChanged: (value) {},
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 14),
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null)
                                  return 'Phone number cannot be empty';
                                return null;
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(20),
                                    ),
                                  ),
                                  filled: true,
                                  hintStyle:
                                      new TextStyle(color: Colors.grey[800]),
                                  hintText: "Description",
                                  fillColor: Colors.white70),
                              onChanged: (value) {},
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 14),
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null)
                                  return 'Phone number cannot be empty';
                                return null;
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(20),
                                    ),
                                  ),
                                  filled: true,
                                  hintStyle:
                                      new TextStyle(color: Colors.grey[800]),
                                  hintText: "Locality",
                                  fillColor: Colors.white70),
                              onChanged: (value) {},
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 14),
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null)
                                  return 'Phone number cannot be empty';
                                return null;
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(20),
                                    ),
                                  ),
                                  filled: true,
                                  hintStyle:
                                      new TextStyle(color: Colors.grey[800]),
                                  hintText: "10 digit phone number",
                                  fillColor: Colors.white70),
                              onChanged: (value) {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RaisedButton(
                        onPressed: () => Navigator.pop(context),
                        color: Colors.red,
                        child: Text("Cancel"),
                      ),
                      RaisedButton(
                        onPressed: () => Navigator.pop(context),
                        color: Colors.green,
                        child: Text("Post"),
                      ),
                    ],
                  )
                ],
              ),
            )),
          ));
}
