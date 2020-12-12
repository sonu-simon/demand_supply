import 'package:flutter/cupertino.dart';
import 'package:demand_supply/firebase/firebaseData.dart';

class UserProfile {
  String userID;
  String name;
  String proPicUrl;
  String phoneNumber;
  String locality;
  String whatsappNumber;
  String emailId;
  List<String> posts;

  UserProfile({
    @required this.userID,
    @required this.name,
    @required this.proPicUrl,
    @required this.phoneNumber,
    @required this.locality,
    this.whatsappNumber,
    this.emailId,
  });

  updateUserProfile(UserProfile userProfile, BuildContext context) {
    userID = userProfile.userID;
    name = userProfile.name;
    proPicUrl = userProfile.proPicUrl;
    phoneNumber = userProfile.phoneNumber;
    locality = userProfile.locality;
    whatsappNumber = userProfile.whatsappNumber;
    emailId = userProfile.emailId;

    updateUserInFirebase(userProfile, context);
  }
}

UserProfile demoUser = UserProfile(
    userID: 'lLqaFarvzPeQRg1HIzGIwb5vqxg1',
    name: 'userName',
    phoneNumber: '+91' + '9061254110',
    whatsappNumber: '+91' + '9061254110',
    proPicUrl: 'https://www.linkedin.com/feed/',
    locality: 'Dufai');
