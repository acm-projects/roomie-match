import "package:flutter/material.dart";
import "log_in_screen.dart";

void main() => runApp(RoommateApp());

class RoommateApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //This disables the debug banner that shows in the corner when running in debug mode on androids
      title: "Roomie Match",
      theme: ThemeData(
        primaryColor: Colors.deepPurpleAccent,
      ),
      home:
          LogInPage(), //The main landing page will be the log in page; if already logged in, the user will be directed to the dashboard
    );
  }
}
