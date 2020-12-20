import 'package:flutter/cupertino.dart';
import 'package:demand_supply/firebase/firebaseData.dart';

class UserProfile {
  String userID;
  String name;
  String proPicUrl;
  String phoneNumber;
  String locality;
  String district;
  String policeStation;
  String whatsappNumber;
  String emailId;
  List<String> posts;
  bool isAdmin;

  UserProfile(
      {@required this.userID,
      @required this.name,
      @required this.proPicUrl,
      @required this.phoneNumber,
      @required this.locality,
      @required this.district,
      @required this.policeStation,
      @required this.isAdmin,
      this.whatsappNumber,
      this.emailId,
      this.posts});

  updateUserProfile(UserProfile userProfile, BuildContext context) {
    userID = userProfile.userID;
    name = userProfile.name;
    proPicUrl = userProfile.proPicUrl;
    phoneNumber = userProfile.phoneNumber;
    locality = userProfile.locality;
    district = userProfile.district;
    policeStation = userProfile.policeStation;
    whatsappNumber = userProfile.whatsappNumber;
    emailId = userProfile.emailId;

    updateUserInFirebase(userProfile);
  }
}

UserProfile demoUser = UserProfile(
  userID: 'lLqaFarvzPeQRg1HIzGIwb5vqxg1',
  name: 'userName',
  isAdmin: true,
  phoneNumber: '+91' + '9061254110',
  whatsappNumber: '+91' + '9061254110',
  proPicUrl: 'https://www.linkedin.com/feed/',
  locality: 'Dufai',
  district: 'DSV',
  policeStation: 'NDZ',
);
