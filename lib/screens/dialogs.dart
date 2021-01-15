import 'package:ars_progress_dialog/dialog.dart';
import 'package:demand_supply/screens/home/homePage.dart';
import 'package:flutter/material.dart';

showErrorDialog(BuildContext context, String errorMsg) {
  showDialog(
    context: (context),
    builder: (context) => AlertDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      content: Text(errorMsg),
      title: Text('Uh..Oh!'),
      actions: [
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text('OK'),
        ),
      ],
    ),
  );
}

showCompletedDialog(BuildContext context, String msg) {
  showDialog(
    context: (context),
    builder: (context) => AlertDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      title: Text('Yay!'),
      content: Row(
        children: [
          Icon(
            Icons.check,
            color: Colors.green,
          ),
          Text(msg),
        ],
      ),
      actions: [
        FlatButton(
          onPressed: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (BuildContext context) => HomePage()),
              (Route<dynamic> route) => route is HomePage),
          child: Text('PROCEED'),
        ),
      ],
    ),
  );
}

showLoading(BuildContext context, bool state) {
  ArsProgressDialog arsProgressDialog = ArsProgressDialog(
    context,
    blur: 1,
    dismissable: true,
    backgroundColor: Colors.grey.withOpacity(0.4),
    animationDuration: Duration(milliseconds: 500),
  );
  print('loadingState: $state');
  state ? arsProgressDialog.show() : Navigator.pop(context);
}
