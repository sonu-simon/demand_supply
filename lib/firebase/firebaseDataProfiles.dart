import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demand_supply/data.dart';
import 'package:demand_supply/firebase/firebasePoliceDB.dart';
import 'package:demand_supply/models/policeProfile.dart';
import 'package:demand_supply/models/userProfile.dart';
import 'package:demand_supply/screens/dialogs.dart';
import 'package:flutter/material.dart';

userToFirebase(UserProfile userProfile) {
  print('userID here ${userProfile.userID}');
  FirebaseFirestore.instance.collection('users').doc(userProfile.userID).set({
    'userID': userProfile.userID,
    'name': userProfile.name,
    'proPicUrl': userProfile.proPicUrl,
    'phoneNumber': userProfile.phoneNumber,
    'isAdmin': userProfile.isAdmin,
    'isProfileVerified': userProfile.isProfileVerified,
    'hasPosted': userProfile.hasPosted,
    'locality': userProfile.locality,
    'district': userProfile.locality,
    'policeStation': userProfile.policeStation,
    'whatsappNumber': userProfile.whatsappNumber,
    'emailId': userProfile.emailId,
    'posts': userProfile.posts
  });

  print('user added to firebase');
}

//never used yet, lot of changes in the data models since
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
}

Future retrieveMyUserProfileFromFirebase(String qUserID) async {
  await FirebaseFirestore.instance
      .collection('users')
      .doc(qUserID)
      .get()
      .then((userFromFirebase) {
    UserProfile toCurrentUser = UserProfile(
      userID: userFromFirebase.data()['userID'],
      name: userFromFirebase.data()['name'],
      isAdmin: userFromFirebase.data()['isAdmin'],
      proPicUrl: userFromFirebase.data()['proPicUrl'],
      phoneNumber: userFromFirebase.data()['phoneNumber'],
      locality: userFromFirebase.data()['locality'],
      district: userFromFirebase.data()['district'],
      policeStation: userFromFirebase.data()['policeStation'],
      whatsappNumber: userFromFirebase.data()['whatsappNumber'],
      emailId: userFromFirebase.data()['emailID'],
      mapPosts: userFromFirebase.data()['posts'],
    );
    print(toCurrentUser.posts);
    myProfile = toCurrentUser;
    print('myProfile.userID: ${myProfile.userID}');
    checkIfUserProfileExistsAndAdmin(qUserID);
  });
}

Future<UserProfile> retrieveUserProfileFromFirebase(String qUserID) async {
  UserProfile retrievedUser;
  await FirebaseFirestore.instance
      .collection('users')
      .doc(qUserID)
      .get()
      .then((userFromFirebase) {
    retrievedUser = UserProfile(
      userID: userFromFirebase.data()['userID'],
      name: userFromFirebase.data()['name'],
      isAdmin: userFromFirebase.data()['isAdmin'],
      proPicUrl: userFromFirebase.data()['proPicUrl'],
      phoneNumber: userFromFirebase.data()['phoneNumber'],
      locality: userFromFirebase.data()['locality'],
      district: userFromFirebase.data()['district'],
      policeStation: userFromFirebase.data()['policeStation'],
      whatsappNumber: userFromFirebase.data()['whatsappNumber'],
      emailId: userFromFirebase.data()['emailID'],
      mapPosts: userFromFirebase.data()['posts'],
    );
  });
  return retrievedUser;
}

Future<bool> checkIfUserProfileExistsAndAdmin(String qUserID) async {
  bool exists;
  await FirebaseFirestore.instance
      .collection('users')
      .doc(qUserID)
      .get()
      .then((userDoc) {
    if (userDoc.exists) {
      exists = true;
      myProfileIsAdmin = userDoc.data()['isAdmin'];
    } else
      exists = false;
  });
  print('userExists? = $exists');
  print('isUserAdmin? = $myProfileIsAdmin');
  return exists;
}

setAdminPrivs(PoliceProfile policeProfile, BuildContext context) async {
  print(policeProfile.phoneNumber);
  await FirebaseFirestore.instance
      .collection('users')
      .where('phoneNumber', isEqualTo: policeProfile.phoneNumber)
      .get()
      .then((userProfileSnapshot) async {
    if (userProfileSnapshot.docs.length == 0) {
      showErrorDialog(context, 'This profile doesnt exist!');
    } else {
      showLoading(context, true);
      String toAdminID = userProfileSnapshot.docs.first.data()['userID'];
      policeProfile.userID = toAdminID;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(toAdminID)
          .update({'isAdmin': true});
      print('polcieProfileToFirebase.userID: ${policeProfile.userID}');
      await policeToFirebase(policeProfile);
      showLoading(context, false);
    }
  });
}
