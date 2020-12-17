import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class PostintePage extends StatefulWidget {
  @override
  _PostintePageState createState() => _PostintePageState();
}

class _PostintePageState extends State<PostintePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GridView.count(
      crossAxisCount: 2,
      children: List.generate(100, (index) {
        return Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.45,
            child: FlipCard(
              front: Card(
                color: Colors.red,
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.22,
                          width: MediaQuery.of(context).size.height * 0.24,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        child: Text("Name"),
                      )
                    ],
                  ),
                ),
              ),
              back: Card(
                color: Colors.grey,
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.22,
                          width: MediaQuery.of(context).size.height * 0.24,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        child: Text("Name"),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    ));
  }
}
