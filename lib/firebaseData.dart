import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demand_supply/firebaseServices.dart';
import 'package:demand_supply/models/userProfile.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'models/post.dart';

Future uploadimage(String userID, String postID, File _image) async {
  String _imgSrc;
  if (_image != null) {
    StorageReference ref = FirebaseStorage.instance.ref();
    StorageTaskSnapshot addImg =
        await ref.child("$userID/$postID").putFile(_image).onComplete;
    if (addImg.error == null) {
      print("added to Firebase Storage");
      _imgSrc = await addImg.ref.getDownloadURL();
      print(_imgSrc);
    } else {
      print('Error from image repo ${addImg.error.toString()}');
      throw ('This file is not an image');
    }
  }
}

postToFirebase(Post post, BuildContext context) {
  FirebaseFirestore.instance.collection('posts').doc(post.id).set({
    'id': post.id,
    'category': post.category,
    'description': post.description,
    'imageUrls': post.imageUrls,
    'isVerified': post.isVerified,
    'postDate': post.postDate,
    'uEmailId': post.uEmailId,
    'uLocation': post.uLocation,
    'uName': post.uName,
    'uPhoneNumber': post.uPhoneNumber,
    'uProPicUrl': post.uProPicUrl,
    'uWhatsappNumber': post.uWhatsappNumber,
  });

  Scaffold.of(context).showSnackBar(SnackBar(
    content: Text("Upload complete"),
    duration: Duration(seconds: 2),
  ));
}

userToFirebase(UserProfile userProfile, BuildContext context) {
  FirebaseFirestore.instance.collection('users').doc(userID).set({
    'id': userProfile.userID,
    'category': userProfile.name,
    'description': userProfile.proPicUrl,
    'imageUrls': userProfile.phoneNumber,
    'isVerified': userProfile.location,
    'postDate': userProfile.whatsappNumber,
    'uEmailId': userProfile.emailId,
  });

  Scaffold.of(context).showSnackBar(SnackBar(
    content: Text("User Profile created!"),
    duration: Duration(seconds: 2),
  ));
}

addLocalityToFirestore(String locality) {
  FirebaseFirestore.instance
      .collection('listOfLocalities')
      .doc("localityList")
      .update({
    "localities": FieldValue.arrayUnion([locality])
  });
}

retrieveListOfLocalities() async {
  DocumentSnapshot listOfLocalities = await FirebaseFirestore.instance
      .collection('listOfLocalities')
      .doc('localityList')
      .get();
  print(listOfLocalities.data().values);
}
