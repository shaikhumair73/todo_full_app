import 'package:flutter/material.dart';

class MyTextFeild extends StatelessWidget {
  String hintText;
  String content;
  TextEditingController controller;
  Icon myIcon;
  IconButton? suffIcon;
  final String? Function(String? value) validater;
  bool obscureText;

  MyTextFeild(
      {required this.hintText,
      required this.content,
      required this.controller,
      required this.myIcon,
      this.suffIcon,
      required this.validater,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      validator: validater,
      decoration: InputDecoration(
          prefixIcon: myIcon,
          suffixIcon: suffIcon,
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          label: Text(content),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
  }
}

class Secondtextfeild extends StatelessWidget {
  String hintText;
  String content;
  TextEditingController controller;
  //Icon myIcon;
  Icon? suffIcon;

  Secondtextfeild({
    required this.hintText,
    required this.content,
    required this.controller,
    this.suffIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          suffixIcon: suffIcon,
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          label: Text(content),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
  }
}
