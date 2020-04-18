import 'package:flutter/material.dart';
import 'package:syexpedition/constants.dart';
import 'package:syexpedition/main_page.dart';

class ExpeditionApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: mainBlack,
      ),
      home: MainPage(),
    );
  }
}
