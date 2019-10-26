import "package:flutter/material.dart";
import 'package:roommate_app/screens/loading_matches_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 300,
                height: 70,
                //Go to matches button
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoadingMatchesScreen())
                    );
                  },
                  color: Colors.deepPurpleAccent,
                  child: Text(
                    "Go to matches",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30
                    )
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)
                  ),
                ),      
              ),
              Padding(
                padding: EdgeInsets.all(30),
              ),
              Container(
                width: 300,
                height: 70,
                //Find new matches button
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoadingMatchesScreen())
                    );
                  },
                  color: Colors.deepPurpleAccent,
                  child: Text(
                    "Find new matches",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30
                    )
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)
                  ),
                ),      
              ),
            ],
          )
        )
      )
    );
  }
}