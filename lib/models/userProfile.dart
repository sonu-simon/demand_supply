import 'package:demand_supply/models/post.dart';
import 'package:flutter/material.dart';

import 'package:demand_supply/firebase/firebaseDataProfiles.dart';

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

  List<dynamic> mapPosts;
  List<AdvancedSearchModel> posts;
  bool isProfileVerified;
  bool isAdmin;
  bool hasPosted;

  UserProfile(
      {@required this.userID,
      @required this.name,
      @required this.proPicUrl,
      @required this.phoneNumber,
      @required this.locality,
      @required this.district,
      @required this.policeStation,
      this.isAdmin = false,
      this.isProfileVerified = false,
      this.hasPosted = false,
      this.whatsappNumber,
      this.emailId,
      this.mapPosts,
      this.posts}) {
    if (mapPosts != null) {
      posts = [];
      mapPosts.forEach((element) {
        element.forEach((key, value) {
          AdvancedSearchModel searchResult = AdvancedSearchModel(key, value);
          posts.add(searchResult);
        });
      });
    }
  }

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

  addPosts(AdvancedSearchModel postToAdd) {
    posts.add(postToAdd);
    print('added to myProfile');
  }
}

UserProfile demoUser = UserProfile(
  userID: 'lLqaFarvzPeQRg1HIzGIwb5vqxg1',
  name: 'userName',
  isAdmin: true,
  isProfileVerified: false,
  phoneNumber: '+91' + '9061254110',
  whatsappNumber: '+91' + '9061254110',
  proPicUrl: 'https://www.linkedin.com/feed/',
  locality: 'Dufai',
  district: 'DSV',
  policeStation: 'NDZ',
);
