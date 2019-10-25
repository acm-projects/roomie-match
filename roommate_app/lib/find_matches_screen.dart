//This screen will present the user with a prompt to find matches and a button that starts the matching process
import "package:flutter/material.dart";
import 'package:geolocator/geolocator.dart';
import 'package:roommate_app/profile.dart';
import "constants.dart";
import 'loading_matches_screen.dart';
import "package:roommate_app/match_searcher.dart";

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
                onPressed: () async {
                  //Dummy profile
                  Profile testProfile = Profile(
                    "John",
                    "Test",
                    "male",
                    35,
                    "male",
                    "Allen",
                    "Texas",
                    10
                  );
                  
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoadingMatchesScreen(testProfile.city, testProfile.state, testProfile.preferredGender, testProfile.radius)),
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