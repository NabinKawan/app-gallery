import 'dart:io';
import 'package:art_manager/config/size_config.dart';
import 'package:art_manager/models/art.dart';
import 'package:art_manager/themes.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final Art art;
  DetailsScreen({this.art});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbgColor,
      appBar: buildAppBar(context, "Details"),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            art.imagePath != null
                ? Container(
                    width: double.infinity,
                    height: 220 / 3.6 * SizeConfig.imageSizeMultiplier,
                    child: Image.file(
                      File(art.imagePath),
                      fit: BoxFit.cover,
                    ))
                : SizedBox(
                    height: 220 / 3.6 * SizeConfig.imageSizeMultiplier,
                  ),
            SizedBox(
              height: 15,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(art.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: kfontFamily,
                      fontSize: 20 / 3.6 * SizeConfig.textMultiplier,
                      color: Colors.black,
                    )),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                      art.description != null
                          ? art.description
                          : "Description not available",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.5)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
