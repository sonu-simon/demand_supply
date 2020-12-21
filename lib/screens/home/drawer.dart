import 'package:demand_supply/data.dart';
import 'package:demand_supply/firebase/firebaseServices.dart';
import 'package:demand_supply/screens/admin/adminPage.dart';
import 'package:demand_supply/screens/profile/profilePage.dart';
import 'package:demand_supply/screens/search/searchPage.dart';
import 'package:flutter/material.dart';

class DrawerHomePage extends StatelessWidget {
  const DrawerHomePage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: DrawerHeader(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(myProfile.proPicUrl),
                      radius: MediaQuery.of(context).size.width * 0.13,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        myProfile.name,
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
            ),
          ),
          //Advanced Search
          ListTile(
            title: DrawerTitleText('Advanced Search'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AdvSearchPage()));
            },
          ),
          Divider(),
          //My Profile
          ListTile(
            title: DrawerTitleText('My Profile'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfilePage()));
            },
          ),
          Divider(),
          //Setings
          ListTile(
            title: DrawerTitleText('Settings'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          Divider(),

          Visibility(
            visible: myProfileIsAdmin,
            child: ListTile(
              title: DrawerTitleText('Admin'),
              onTap: () {
                //admin
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminPageScreen()),
                );
              },
            ),
          ),
          Divider(),
          //SignOut
          ListTile(
            title: DrawerTitleText('Sign out'),
            onTap: () {
              authSignOut(context);
              // Update the state of the app.
              // ...
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}

class DrawerTitleText extends StatelessWidget {
  final String titleText;
  DrawerTitleText(this.titleText);

  @override
  Widget build(BuildContext context) {
    return Text(
      titleText,
      style: TextStyle(fontSize: 18),
    );
  }
}
