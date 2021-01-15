import 'package:demand_supply/models/userProfile.dart';

import 'models/post.dart';

String currentUserID;
List<Post> postsInDistrictFilterByCategory = [];
List<String> listOfLocalities = [];
List<String> listOfPoliceStaions = [
  "PS Agra",
  "PS Aligarh",
  "PS Allahabad",
  "PS Ambedkar Nagar",
  "PS Amethi (Chatrapati Sahuji Mahraj Nagar)",
  "PS Amroha (J.P. Nagar)",
  "PS Auraiya",
  "PS Azamgarh",
  "PS Baghpat",
  "PS Bahraich",
  "PS Ballia",
  "PS Balrampur",
  "PS Banda",
  "PS Barabanki",
];
List<String> listOfDistricts = [
  "Agra",
  "Aligarh",
  "Allahabad",
  "Ambedkar Nagar",
  "Amethi (Chatrapati Sahuji Mahraj Nagar)",
  "Amroha (J.P. Nagar)",
  "Auraiya",
  "Azamgarh",
  "Baghpat",
  "Bahraich",
  "Ballia",
  "Balrampur",
  "Banda",
  "Barabanki",
  "Bareilly",
  "Basti",
  "Bhadohi",
  "Bijnor",
  "Budaun",
  "Bulandshahr",
  "Chandauli",
  "Chitrakoot",
  "Deoria",
  "Etah",
  "Etawah",
  "Faizabad",
  "Farrukhabad",
  "Fatehpur",
  "Firozabad",
  "Gautam Buddha Nagar",
  "Ghaziabad",
  "Ghazipur",
  "Gonda",
  "Gorakhpur",
  "Hamirpur",
  "Hapur (Panchsheel Nagar)",
  "Hardoi",
  "Hathras",
  "Jalaun",
  "Jaunpur",
  "Jhansi",
  "Kannauj",
  "Kanpur Dehat",
  "Kanpur Nagar",
  "Kanshiram Nagar (Kasganj)",
  "Kaushambi",
  "Kushinagar (Padrauna)",
  "Lakhimpur - Kheri",
  "Lalitpur",
  "Lucknow",
  "Maharajganj",
  "Mahoba",
  "Mainpuri",
  "Mathura",
  "Mau",
  "Meerut",
  "Mirzapur",
  "Moradabad",
  "Muzaffarnagar",
  "Pilibhit",
  "Pratapgarh",
  "RaeBareli",
  "Rampur",
  "Saharanpur",
  "Sambhal (Bhim Nagar)",
  "Sant Kabir Nagar",
  "Shahjahanpur",
  "Shamali (Prabuddh Nagar)",
  "Shravasti",
  "Siddharth Nagar",
  "Sitapur",
  "Sonbhadra",
  "Sultanpur",
  "Unnao",
  "Varanasi",
];

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
