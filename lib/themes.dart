import 'package:art_manager/config/size_config.dart';
import 'package:flutter/material.dart';

//change the themes of the app here

const kprimaryColor = Color(0xff1976d2);
const Color ktextColor = Colors.black;
const String kfontFamily = "OpenSans";
const String kfontFamilyBold = "OpenSansBold";
const Color kbgColor = Colors.white;

InputDecoration buildFormDecoration({String labelText, String hintText}) {
  return InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
    ),
    labelText: labelText,
    labelStyle: TextStyle(
      fontFamily: kfontFamily,
    ),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: kprimaryColor)),
    hintText: hintText,
    floatingLabelBehavior: FloatingLabelBehavior.always,
  );
}

TextStyle buildFormTextStyle() {
  return TextStyle(
      fontSize: 14,
      fontFamily: kfontFamily,
      color: ktextColor,
      fontWeight: FontWeight.w300,
      letterSpacing: 0.2);
}

AppBar buildAppBar(BuildContext context, String title) => AppBar(
        title: Text(title,
            style: TextStyle(
                fontFamily: kfontFamily,
                letterSpacing: 1,
                color: ktextColor,
                fontWeight: FontWeight.w500,
                fontSize: 16 / 3.6 * SizeConfig.textMultiplier)),
        centerTitle: true,
        backgroundColor: kbgColor,
        elevation: 0.0,
        actions: [
          IconButton(
              icon: Icon(
                Icons.close_rounded,
                size: 25 / 3.6 * SizeConfig.textMultiplier,
                color: Colors.blue.shade700,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          SizedBox(width: 15),
        ]);
