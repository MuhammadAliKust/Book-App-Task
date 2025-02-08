import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../configs/frontend.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField({
    super.key,
    required this.controller,
    this.icon = "",
    required this.text,
    this.hintColor,
    this.onSubmitted,
    required this.onTap,
    this.maxLines = 1,
    this.isPasswordField = false,
    this.isSecure = false,
    required this.keyBoardType,
  });

  String icon;
  final String text;
  final TextInputType keyBoardType;
  TextEditingController? controller;
  Color? hintColor;
  int maxLines;
  bool isPasswordField;
  bool isSecure;
  VoidCallback onTap;
  Function(String)? onSubmitted;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyBoardType,
      maxLines: widget.maxLines,
      controller: widget.controller,
      obscureText: widget.isSecure,
      onFieldSubmitted: (val)=>widget.onSubmitted!(val),
      decoration: InputDecoration(
          hintText: widget.text,
          hintStyle: TextStyle(
              color: widget.hintColor ?? FrontendConfigs.kAuthTextColor,
              fontSize: 14,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w400),
          border: OutlineInputBorder(
              borderRadius: FrontendConfigs.kAppBorder,
              borderSide: BorderSide.none),
          fillColor: FrontendConfigs.kTextFieldColor,
          filled: true,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(18.0),
            child: SvgPicture.asset(
              widget.icon!,
              color: Colors.grey,
            ),
          ),
          suffixIcon: widget.isPasswordField
              ? Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          widget.isSecure = !widget.isSecure;
                        });
                        return widget.onTap();
                      },
                      child: widget.isSecure
                          ? const Icon(Icons.remove_red_eye_outlined,
                              color: Colors.grey, size: 23)
                          : const Icon(
                              Icons.visibility_off_outlined,
                              color: Colors.grey,
                              size: 23,
                            )),
                )
              : null),
    );
  }
}
