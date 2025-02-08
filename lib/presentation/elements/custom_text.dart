import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  CustomText(
      {Key? key,
      required this.text,
      this.color,
      this.maxLines = 1,
        this.textAlign,
      this.fontSize = 14,
      this.fontWeight = FontWeight.w500,
      this.letterSpacing})
      : super(key: key);
  String text;
  FontWeight fontWeight;
  double fontSize;
  Color? color = Colors.black;
  double? letterSpacing;
  TextAlign ?textAlign;
  int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign:textAlign,
      text,
      maxLines: maxLines,
      style: TextStyle(
          fontWeight: fontWeight,
          fontSize: fontSize,
          color: color,
          letterSpacing: letterSpacing),
    );
  }
}
