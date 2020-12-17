import 'package:demand_supply/models/userProfile.dart';

import 'models/post.dart';

String currentUserID;
List<Post> postsInDistrictFilterByCategory = [];
List<String> listOfLocalities = [];
List<String> listOfPoliceStaions = [];
List<String> listOfDistricts = [];
List<String> listofCategories = [
  "Daily Needs",
  "Medicine",
  "Counseling",
  "Buy/Sell",
  "Travel",
  "Other"
];

UserProfile myProfile;
