import 'package:demand_supply/models/post.dart';

class UserProfile {
  String userID;
  String name;
  String proPicUrl;
  String phoneNumber;
  String location;
  String whatsappNumber;
  String emailId;
  List<Post> posts;

  UserProfile({
    this.userID,
    this.name,
    this.proPicUrl,
    this.phoneNumber,
    this.location,
    this.whatsappNumber,
    this.emailId,
  });
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
