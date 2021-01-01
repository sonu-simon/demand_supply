import 'package:demand_supply/data.dart';
import 'package:demand_supply/firebase/firebasePoliceDB.dart';
import 'package:demand_supply/screens/profile/userprofilePage.dart';
import 'package:flutter/material.dart';

class ListUnverifiedUsers extends StatefulWidget {
  @override
  _ListUnverifiedUsersState createState() => _ListUnverifiedUsersState();
}

class _ListUnverifiedUsersState extends State<ListUnverifiedUsers> {
  @override
  void initState() {
    super.initState();
    listOfUnverifiedUsers = [];
    getUsersToVerify(context, myProfile.phoneNumber).then((_) {
      setState(() {
        print('usersFetch completed');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context)),
          ),
          title: Text('Unverified Users')),
      body: listOfUnverifiedUsers.isEmpty
          ? Center(
              child: Text('No results found'),
            )
          : ListView.separated(
              itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Material(
                      elevation: 3,
                      color: Colors.grey[100],
                      child: ListTile(
                        onTap: () {
                          // showLoading(context, true);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserProfilePage(
                                        listOfUnverifiedUsers[index],
                                        isToVerify: true,
                                      )));
                        },
                        title: Text(
                          listOfUnverifiedUsers[index].name,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
              separatorBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Divider(
                    color: Colors.grey,
                  ),
                );
              },
              itemCount: listOfUnverifiedUsers.length),
    );
  }
}
