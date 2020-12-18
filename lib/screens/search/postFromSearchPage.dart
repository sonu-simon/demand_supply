import 'package:demand_supply/firebase/firebaseData.dart';
import 'package:demand_supply/models/post.dart';
import 'package:demand_supply/screens/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class PostAdvSearchPage extends StatefulWidget {
  final String postPath;
  PostAdvSearchPage(this.postPath);

  @override
  _PostAdvSearchPageState createState() => _PostAdvSearchPageState();
}

class _PostAdvSearchPageState extends State<PostAdvSearchPage> {
  Post postToShow;
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      showLoading(context, true);
      postByPostPath(widget.postPath).then((post) {
        postToShow = post;
        showLoading(context, false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
