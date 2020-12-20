import 'package:demand_supply/data.dart';
import 'package:demand_supply/firebase/firebaseData.dart';
import 'package:demand_supply/screens/dialogs.dart';
import 'package:demand_supply/screens/home/drawer.dart';
import 'package:demand_supply/screens/newpost.dart';
import 'package:demand_supply/screens/postsByCategoryPage.dart';
import 'package:demand_supply/screens/search/searchPage.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      showLoading(context, true);
      print('should have displayed by now');
      retrieveUserProfileFromFirebase(currentUserID)
          .then((_) => showLoading(context, false));

      // arsProgressDialog.dismiss();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DEMAND & SUPPLY"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchPage()));
            },
          )
        ],
      ),
      drawer: DrawerHomePage(),
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
                color: Colors.grey[500],
                child: Center(
                  child: Text(
                    'SOMETHING IMPORTANT',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        color: Colors.white),
                  ),
                ),
              )),
          SizedBox(
            height: 5,
          ),
          //social causes heading
          // Text(
          //   "Find a cause to support",
          //   textAlign: TextAlign.start,
          // ),
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
                mainAxisSpacing: 24,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 26),
                children: [
                  InkWell(
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PostsByCategory(qCategory: 'Daily Needs')),
                      )
                    },
                    child: category(
                      "asset/icon/iconliving.png",
                      Colors.greenAccent,
                      "Daily Needs",
                    ),
                  ),
                  InkWell(
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PostsByCategory(qCategory: 'Medicine')),
                      )
                    },
                    child: category("asset/icon/iconlivingmeds.png",
                        Colors.greenAccent, "Medicine"),
                  ),
                  InkWell(
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PostsByCategory(qCategory: 'Counseling')),
                      )
                    },
                    child: category("asset/icon/iconlivingcounsel.png",
                        Colors.greenAccent, "Counseling"),
                  ),
                  InkWell(
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PostsByCategory(qCategory: 'Buy/Sell')),
                      )
                    },
                    child: category("asset/icon/iconlivingbuysell.png",
                        Colors.greenAccent, "Buy/Sell"),
                  ),
                  InkWell(
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PostsByCategory(qCategory: 'Travel')),
                      )
                    },
                    child: category("asset/icon/iconlivingtravel.png",
                        Colors.greenAccent, "Travel"),
                  ),
                  InkWell(
                      onTap: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PostsByCategory(qCategory: 'Other')),
                            )
                          },
                      child: category("asset/icon/iconlivingother.png",
                          Colors.greenAccent, "Other")),
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
          ),
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: FloatingActionButton(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {
                  // showModalBottomSheet<void>(
                  //     isScrollControlled: true,
                  //     context: context,
                  //     builder: (BuildContext context) {
                  //       return NewPost();
                  //     });
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NewPost()));
                },
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}

Material category(String cicon, MaterialAccentColor ccolor, String ctext) {
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
              Tab(
                icon: Image.asset(
                  cicon,
                  width: 50.0,
                  height: 50.0,
                ),
              ),
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
        width: MediaQuery.of(context).size.height * 0.24,
        color: Colors.blue[200],
        child: Center(
            child: Text(
          'POSTER ${(index + 1).toString()}',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              color: Colors.grey[700]),
        )),
      ),
    ),
    back: Card(
      color: Colors.blueGrey,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.13,
        width: MediaQuery.of(context).size.height * 0.24,
        color: Colors.blue[400],
        child: Center(
            child: Text(
          'DETAILS ${(index + 1).toString()}',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              color: Colors.white),
        )),
      ),
    ),
  );
}
