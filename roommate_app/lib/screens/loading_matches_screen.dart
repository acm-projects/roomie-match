import "package:flutter/material.dart";
import 'package:roommate_app/match_searcher.dart';
import "../constants.dart";
import "package:roommate_app/user_info.dart";

class LoadingMatchesScreen extends StatelessWidget {
  LoadingMatchesScreen() {
    //Create placeName, a variable that holds a string that will hold a search string for finding the user's location
    String placeName = UserInformation.city + " " + UserInformation.state;

    //Create an instance of MatchSearcher, find matches, and store them as a list of profiles
    ///MatchSearcher matchSearcher = MatchSearcher(placeName,  UserInformation.state, UserInformation.radius, UserInformation.preferredGender);
    ///matchSearcher.findMatches().then((matches) {
      //TODO: nagivate to matches screen
      ///print("MATCHES: " + matches.toString());
    ///});
  }

  @override
  Widget build(BuildContext context) {
    //Implement match searching feature
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
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(kPRIMARY_COLOR),
            ),
            Padding(
              padding: EdgeInsets.all(20.0)
            ),
            const Text(
              "Loading Matches...",
              style: TextStyle(
                color: kPRIMARY_COLOR,
                fontSize: 20.0,
                fontFamily: "Avenir"
              ),
            ),
          ],
        )
      )
    );
  }
}