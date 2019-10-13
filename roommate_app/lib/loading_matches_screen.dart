import "package:flutter/material.dart";
import 'package:roommate_app/match_searcher.dart';
import "constants.dart";
import "profile.dart";

class LoadingMatchesScreen extends StatelessWidget {
  final String searchingUserCity;             //The city of the searching user
  final String searchingUserState;            //The state of the searching user
  final String searchingUserPreferredGender;  //The preferred gender of the searching user
  final int searchingUserRadiusInMiles;       //The desired radius of matches of the searching user                

  LoadingMatchesScreen(this.searchingUserCity, this.searchingUserState, this.searchingUserPreferredGender, this.searchingUserRadiusInMiles) {
    //Create placeName, a variable that holds a string that will hold a search string for finding the user's location
    String placeName = this.searchingUserCity + " " + this.searchingUserState;

    //Create an instance of MatchSearcher, find matches, and store them as a list of profiles
    MatchSearcher matchSearcher = MatchSearcher(placeName,  this.searchingUserState, this.searchingUserRadiusInMiles, this.searchingUserPreferredGender);
    matchSearcher.findMatches().then((matches) {
      print("MATCHES: " + matches.toString());
    });

    
    //DEBUG: print found profiles
    //for (Profile profile in matches)
    //{
      //print(profile.firstName);
    //}
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