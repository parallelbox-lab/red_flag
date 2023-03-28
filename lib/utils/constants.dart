import 'package:flutter/material.dart';
const kPrimaryColor = Color(0xffF5F5F5);
const kBlackColor = Color(0xFF000000);
const kSecondaryColor = Color(0xFFD9D9D9);
const kFormBackround = Color(0xFF21243D);
const borderColor = Color(0xffD3D2DA);

const kPadding = EdgeInsets.all(24);
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
final otpInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  contentPadding: EdgeInsets.zero,
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide:const BorderSide(color: borderColor),
  );
}