//This screen will present the user with a prompt to find matches and a button that starts the matching process
import "package:flutter/material.dart";
import "constants.dart";
import 'loading_matches_screen.dart';

class FindMatchesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBACKGROUND_COLOR,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kBACKGROUND_COLOR,
        title: const Text(
          "Find Matches",
          style: TextStyle(
            color: kPRIMARY_COLOR,
            fontSize: kAPP_BAR_TEXT_SIZE,
            fontFamily: "Avenir"
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
              Text("Ready to find some matches?\nLet's get started!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kPRIMARY_COLOR,
                  fontSize: 25.0,
                  fontFamily: "Avenir"
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0)
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoadingMatchesScreen()),
                  );
                },
                color: kPRIMARY_COLOR,
                child: const Text(
                  "Find Matches",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontFamily: "Avenir"
                  ),
                ),
              ),
          ],
        )
      )
    );
  }
}