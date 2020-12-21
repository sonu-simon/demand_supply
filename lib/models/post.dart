import 'dart:core';

import 'package:demand_supply/models/userProfile.dart';
import 'package:flutter/cupertino.dart';

class Post {
  String id;
  String title;
  String postDate;
  String description;
  String imageUrl;
  bool isVerified;
  UserProfile userProfile;
  String category;
  String postInPathCollection;

  String uUserID;
  String uName;
  String uProPicUrl;
  String uPhoneNumber;
  String uLocality;
  String uDistrict;
  String uPoliceStation;
  String uWhatsappNumber;
  String uEmailId;

  Post(
      {this.id,
      @required this.title,
      this.postDate,
      @required this.description,
      @required this.imageUrl,
      this.isVerified,
      this.userProfile,
      @required this.category,
      this.postInPathCollection,
      this.uUserID,
      this.uName,
      this.uProPicUrl,
      this.uPhoneNumber,
      this.uLocality,
      this.uDistrict,
      this.uPoliceStation,
      this.uWhatsappNumber,
      this.uEmailId}) {
    postDate = DateTime.now().toString();
    if (userProfile != null) {
      uUserID = userProfile.userID;
      uName = userProfile.name;
      uProPicUrl = userProfile.proPicUrl;
      uPhoneNumber = userProfile.phoneNumber;
      uLocality = userProfile.locality;
      uDistrict = userProfile.district;
      uPoliceStation = userProfile.policeStation;
      uWhatsappNumber = userProfile.whatsappNumber;
      uEmailId = userProfile.emailId;
      postInPathCollection = 'posts/$uDistrict/posts/$id';
    }
  }
}

class AdvancedSearchModel {
  String postPath;
  String title;

  AdvancedSearchModel(this.title, this.postPath);
}
// Post demoPost = Post(
//     title: 'Title goes here',
//     postDate: DateTime.now().toString(),
//     description: 'The product description goes here...',
//     imageUrl:
//         'https://www.blibli.com/page/wp-content/uploads/Ulas-Puas-Banner-utama1.jpg',
//     userProfile: demoUser,
//     category: 'The NULL category');
