import 'package:demand_supply/screens/profilePage.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'loginPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: MediaQuery.of(context).size.height * 0.06,
        title: Text("DEMAND&SUPPLY"),
        centerTitle: true,
        actions: [Icon(Icons.people)],
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      //grids and ol
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          //notification from police
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.18,
              color: Colors.green,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          //social causes heading
          Text(
            "Find a cause to support",
            textAlign: TextAlign.start,
          ),
          //socialcauses banner
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
                height: MediaQuery.of(context).size.height * 0.15,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 6,
                    itemBuilder: (BuildContext context, int index) {
                      return flipcard(context, index);
                    })),
          ),
          //categories
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              // color: Colors.red,
              height: MediaQuery.of(context).size.height * 0.28,
              child: StaggeredGridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 22,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 26),
                children: [
                  category(Icons.ac_unit_outlined, Colors.greenAccent,
                      "Daily Needs", LoginScreen()),
                  category(Icons.ac_unit_outlined, Colors.greenAccent,
                      "Medicine", LoginScreen()),
                  category(Icons.ac_unit_outlined, Colors.greenAccent,
                      "Counseling", LoginScreen()),
                  category(Icons.ac_unit_outlined, Colors.greenAccent,
                      "Buy/Sell", LoginScreen()),
                  category(Icons.ac_unit_outlined, Colors.greenAccent, "Travel",
                      LoginScreen()),
                  category(Icons.ac_unit_outlined, Colors.greenAccent, "Other",
                      LoginScreen())
                ],
                staggeredTiles: [
                  StaggeredTile.extent(1, 100),
                  StaggeredTile.extent(1, 100),
                  StaggeredTile.extent(1, 100),
                  StaggeredTile.extent(1, 100),
                  StaggeredTile.extent(1, 100),
                  StaggeredTile.extent(1, 100)
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.blue,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: MediaQuery.of(context).size.height * 0.061,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [],
          ),
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: FloatingActionButton(
            child: Icon(
              Icons.arrow_upward,
              color: Colors.white,
            ),
            onPressed: () {
              showModalBottomSheet<void>(
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return ProfilePage();
                    // Container(
                    //     child: Padding(
                    //         padding: const EdgeInsets.all(32.0),
                    //         child: Text(
                    //             'This is the modal bottom sheet. Tap anywhere to dismiss.',
                    //             textAlign: TextAlign.center,
                    //             style: TextStyle(
                    //                 color: Theme.of(context).accentColor,
                    //                 fontSize: 24.0))));
                  });
            },
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}

Material category(
    IconData cicon, MaterialAccentColor ccolor, String ctext, Widget contap) {
  return Material(
    color: Colors.white,
    elevation: 10,
    shadowColor: Color(0x802196F3),
    borderRadius: BorderRadius.circular(24),
    child: GestureDetector(
      onTap: () {
        print(ctext);
      },
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //icon
                    Icon(cicon),
                    //text
                    Text(ctext),
                  ])
            ],
          ),
        ),
      ),
    ),
  );
}

Widget flipcard(BuildContext context, int index) {
  return FlipCard(
    front: Card(
      color: Colors.blueGrey,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.13,
        width: MediaQuery.of(context).size.height * 0.2,
        color: Colors.blueGrey,
        child: Text(index.toString()),
      ),
    ),
    back: Card(
      color: Colors.grey,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.13,
        width: MediaQuery.of(context).size.height * 0.2,
        color: Colors.grey,
        child: Text("back"),
      ),
    ),
  );
}
