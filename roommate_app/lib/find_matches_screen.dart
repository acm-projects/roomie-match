//This screen will present the user with a prompt to find matches and a button that starts the matching process
import "package:flutter/material.dart";
import 'package:geolocator/geolocator.dart';
import 'package:roommate_app/profile.dart';
import "constants.dart";
import 'loading_matches_screen.dart';
import "package:roommate_app/match_searcher.dart";

class FindMatchesScreen extends StatelessWidget {

  String testCity = "Allen";
  String testState = "Texas";
  String testPreferredGender = "male";
  int testRadius = 5;

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
                  ///Navigator.push(
                    //context,
                    //MaterialPageRoute(builder: (context) => LoadingMatchesScreen(testCity, testState, testPreferredGender, testRadius)),
                  ///);
                  
                  //Testing geolocator
                  //List<Placemark> placemark = await Geolocator().placemarkFromAddress("richardson texas");
                  //print(placemark.first.position.toString());

                  //Testing .findMatched() method
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
                  String testPlaceName = testProfile.city + testProfile.state;

                  MatchSearcher ms = MatchSearcher(testPlaceName, testProfile.state, testProfile.radius, testProfile.preferredGender);
                  
                  ms.findMatches().then((matches) => print("MATCHES $matches"));
                  
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