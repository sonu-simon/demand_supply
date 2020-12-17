import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demand_supply/models/userProfile.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/post.dart';
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

postToFirebase(Post post) {
  FirebaseFirestore.instance
      .collection('postsByDistrict')
      .doc(post.uDistrict)
      .collection('posts')
      .doc(post.id)
      .set({
    'id': post.id,
    'title': post.title,
    'category': post.category,
    'description': post.description,
    'imageUrl': post.imageUrl,
    'isVerified': post.isVerified,
    'postDate': post.postDate,
    'uEmailId': post.uEmailId,
    'uUserID': post.uUserID,
    'uLocality': post.uLocality,
    'uDistrict': post.uDistrict,
    'uPoliceStation': post.uPoliceStation,
    'uName': post.uName,
    'uPhoneNumber': post.uPhoneNumber,
    'uProPicUrl': post.uProPicUrl,
    'uWhatsappNumber': post.uWhatsappNumber,
  });

  // Scaffold.of(context).showSnackBar(SnackBar(
  //   content: Text("Upload complete"),
  //   duration: Duration(seconds: 2),
  // ));
}

userToFirebase(UserProfile userProfile) {
  print('userID here ${userProfile.userID}');
  FirebaseFirestore.instance.collection('users').doc(userProfile.userID).set({
    'userID': userProfile.userID,
    'name': userProfile.name,
    'proPicUrl': userProfile.proPicUrl,
    'phoneNumber': userProfile.phoneNumber,
    'locality': userProfile.locality,
    'district': userProfile.locality,
    'policeStation': userProfile.policeStation,
    'whatsappNumber': userProfile.whatsappNumber,
    'emailId': userProfile.emailId,
    'posts': userProfile.posts
  });

  print('user added to firebase');

  // Scaffold.of(context).showSnackBar(SnackBar(
  //   content: Text("User Profile created!"),
  //   duration: Duration(seconds: 2),
  // ));
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
  DocumentSnapshot listOfLocalitiesSnapshot = await FirebaseFirestore.instance
      .collection('listOfLocalities')
      .doc('localityList')
      .get();
  listOfLocalities = List.from(listOfLocalitiesSnapshot.data()['localities']);
  print(listOfLocalities);
}

updateUserInFirebase(UserProfile userProfile) {
  FirebaseFirestore.instance
      .collection('users')
      .doc(userProfile.userID)
      .update({
    'id': userProfile.userID,
    'category': userProfile.name,
    'description': userProfile.proPicUrl,
    'imageUrls': userProfile.phoneNumber,
    'locality': userProfile.locality,
    'district': userProfile.district,
    'policeStation': userProfile.policeStation,
    'postDate': userProfile.whatsappNumber,
    'uEmailId': userProfile.emailId,
  });

  // Scaffold.of(context).showSnackBar(SnackBar(
  //   content: Text("User Profile updated!"),
  //   duration: Duration(seconds: 2),
  // ));
}

Future retrievePostsFromFirebaseByDistrictFilterByCategory(
    {String uDistrict, String category}) async {
  postsInDistrictFilterByCategory = [];
  await FirebaseFirestore.instance
      .collection('postsByDistrict')
      .doc(uDistrict)
      .collection('posts')
      .where('category', isEqualTo: category)
      .get()
      .then((QuerySnapshot querySnapshot) {
    print(
        'entered .then() retrievePostsFromFirebaseByLocalityFilterByCategory()');
    querySnapshot.docs.forEach((post) {
      Post postToAddList = Post(
        id: post.data()['id'],
        title: post.data()['title'],
        postDate: post.data()['postDate'],
        category: post.data()['category'],
        description: post.data()['description'],
        imageUrl: post.data()['imageUrl'],
        isVerified: post.data()['isVerified'],
        uName: post.data()['uName'],
        uPhoneNumber: post.data()['uPhoneNumber'],
        uWhatsappNumber: post.data()['uWhatsappNumber'],
        uProPicUrl: post.data()['uProPicUrl'],
        uLocality: post.data()['uLocation'],
        uDistrict: post.data()['uDistrict'],
        uPoliceStation: post.data()['uPoliceStation'],
        uEmailId: post.data()['uEmailId'],
        uUserID: post.data()['uUserID'],
      );

      postsInDistrictFilterByCategory.add(postToAddList);
    });
    return print(postsInDistrictFilterByCategory);
  });
}

Future retrieveUserProfileFromFirebase(String qUserID) async {
  await FirebaseFirestore.instance
      .collection('users')
      .doc(qUserID)
      .get()
      .then((userFromFirebase) {
    UserProfile toCurrentUser = UserProfile(
        userID: userFromFirebase.data()['userID'],
        name: userFromFirebase.data()['name'],
        proPicUrl: userFromFirebase.data()['proPicUrl'],
        phoneNumber: userFromFirebase.data()['phoneNumber'],
        locality: userFromFirebase.data()['location'],
        district: userFromFirebase.data()['district'],
        policeStation: userFromFirebase.data()['policeStation'],
        whatsappNumber: userFromFirebase.data()['whatsappNumber'],
        emailId: userFromFirebase.data()['emailID']);

    myProfile = toCurrentUser;
    print('myProfile.userID: ${myProfile.userID}');
  });
}

Future<bool> checkIfUserProfileExists(String qUserID) async {
  bool exists;
  await FirebaseFirestore.instance
      .collection('users')
      .doc(qUserID)
      .get()
      .then((userDoc) {
    if (userDoc.exists)
      exists = true;
    else
      exists = false;
  });
  print('userExists? = $exists');
  return exists;
}
