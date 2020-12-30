import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demand_supply/data.dart';
import 'package:demand_supply/models/policeProfile.dart';
import 'package:demand_supply/models/userProfile.dart';
import 'package:demand_supply/screens/dialogs.dart';
import 'package:flutter/cupertino.dart';

Future policeToFirebase(PoliceProfile policeProfile) async {
  await FirebaseFirestore.instance
      .collection('policeDB')
      .doc(policeProfile.phoneNumber)
      .set({
    'userID': policeProfile.userID,
    'phoneNumber': policeProfile.phoneNumber,
    'localities': policeProfile.localities
  });
}

Future<List<String>> getLocalitiesForPolice(
    String qPhoneNumber, BuildContext context) async {
  List<String> localitiesForPolice;
  await FirebaseFirestore.instance
      .collection('policeDB')
      .where('phoneNumber', isEqualTo: '+918009345450')
      .get()
      .then((policeProfileSnapshot) {
    if (policeProfileSnapshot.docs.length == 0)
      showErrorDialog(context, 'This profile doesnt exist!');
    else
      localitiesForPolice =
          List.castFrom(policeProfileSnapshot.docs.first.data()['localities']);
  });
  return localitiesForPolice;
}

Future<List<UserProfile>> getUsersToVerifyFromListOfLocalities(
    List<String> listOfLocalitiesAssigned, BuildContext context) async {
  List<UserProfile> listOfUserToVerify = [];
  if (listOfLocalitiesAssigned == null || listOfLocalitiesAssigned.length == 0)
    showErrorDialog(context, 'You are not assigned any locality');
  await FirebaseFirestore.instance
      .collection('users')
      .where('locality', whereIn: listOfLocalitiesAssigned)
      .where('isProfileVerified', isEqualTo: false)
      .where('hasPosted', isEqualTo: true)
      .get()
      .then((QuerySnapshot querySnapshot) {
    print('in getUsersToVerify() ${querySnapshot.docs.length}');
    querySnapshot.docs.forEach((userProfileToVerify) {
      UserProfile profileToAddToList = UserProfile(
        userID: userProfileToVerify.data()['userID'],
        name: userProfileToVerify.data()['name'],
        isAdmin: userProfileToVerify.data()['isAdmin'],
        proPicUrl: userProfileToVerify.data()['proPicUrl'],
        phoneNumber: userProfileToVerify.data()['phoneNumber'],
        locality: userProfileToVerify.data()['locality'],
        district: userProfileToVerify.data()['district'],
        policeStation: userProfileToVerify.data()['policeStation'],
        whatsappNumber: userProfileToVerify.data()['whatsappNumber'],
        emailId: userProfileToVerify.data()['emailID'],
        isProfileVerified: userProfileToVerify.data()['isProfileVerified'],
        posts: List.castFrom(userProfileToVerify.data()['posts']),
      );
      listOfUserToVerify.add(profileToAddToList);
    });
  });
  print(listOfUserToVerify);
  return listOfUserToVerify;
}

getUsersToVerify(BuildContext context, String qPhoneNumber) async {
  listOfUnverifiedUsers = await getLocalitiesForPolice(qPhoneNumber, context)
      .then((listOfLocs) =>
          getUsersToVerifyFromListOfLocalities(listOfLocs, context));
}
