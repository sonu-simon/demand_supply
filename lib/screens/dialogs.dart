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
          child: Text('TRY AGAIN'),
        ),
      ],
    ),
  );
}
