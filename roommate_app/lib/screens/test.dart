import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:roommate_app/match_searcher.dart';
import "package:roommate_app/profile.dart";
import "package:roommate_app/user_info.dart";

//The purpose of this file is to have a central location for all the tests that need to be done
class Test extends StatelessWidget {

  void _testGeoCoder(String location) {
    //Wait for the geolocator's geocoder functionality to get the position of the city based on the given place name
    Geolocator().placemarkFromAddress(location).then((placemark) {
      print("GEOCODER TEST");
      print("LAT : ${placemark.first.position.latitude}");
      print("LAT : ${placemark.first.position.longitude}");
    });
  
  }

  Future<void> _testMatchAlgorithm() async {
    MatchSearcher ms = MatchSearcher();
    await ms.findMatches().then((matches) {
      log(matches.toString());
      for (Profile match in matches) {
        print(match.firstName);
      }
    });
  }

  void testLoginDataWriting() {
    print("UID: ${UserInformation.uid}");
    print("Matches: ${UserInformation.matches}");
    print("Badges: ${UserInformation.badges}");
    print("First Name: ${UserInformation.firstName}");
    print("Last Name: ${UserInformation.lastName}");
    print("Gender: ${UserInformation.gender}");
    print("Age: ${UserInformation.age}");
    print("About me: ${UserInformation.aboutMe}");
    print("Preferred Gender: ${UserInformation.preferredGender}");
    print("Pref. Age Lower: ${UserInformation.preferredAgeLower}");
    print("Pref. Age Upper: ${UserInformation.preferredAgeUpper}");
    print("City: ${UserInformation.city}");
    print("State: ${UserInformation.state}");
    print("Radius: ${UserInformation.radius}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(60),
        child: FlatButton(
          child: Text("Test"),
            onPressed: () {
              testLoginDataWriting();
          }
        )
      )
    );


  }
}