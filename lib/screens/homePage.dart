import 'package:demand_supply/screens/profilePage.dart';
import 'package:demand_supply/screens/recentPage.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DEMAND&SUPPLY"),
        centerTitle: true,
        actions: [Icon(Icons.people)],
      ),
      drawer: Drawer(
        child: ListView(
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
                  InkWell(
                    child: category(
                      Icons.ac_unit_outlined,
                      Colors.greenAccent,
                      "Daily Needs",
                    ),
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RecentPage()),
                      )
                    },
                  ),
                  InkWell(
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RecentPage()),
                      )
                    },
                    child: category(
                        Icons.ac_unit_outlined, Colors.greenAccent, "Medicine"),
                  ),
                  InkWell(
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RecentPage()),
                      )
                    },
                    child: category(Icons.ac_unit_outlined, Colors.greenAccent,
                        "Counseling"),
                  ),
                  InkWell(
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RecentPage()),
                      )
                    },
                    child: category(
                        Icons.ac_unit_outlined, Colors.greenAccent, "Buy/Sell"),
                  ),
                  InkWell(
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RecentPage()),
                      )
                    },
                    child: category(
                        Icons.ac_unit_outlined, Colors.greenAccent, "Travel"),
                  ),
                  InkWell(
                      onTap: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RecentPage()),
                            )
                          },
                      child: category(
                          Icons.ac_unit_outlined, Colors.greenAccent, "Other")),
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

Material category(IconData cicon, MaterialAccentColor ccolor, String ctext) {
  return Material(
    color: Colors.white,
    elevation: 10,
    shadowColor: Color(0x802196F3),
    borderRadius: BorderRadius.circular(24),
    child: Center(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              //icon
              Icon(cicon),
              //text
              Text(ctext),
            ])
          ],
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