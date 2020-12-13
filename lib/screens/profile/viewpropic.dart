import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ViewProPic extends StatefulWidget {
  @override
  _ViewProPicState createState() => _ViewProPicState();
}

class _ViewProPicState extends State<ViewProPic> {
  File _image;

  void openGallery() async {
    final picker = ImagePicker();
    PickedFile pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      print('in .then()');
      _image = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                openGallery();
                //dialoguebox adakkam kalayaan 2 pop popuntil orma illa
                Navigator.pop(context);
                Navigator.pop(context);
              })
        ],
      ),
      body: Container(
        color: Colors.black87,
        height: MediaQuery.of(context).size.height,
        child: Container(
          alignment: Alignment.center,
          child: Container(
            child: Image(
              image: NetworkImage(
                  "https://cdn1.iconfinder.com/data/icons/avatar-97/32/avatar-02-512.png"),
            ),
          ),
        ),
      ),
    );
  }
}
