import 'package:flutter/material.dart';

void showSnackbar(BuildContext context,String errMsg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Center(
      child: Text(
        errMsg,
      ),
    ),
    backgroundColor: Colors.black54,
    margin: EdgeInsets.all(20),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)),
    elevation: 0,
  ));
}
