import 'dart:core';

import 'package:demand_supply/models/userProfile.dart';

class Post {
  String id;
  String title;
  DateTime postDate;
  String description;
  List<String> imageUrls;
  bool isVerified;
  User user;
  String category;

  String uUserID;
  String uName;
  String uProPicUrl;
  String uPhoneNumber;
  String uLocation;
  String uWhatsappNumber;
  String uEmailId;

  Post(
      {this.title,
      this.postDate,
      this.description,
      this.imageUrls,
      this.isVerified,
      this.user,
      this.category}) {
    uUserID = user.userID;
    uName = user.name;
    uProPicUrl = user.proPicUrl;
    uPhoneNumber = user.phoneNumber;
    uLocation = user.location;
    uWhatsappNumber = user.whatsappNumber;
    uEmailId = user.emailId;
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
    user: users[0],
    category: 'The NULL category');
