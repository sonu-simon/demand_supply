import 'package:cloud_firestore/cloud_firestore.dart';
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

Future getLocalitiesForPolice(String qPhoneNumber, BuildContext context) async {
  List<String> localitiesForPolice;
  await FirebaseFirestore.instance
      .collection('policeDB')
      .where('phoneNumber', isEqualTo: qPhoneNumber)
      .get()
      .then((policeProfileSnapshot) {
    if (policeProfileSnapshot.docs.length == 0)
      showErrorDialog(context, 'This profile doesnt exist!');
    else
      localitiesForPolice =
          policeProfileSnapshot.docs.first.data()['localities'];
  });
  return localitiesForPolice;
}

Future getUsersToVerify({List<String> listOfLocalitiesAssigned}) async {
  List<UserProfile> listOfUserToVerify = [];
  await FirebaseFirestore.instance
      .collection('users')
      .where('locality', whereIn: ['Agra', 'Basti'])
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
          );
          listOfUserToVerify.add(profileToAddToList);
        });
        return listOfUserToVerify;
      });
}
