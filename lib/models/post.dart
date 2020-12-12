import 'dart:core';

import 'package:demand_supply/models/userProfile.dart';

class Post {
  String id;
  String title;
  DateTime postDate;
  String description;
  List<String> imageUrls;
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
      {this.id,
      this.title,
      this.postDate,
      this.description,
      this.imageUrls,
      this.isVerified,
      this.userProfile,
      this.category,
      this.uUserID,
      this.uName,
      this.uProPicUrl,
      this.uPhoneNumber,
      this.uLocality,
      this.uWhatsappNumber,
      this.uEmailId}) {
    uUserID = userProfile.userID;
    uName = userProfile.name;
    uProPicUrl = userProfile.proPicUrl;
    uPhoneNumber = userProfile.phoneNumber;
    uLocality = userProfile.locality;
    uWhatsappNumber = userProfile.whatsappNumber;
    uEmailId = userProfile.emailId;
  }
}

Post demoPost = Post(
    title: 'Title goes here',
    postDate: DateTime.now(),
    description: 'The product description goes here...',
    imageUrls: [
      'https://www.blibli.com/page/wp-content/uploads/Ulas-Puas-Banner-utama1.jpg',
      'https://www.blibli.com/friends/assets/banner2.jpg',
      'https://www.static-src.com/siva/asset//06_2017/microsite-banner--1200x460.jpg',
      'https://www.static-src.com/siva/asset//03_2017/brandedbabytoy-toy-header.jpg',
      'https://www.static-src.com/siva/asset//03_2017/brandedbabytoy-toy-header.jpg'
    ],
    userProfile: demoUser,
    category: 'The NULL category');
