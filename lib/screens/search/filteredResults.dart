import 'package:demand_supply/data.dart';
import 'package:demand_supply/screens/dialogs.dart';
import 'package:demand_supply/screens/post/newPost.dart';
import 'package:demand_supply/screens/productPage/productpage.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FilteredResultsPage extends StatefulWidget {
  @override
  _FilteredResultsPageState createState() => _FilteredResultsPageState();
}

class _FilteredResultsPageState extends State<FilteredResultsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Filtered Resutls"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => NewPost()));
          },
          splashColor: Colors.cyan,
          child: Icon(Icons.add),
        ),
        body: postsInAdvancedSearchFiltersApplied.isEmpty
            ? Center(
                child: Text("No posts available here !"),
              )
            : Padding(
                padding: const EdgeInsets.all(3.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  children: List.generate(
                      postsInAdvancedSearchFiltersApplied.length, (index) {
                    return Container(
                      child: InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductPage(
                                    postsInAdvancedSearchFiltersApplied[
                                        index]))),
                        child: FlipCard(
                          front: Stack(
                            children: [
                              Card(
                                color: Colors.grey[350],
                                child: Container(
                                  height: MediaQuery.of(context).size.height,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                              postsInAdvancedSearchFiltersApplied[
                                                      index]
                                                  .imageUrl))),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 16,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.white.withOpacity(0.75),
                                  child: Center(
                                    child: Text(
                                      postsInAdvancedSearchFiltersApplied[index]
                                          .title
                                          .toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.height /
                                                40,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          back: Card(
                            child: Container(
                              color: Colors.grey[200],
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      postsInAdvancedSearchFiltersApplied[index]
                                          .title
                                          .toUpperCase(),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              32),
                                    ),
                                    Text(
                                      postsInAdvancedSearchFiltersApplied[index]
                                          .description,
                                      maxLines: 3,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              35),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        IconButton(
                                            icon: Icon(Icons.message),
                                            onPressed: () async {
                                              if (postsInAdvancedSearchFiltersApplied[
                                                          index]
                                                      .uWhatsappNumber !=
                                                  null) {
                                                var whatsappUrl =
                                                    "whatsapp://send?phone=${postsInAdvancedSearchFiltersApplied[index].uWhatsappNumber}";
                                                await canLaunch(whatsappUrl)
                                                    ? launch(whatsappUrl)
                                                    : print(
                                                        "open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
                                              } else
                                                showErrorDialog(context,
                                                    'Whatsapp contact not available');
                                            }),
                                        IconButton(
                                            icon: Icon(
                                              Icons.call,
                                              color: Colors.green,
                                            ),
                                            onPressed: () {
                                              launch(
                                                  "tel://${postsInAdvancedSearchFiltersApplied[index].uPhoneNumber}");
                                            }),
                                        Icon(
                                          Icons.assignment_turned_in_outlined,
                                          color:
                                              (postsInAdvancedSearchFiltersApplied[
                                                              index]
                                                          .uIsProfileVerified ==
                                                      "Verified")
                                                  ? Colors.green
                                                  : Colors.red,
                                        ),
                                        IconButton(
                                            icon: Icon(
                                                Icons.open_in_new_outlined),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ProductPage(
                                                              postsInAdvancedSearchFiltersApplied[
                                                                  index])));
                                            })
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ));
  }
}
