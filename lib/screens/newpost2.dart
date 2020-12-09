import 'package:flutter/material.dart';

class NewPost extends StatefulWidget {
  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  String Phonenumber = "+91 9846195666";
  List<Image> post_images = [];
  int count = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.arrow_back,
          color: Colors.blue,
        ),
        title: Text(
          "NewPost",
          style: TextStyle(color: Colors.blue),
        ),
        actions: [
          RaisedButton(
            color: Colors.white,
            hoverColor: Colors.white,
            splashColor: Colors.white,
            elevation: 0,
            onPressed: () {},
            child: Text(
              "POST",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                //title
                TextField(
                  style: TextStyle(fontSize: 30, color: Colors.black87),
                  autofocus: true,
                  maxLines: 1,
                  maxLength: 50,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0)),
                      focusColor: Colors.black,
                      border: InputBorder.none,
                      helperText:
                          "This is what other users will see along with pictures",
                      hintText: "Title",
                      hintStyle: TextStyle(fontSize: 30)),
                ),
                SizedBox(
                  height: 25,
                ),
                //Description
                TextField(
                  style: TextStyle(fontSize: 15, color: Colors.black87),
                  autofocus: true,
                  maxLines: 4,
                  maxLength: 170,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0)),
                      helperText: "Give a brief Description",
                      hintText: "Description",
                      hintStyle: TextStyle(fontSize: 20)),
                ),
                SizedBox(
                  height: 25,
                ),
                //phone&whatsapp
                TextField(
                  style: TextStyle(fontSize: 20, color: Colors.black87),
                  autofocus: true,
                  maxLines: 1,
                  maxLength: 10,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0)),
                      focusColor: Colors.black,
                      border: InputBorder.none,
                      helperText: "phone number to be given for contacting you",
                      hintText: Phonenumber,
                      hintStyle: TextStyle(fontSize: 20)),
                ),
                SizedBox(
                  height: 25,
                ),
                //locality
                TextField(
                  style: TextStyle(fontSize: 20, color: Colors.black87),
                  autofocus: true,
                  maxLines: 1,
                  maxLength: 50,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0)),
                      focusColor: Colors.black,
                      border: InputBorder.none,
                      helperText:
                          "The locality will help people near to you reach you easier",
                      hintText: "Locality",
                      hintStyle: TextStyle(fontSize: 20)),
                ),
                SizedBox(
                  height: 25,
                ),
                //images
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Container(
                          height: MediaQuery.of(context).size.height * 0.15,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: count,
                              itemBuilder: (BuildContext context, int index) {
                                if (count == 1) {
                                  return Card(
                                    child: InkWell(
                                      onTap: () {
                                        //image kayataanulla code
                                        //add image to post_image
                                        setState(() {
                                          count++;
                                        });
                                        print("Njengi");
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.15,
                                        child: Image(
                                          image: AssetImage(
                                              "asset/image/nill.jpg"),
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Card(
                                    child: InkWell(
                                      onTap: () {
                                        //image kayataanulla code
                                        //add image to post_image
                                        setState(() {
                                          count++;
                                        });
                                        print("Njengi");
                                      },
                                      child: Container(
                                          alignment: Alignment.center,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.15,
                                          child: post_images[index]),
                                    ),
                                  );
                                }
                              })),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "Add images for your post",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
