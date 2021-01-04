import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demand_supply/data.dart';
import 'package:demand_supply/models/post.dart';
import 'package:demand_supply/screens/dialogs.dart';
import 'package:flutter/cupertino.dart';

postToFirebase(Post post) {
  FirebaseFirestore.instance
      .collection('posts')
      .doc(post.uDistrict)
      .collection('posts')
      .doc(post.id)
      .set({
    'id': post.id,
    'title': post.title,
    'category': post.category,
    'description': post.description,
    'imageUrl': post.imageUrl,
    'isVerified': post.isVerified,
    'postDate': post.postDate,
    'postInPathCollection': post.postInPathCollection,
    'uEmailId': post.uEmailId,
    'uIsProfileVerified': post.uIsProfileVerified,
    'uUserID': post.uUserID,
    'uLocality': post.uLocality,
    'uDistrict': post.uDistrict,
    'uPoliceStation': post.uPoliceStation,
    'uName': post.uName,
    'uPhoneNumber': post.uPhoneNumber,
    'uProPicUrl': post.uProPicUrl,
    'uWhatsappNumber': post.uWhatsappNumber,
  });

  FirebaseFirestore.instance
      .collection('allPostTitlesById')
      .doc('postID - title')
      .update({post.title: post.postInPathCollection}).then(
          (value) => print('postTitlesById is set'));

  FirebaseFirestore.instance.collection('users').doc(post.uUserID).update({
    'hasPosted': true,
    'posts': FieldValue.arrayUnion([
      {post.title: post.postInPathCollection}
    ])
  });
}

Future editPostInFirebase(Post post) async {
  await FirebaseFirestore.instance
      .collection('posts')
      .doc(post.uDistrict)
      .collection('posts')
      .doc(post.id)
      .update({
    'id': post.id,
    'title': post.title,
    'category': post.category,
    'description': post.description,
    'imageUrl': post.imageUrl,
    'isVerified': post.isVerified,
    'postDate': post.postDate,
    'postInPathCollection': post.postInPathCollection,
    'uEmailId': post.uEmailId,
    'uIsProfileVerified': post.uIsProfileVerified,
    'uUserID': post.uUserID,
    'uLocality': post.uLocality,
    'uDistrict': post.uDistrict,
    'uPoliceStation': post.uPoliceStation,
    'uName': post.uName,
    'uPhoneNumber': post.uPhoneNumber,
    'uProPicUrl': post.uProPicUrl,
    'uWhatsappNumber': post.uWhatsappNumber,
  });
}

Future retrievePostsFromFirebaseByDistrictFilterByCategory(
    {String uDistrict, String category}) async {
  postsInDistrictFilterByCategory = [];
  await FirebaseFirestore.instance
      .collection('posts')
      .doc(uDistrict)
      .collection('posts')
      .where('category', isEqualTo: category)
      .orderBy('postDate')
      .get()
      .then((QuerySnapshot querySnapshot) {
    print(
        'entered .then() retrievePostsFromFirebaseByLocalityFilterByCategory()');
    querySnapshot.docs.forEach((post) {
      Post postToAddList = Post(
        id: post.data()['id'],
        title: post.data()['title'],
        postDate: post.data()['postDate'],
        category: post.data()['category'],
        description: post.data()['description'],
        imageUrl: post.data()['imageUrl'],
        isVerified: post.data()['isVerified'],
        uIsProfileVerified: post.data()['uIsProfileVerified'],
        uName: post.data()['uName'],
        uPhoneNumber: post.data()['uPhoneNumber'],
        uWhatsappNumber: post.data()['uWhatsappNumber'],
        uProPicUrl: post.data()['uProPicUrl'],
        uLocality: post.data()['uLocation'],
        uDistrict: post.data()['uDistrict'],
        uPoliceStation: post.data()['uPoliceStation'],
        uEmailId: post.data()['uEmailId'],
        uUserID: post.data()['uUserID'],
      );

      postsInDistrictFilterByCategory.add(postToAddList);
    });
    return print(postsInDistrictFilterByCategory);
  });
}

Future advancedSearchForPostsByTitle(String qTitle) async {
  advancedSearchList = [];
  await FirebaseFirestore.instance
      .collection('allPostTitlesById')
      .doc('postID - title')
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    documentSnapshot.data().forEach((key, value) {
      if (key.toString().contains(qTitle)) {
        print('key: $key - value: $value');
        AdvancedSearchModel searchResult = AdvancedSearchModel(key, value);
        advancedSearchList.add(searchResult);
      }
    });
  });
}

Future<Post> postByPostPath(String postPath) async {
  Post postFromFirebase;
  print(postPath);
  print("\n\n");
  await FirebaseFirestore.instance.doc(postPath).get().then((post) {
    print(post.data()['title']);
    postFromFirebase = Post(
      id: post.data()['id'],
      title: post.data()['title'],
      postDate: post.data()['postDate'],
      category: post.data()['category'],
      description: post.data()['description'],
      imageUrl: post.data()['imageUrl'],
      isVerified: post.data()['isVerified'],
      postInPathCollection: post.data()['postInPathCollection'],
      uName: post.data()['uName'],
      uIsProfileVerified: post.data()['uIsProfileVerified'],
      uPhoneNumber: post.data()['uPhoneNumber'],
      uWhatsappNumber: post.data()['uWhatsappNumber'],
      uProPicUrl: post.data()['uProPicUrl'],
      uLocality: post.data()['uLocation'],
      uDistrict: post.data()['uDistrict'],
      uPoliceStation: post.data()['uPoliceStation'],
      uEmailId: post.data()['uEmailId'],
      uUserID: post.data()['uUserID'],
    );
  });
  print('retrieved: ${postFromFirebase.id}');
  return postFromFirebase;
}

