import 'package:flutter/material.dart';

customAppBar(
  BuildContext context, {
  String? text,
  bool showText = false,
}) {
  return AppBar(
    centerTitle: true,
    leading: IconButton(
      icon: const Icon(
        Icons.arrow_back_ios_new,
        color: Colors.black,
        size: 20,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: showText
        ? Text(
            text!,
            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
          )
        : null,
  );
}
