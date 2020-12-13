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

  String uUserID;
  String uName;
  String uProPicUrl;
  String uPhoneNumber;
  String uLocality;
  String uWhatsappNumber;
  String uEmailId;

  Post(
      {@required this.id,
      @required this.title,
      @required this.postDate,
      @required this.description,
      @required this.imageUrl,
      this.isVerified,
      this.userProfile,
      @required this.category,
      this.uUserID,
      this.uName,
      this.uProPicUrl,
      this.uPhoneNumber,
      this.uLocality,
      this.uWhatsappNumber,
      this.uEmailId}) {
    if (userProfile != null) {
      uUserID = userProfile.userID;
      uName = userProfile.name;
      uProPicUrl = userProfile.proPicUrl;
      uPhoneNumber = userProfile.phoneNumber;
      uLocality = userProfile.locality;
      uWhatsappNumber = userProfile.whatsappNumber;
      uEmailId = userProfile.emailId;
    }
  }
}

// Post demoPost = Post(
//     title: 'Title goes here',
//     postDate: DateTime.now().toString(),
//     description: 'The product description goes here...',
//     imageUrl:
//         'https://www.blibli.com/page/wp-content/uploads/Ulas-Puas-Banner-utama1.jpg',
//     userProfile: demoUser,
//     category: 'The NULL category');