Future searchForPostsByTitleInDistrict({String uDistrict, String title}) async {
  postsInDistrictFilterByTitle = [];
  await FirebaseFirestore.instance
      .collection('posts')
      .doc(uDistrict)
      .collection('posts')
      .get()
      .then((QuerySnapshot querySnapshot) {
    print('entered .then() searchForPostsByTitleInDistrict()');
    querySnapshot.docs.forEach((post) {
      print("this is: ${post.data()['title']}");
      Post postToAddList = Post(
        id: post.data()['id'],
        title: post.data()['title'],
        postDate: post.data()['postDate'],
        category: post.data()['category'],
        description: post.data()['description'],
        imageUrl: post.data()['imageUrl'],
        isVerified: post.data()['isVerified'],
        uName: post.data()['uName'],
        uIsProfileVerified: post.data()['uIsProfileVerified'],
        uPhoneNumber: post.data()['uPhoneNumber'],
        uWhatsappNumber: post.data()['uWhatsappNumber'],
        uProPicUrl: post.data()['uProPicUrl'],
        uLocality: post.data()['uLocation'],
        uDistrict: post.data()['uDistrict'],
        uPoliceStation: post.data()['uPoliceStation'],
        uEmailId: post.data()['uEmailId'],
        uUserID: post.data()['uUserID'],
      );
      if (postToAddList.title.contains(title))
        postsInDistrictFilterByTitle.add(postToAddList);
    });

    return print(postsInDistrictFilterByTitle);
  });
}

Future getPostsForHomepage(String uDistrict) async {
  await FirebaseFirestore.instance
      .collection('posts')
      .doc(uDistrict)
      .collection('posts')
      .where('uIsProfileVerified', isEqualTo: 'Verified')
      .orderBy('postDate')
      .limit(20)
      .get()
      .then((querySnapshot) {
    print('inside getPostsForHomePage()');
    querySnapshot.docs.forEach((post) {
      print("this is: ${post.data()['title']}");
      Post postToAddList = Post(
        id: post.data()['id'],
        title: post.data()['title'],
        postDate: post.data()['postDate'],
        category: post.data()['category'],
        description: post.data()['description'],
        imageUrl: post.data()['imageUrl'],
        isVerified: post.data()['isVerified'],
        uName: post.data()['uName'],
        uIsProfileVerified: post.data()['uIsProfileVerified'],
        uPhoneNumber: post.data()['uPhoneNumber'],
        uWhatsappNumber: post.data()['uWhatsappNumber'],
        uProPicUrl: post.data()['uProPicUrl'],
        uLocality: post.data()['uLocation'],
        uDistrict: post.data()['uDistrict'],
        uPoliceStation: post.data()['uPoliceStation'],
        uEmailId: post.data()['uEmailId'],
        uUserID: post.data()['uUserID'],
      );
      postsForHomePage.add(postToAddList);
    });
  });
  return print(postsForHomePage);
}

// Future retrievePostsByVillageNotVerified(
//     {String uDistrict, String uLocality}) async {
//   notVerifiedPostsForAdminByLocality = [];
//   await FirebaseFirestore.instance
//       .collection('posts')
//       .doc(uDistrict)
//       .collection('posts')
//       .where('uLocality', isEqualTo: uLocality)
//       .where('isVerified', isEqualTo: false)
//       .get()
//       .then((QuerySnapshot querySnapshot) {
//     print('entered .then() retrievePostsByVillageNotVerified()');
//     querySnapshot.docs.forEach((post) {
//       Post postToAddList = Post(
//         id: post.data()['id'],
//         title: post.data()['title'],
//         postDate: post.data()['postDate'],
//         category: post.data()['category'],
//         postInPathCollection: post.data()['postInPathCollection'],
//         description: post.data()['description'],
//         imageUrl: post.data()['imageUrl'],
//         isVerified: post.data()['isVerified'],
//         uName: post.data()['uName'],
//         uPhoneNumber: post.data()['uPhoneNumber'],
//         uWhatsappNumber: post.data()['uWhatsappNumber'],
//         uProPicUrl: post.data()['uProPicUrl'],
//         uLocality: post.data()['uLocation'],
//         uDistrict: post.data()['uDistrict'],
//         uPoliceStation: post.data()['uPoliceStation'],
//         uEmailId: post.data()['uEmailId'],
//         uUserID: post.data()['uUserID'],
//       );

//       notVerifiedPostsForAdminByLocality.add(postToAddList);
//     });
//     return print(notVerifiedPostsForAdminByLocality);
//   });
// }

// Future verifyPostByAdmin(String postPath, BuildContext context) async {
//   print(postPath);
//   showLoading(context, true);
//   await FirebaseFirestore.instance
//       .doc(postPath)
//       .update({'isVerified': true}).then((_) {
//     showLoading(context, false);
//     Navigator.pop(context);
//   });
// }
