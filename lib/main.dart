import 'package:art_manager/database/init_database.dart';
import 'package:art_manager/screens/homscreen/homescreen.dart';
import 'package:art_manager/themes.dart';
import 'package:flutter/material.dart';
import 'package:art_manager/config/size_config.dart';

Future<void> main() async {
  // make sure that we have instance of Widget flutter binding which is used to interact with flutter engine
  WidgetsFlutterBinding.ensureInitialized();
  await InitDb.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kprimaryColor,
      ),
      home: LayoutBuilder(builder: (context, constraints) {
        return OrientationBuilder(builder: (context, orientation) {
          //getting the size details and orientation of the display
          SizeConfig().init(constraints, orientation);
          return HomeScreen();
        });
      }),
    );
  }
}
