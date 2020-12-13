import 'package:demand_supply/models/userProfile.dart';

import 'models/post.dart';

String currentUserID;
List<Post> postsInLocality = [];
List<String> listOfLocalities = [];
List<String> listofCategories = [
  "Daily Needs",
  "Medicine",
  "Counseling",
  "Buy/Sell",
  "Travel",
  "Other"
];

UserProfile currentUser;
