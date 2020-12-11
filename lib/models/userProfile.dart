import 'package:flutter/cupertino.dart';
import 'package:demand_supply/firebase/firebaseData.dart';

class UserProfile {
  String userID;
  String name;
  String proPicUrl;
  String phoneNumber;
  String location;
  String whatsappNumber;
  String emailId;
  List<String> posts;

  UserProfile({
    @required this.userID,
    @required this.name,
    @required this.proPicUrl,
    @required this.phoneNumber,
    @required this.location,
    this.whatsappNumber,
    this.emailId,
  });

  updateUserProfile(UserProfile userProfile, BuildContext context) {
    userID = userProfile.userID;
    name = userProfile.name;
    proPicUrl = userProfile.proPicUrl;
    phoneNumber = userProfile.phoneNumber;
    location = userProfile.location;
    whatsappNumber = userProfile.whatsappNumber;
    emailId = userProfile.emailId;

    updateUserInFirebase(userProfile, context);
  }
}

List<UserProfile> users = [
  UserProfile(
      userID: 'userID',
      name: 'userName',
      phoneNumber: '+91' + '9061254110',
      whatsappNumber: '+91' + '9061254110',
      proPicUrl: 'https://www.linkedin.com/feed/',
      location: 'Dufai')
];
