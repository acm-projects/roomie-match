import "package:flutter/material.dart";
import 'package:roommate_app/loading_matches_screen.dart';
import "package:roommate_app/match_searcher.dart";
import 'package:roommate_app/screens/aboutme.dart';
import "log_in_screen.dart";
import "find_matches_screen.dart";
import "constants.dart";
import "screens/login.dart";
import 'screens/signup.dart';

//Test import
import "package:cloud_firestore/cloud_firestore.dart"; 

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
          FindMatchesScreen(), //The main landing page will be the log in page; if already logged in, the user will be directed to the dashboard
    );
  }
}
