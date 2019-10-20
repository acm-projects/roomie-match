import "package:flutter/material.dart";
import "package:roommate_app/match_searcher.dart";
import 'package:roommate_app/screens/aboutme.dart';
import "log_in_screen.dart";
import "screens/login.dart";
import 'screens/signup.dart';

//Test import
import "package:cloud_firestore/cloud_firestore.dart"; 

void main() {
  runApp(RoommateApp());

  //Create Firestore instance
  final databaseReference = Firestore.instance;

  //Access the collection...
  databaseReference
    .collection("user-info")
    .where("name", isEqualTo: "Joe Smith") //Query fields...
    .where("gender", isEqualTo: "male") //You can have multiple queries!
    .getDocuments()
    .then((QuerySnapshot snapshot) { //get a query snapshot
      for (var l in snapshot.documents) { //snapshot.documents returns a List<DocumentSnapshot>
        print(l.data["name"]); //.data contains a Map<String, dynamic> of the current collection's data
      }
    });
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
          AboutMeScreen(), //The main landing page will be the log in page; if already logged in, the user will be directed to the dashboard
    );
  }
}
