import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demand_supply/data.dart';
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
    'locality': userProfile.locality,
    'district': userProfile.locality,
    'policeStation': userProfile.policeStation,
    'whatsappNumber': userProfile.whatsappNumber,
    'emailId': userProfile.emailId,
    'posts': userProfile.posts
  });

  print('user added to firebase');
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

Future retrieveUserProfileFromFirebase(String qUserID) async {
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
    );

    myProfile = toCurrentUser;
    print('myProfile.userID: ${myProfile.userID}');
    checkIfUserProfileExistsAndAdmin(qUserID);
  });
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

setAdminPrivs(
    String _qPhoneNumber, String _locality, BuildContext context) async {
  print(_qPhoneNumber);
  await FirebaseFirestore.instance
      .collection('users')
      .where('phoneNumber', isEqualTo: _qPhoneNumber)
      .get()
      .then((userProfileSnapshot) async {
    if (userProfileSnapshot.docs.length == 0) {
      showErrorDialog(context, 'This profile doesnt exist!');
    } else {
      showLoading(context, true);
      String toAdminID = userProfileSnapshot.docs.first.data()['userID'];
      await FirebaseFirestore.instance
          .collection('users')
          .doc(toAdminID)
          .update({'isAdmin': true});
      await FirebaseFirestore.instance
          .collection('policePersonnelRecords')
          .doc(_qPhoneNumber)
          .set({
        'userID': toAdminID,
        'phoneNumber': _qPhoneNumber,
        'locality': _locality,
      });
      showLoading(context, false);
    }
  });
}
