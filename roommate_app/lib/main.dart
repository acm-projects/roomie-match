import "package:flutter/material.dart";
import 'package:roommate_app/screens/addbadges.dart';
import 'package:roommate_app/screens/login.dart';

void main() {
  runApp(RoommateApp());
}

class RoommateApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //This disables the debug banner that shows in the corner when running in debug mode on androids
      title: "Roomie Match",
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: Colors.deepPurpleAccent,
      ),
      home:
          AddBadgesScreen()//The main landing page will be the log in page; if already logged in, the user will be directed to the dashboard
    );
  }
}
