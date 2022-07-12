import 'package:flutter/material.dart';

snackBar(String msg, BuildContext context) {
  if (msg.isNotEmpty) {
    final snackBar = SnackBar(
      content: Text(
        msg,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
