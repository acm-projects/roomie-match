import 'package:flutter/material.dart';

void main() => runApp(RoommateApp());

class RoommateApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Roomie Match",
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: LogInPage(),
    );
  }
}

//The main log in page
class LogInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(),
      body: Center(
        child: const Text("Log In"),
      ),
    );
  }
}
