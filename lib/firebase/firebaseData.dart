import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../data.dart';

Future<String> uploadPostImage(
    String userID, String postID, File _image) async {
  String _imgSrc;
  if (_image != null) {
    StorageReference ref = FirebaseStorage.instance.ref();
    StorageTaskSnapshot addImg =
        await ref.child("$userID/$postID").putFile(_image).onComplete;
    if (addImg.error == null) {
      print("postImage added to Firebase Storage");
      _imgSrc = await addImg.ref.getDownloadURL();
      print(_imgSrc);
    } else {
      print('Error from image repo ${addImg.error.toString()}');
      throw ('This file is not an image');
    }
  }
  return _imgSrc;
}

Future<String> uploadUserProPicImage(String userID, File _image) async {
  String _imgSrc;
  if (_image != null) {
    StorageReference ref = FirebaseStorage.instance.ref();
    StorageTaskSnapshot addImg =
        await ref.child("users/$userID").putFile(_image).onComplete;
    if (addImg.error == null) {
      print("userProPic added to Firebase Storage");
      _imgSrc = await addImg.ref.getDownloadURL();
      print(_imgSrc);
    } else {
      print('Error from image repo ${addImg.error.toString()}');
      throw ('This file is not an image');
    }
  }
  return _imgSrc;
}

addLocalityToFirestore(String locality) {
  FirebaseFirestore.instance
      .collection('listOfLocalities')
      .doc("localityList")
      .update({
    "localities": FieldValue.arrayUnion([locality])
  });
}

Future retrieveLocationRelatedLists() async {
  await retrieveListOfDistricts();
  await retrieveListOfLocalities();
  await retrieveListOfPoliceStations();
}

Future retrieveListOfLocalities() async {
  DocumentSnapshot listOfLocalitiesSnapshot = await FirebaseFirestore.instance
      .collection('listOfLocalities')
      .doc('localityList')
      .get();
  listOfLocalities = List.from(listOfLocalitiesSnapshot.data()['localities']);
  print(listOfLocalities);
}

Future retrieveListOfDistricts() async {
  DocumentSnapshot listOfLocalitiesSnapshot = await FirebaseFirestore.instance
      .collection('listOfDistricts')
      .doc('districtList')
      .get();
  listOfDistricts = List.from(listOfLocalitiesSnapshot.data()['localities']);
  print(listOfLocalities);
}

Future retrieveListOfPoliceStations() async {
  DocumentSnapshot listOfLocalitiesSnapshot = await FirebaseFirestore.instance
      .collection('listOfPoliceStations')
      .doc('policeStationList')
      .get();
  listOfPoliceStaions =
      List.from(listOfLocalitiesSnapshot.data()['localities']);
  print(listOfLocalities);
}
