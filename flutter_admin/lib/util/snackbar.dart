import 'package:flutter/material.dart';

void flash(BuildContext context, String msg) {
  SnackBar snackBar = SnackBar(
    dismissDirection: DismissDirection.up,
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.only(
      bottom: MediaQuery.of(context).size.height - 150,
      left: 10,
      right: 10,
    ),
    content: Text(msg),
    backgroundColor: Colors.indigo,
    duration: const Duration(seconds: 2),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
