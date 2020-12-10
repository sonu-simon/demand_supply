import 'package:demand_supply/models/post.dart';

class User {
  String userID;
  String name;
  String proPicUrl;
  String phoneNumber;
  String location;
  String whatsappNumber;
  String emailId;
  List<Post> posts;

  User({
    this.userID,
    this.name,
    this.proPicUrl,
    this.phoneNumber,
    this.location,
    this.whatsappNumber,
    this.emailId,
  });
}

List<User> users = [
  User(
      userID: 'userID',
      name: 'userName',
      phoneNumber: '+91' + '9061254110',
      whatsappNumber: '+91' + '9061254110',
      proPicUrl: 'https://www.linkedin.com/feed/',
      location: 'Dufai')
];
