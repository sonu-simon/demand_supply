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

List<AdvancedSearchModel> advancedSearchList = [];
List<Post> postsInAdvancedSearch = [];
List<Post> postsInAdvancedSearchFiltersApplied = [];
List<Post> postsInDistrictFilterByTitle = [];
List<Post> postsForHomePage = [];

bool myProfileIsAdmin;

List<Post> notVerifiedPostsForAdminByLocality = [];
List<UserProfile> listOfUnverifiedUsers;
