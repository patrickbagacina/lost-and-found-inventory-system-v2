import 'package:flutter/material.dart';

void showLoader(BuildContext ctx, [String msg = "Loading..."]) {
  AlertDialog alert = AlertDialog(
    content: Row(
      children: [
        const CircularProgressIndicator(),
        Container(margin: const EdgeInsets.only(left: 7), child: Text(msg)),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: ctx,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void hideLoader(BuildContext ctx) {
  Navigator.pop(ctx);
}
