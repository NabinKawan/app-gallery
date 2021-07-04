import 'dart:math';

import 'package:art_manager/config/size_config.dart';
import 'package:art_manager/database/db_operation.dart';
import 'package:art_manager/models/art.dart';
import 'package:art_manager/models/art_operation.dart';
import 'package:art_manager/screens/addArts/add_arts_screen.dart';
import 'package:art_manager/screens/details/details_screen.dart';

import 'package:art_manager/themes.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future _future;
  List<Art> arts = [];
  DbOperation _dbOp = ArtOperation();

  final List<Color> colors = [
    Colors.yellow[700],
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.purple,
    Colors.indigo
  ];
  @override
  void initState() {
    super.initState();
    _future = _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Art Gallery",
              style: TextStyle(
                  fontFamily: kfontFamily,
                  letterSpacing: 1,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16 / 3.6 * SizeConfig.textMultiplier)),
          centerTitle: true,
          backgroundColor: kprimaryColor,
          elevation: 0.0,
        ),
        floatingActionButton: Container(
          height: 55 / 3.6 * SizeConfig.imageSizeMultiplier,
          width: 55 / 3.6 * SizeConfig.imageSizeMultiplier,
          child: FloatingActionButton(
            backgroundColor: kprimaryColor,
            onPressed: () {
              Future saved = Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddArtsScreen()));
              saved.then((value) {
                if (value != null) {
                  setState(() {
                    arts.insert(0, value);
                  });
                }
              });
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 22 / 3.6 * SizeConfig.imageSizeMultiplier,
            ),
          ),
        ),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
          child: FutureBuilder(
            future: _getData(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (arts.isNotEmpty) {
                  return ListView.builder(
                      itemCount: arts.length,
                      itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _buildCard(arts[index].name, index),
                          ));
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.hourglass_empty,
                          color: Colors.black87,
                          size: 20 / 3.6 * SizeConfig.textMultiplier,
                        ),
                        SizedBox(
                          height: 5 / 3.6 * SizeConfig.textMultiplier,
                        ),
                        Text(
                          "No Saved Arts to show....",
                          style: TextStyle(
                              fontFamily: kfontFamily,
                              fontSize: 12 / 3.6 * SizeConfig.textMultiplier,
                              letterSpacing: 0.5),
                        )
                      ],
                    ),
                  );
                }
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(kprimaryColor)),
                    ],
                  ),
                );
              }
            },
          ),
        ));
  }

  InkWell _buildCard(String name, int index) {
    Color color = colors[new Random().nextInt(6)];
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsScreen(
                      art: arts[index],
                    )));
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3),
            )
          ],
        ),
        child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 18, horizontal: 5.86 * 3.75),
            child: Container(
              child: Text(name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      letterSpacing: 0.5,
                      fontFamily: "OpenSans",
                      fontWeight: FontWeight.bold,
                      fontSize: 4.8 * SizeConfig.textMultiplier,
                      color: Colors.white)),
            )),
      ),
    );
  }

  Future _getData() async {
    arts = await _dbOp.getAll();
    print(arts);
  }
}
