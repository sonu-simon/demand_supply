import 'package:flutter/material.dart';

class AdminPageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(
          child: Text(
            "Admin Priviledges",
            style: TextStyle(fontSize: 28),
          ),
        ),
      ),
    );
  }
}
