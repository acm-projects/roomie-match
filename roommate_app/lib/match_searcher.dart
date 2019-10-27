//This class is used to search for matches given a user's gender and location preferences
import 'dart:async';
import 'package:roommate_app/profile.dart';
import "dart:math";
import "constants.dart";
import "package:geolocator/geolocator.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class MatchSearcher {
  String placeName;       //The name of the location that the searching user lives in; used for geocoding the user's coordinates
  String state;           //The state that the searching user is searching in
  int radius;             //The radius (in miles) that a user wants to search for matches in
  String preferredGender; //The preferred gender of the searching user

  MatchSearcher(this.placeName, this.state, this.radius, this.preferredGender);

  //Creating a reference to the user info Firestore collection
  CollectionReference userDataCollection = Firestore.instance.collection(kUSER_INFO_COLLECTION_NAME);

  //This method returns a list of matched profiles
  Future<List<Profile>> findMatches() async {
    Position searchingUserCoordinates;        //The coordinates of the searching user
    Position possibleMatchCoordinates;        //The coordinates of a potential match

    int possibleMatchRadius;                  //The search radius of a possible match

    List<Profile> matches = List();           //A list containing profile objects of every match found

    double distance;                          //The calculated distance between the searching user and a possible match

    //Query the database for matches who live in the same state and match the searching user's perferred gender
    userDataCollection
      .where("state", isEqualTo: this.state)
      .where("gender", isEqualTo: this.preferredGender)
      .getDocuments() //At this point, all documents are users that are in this.state and are of this.preferredGender
      .then((QuerySnapshot querySnapshot) async {
        //Iterate through possible matches returned by query and determine if they are the appropriate distance
        for (DocumentSnapshot documentSnapshot in querySnapshot.documents) {
          //Creating a string to pass into the _getCoordinatesFromPlacename method to get the potential matche's coordinates
          String possibleMatchPlaceName = documentSnapshot.data["state"] + " " + documentSnapshot.data["city"];        

          //Wait for the coordinates of the possible match
          possibleMatchCoordinates = await _getCoordinatesFromPlaceName(possibleMatchPlaceName);

          //Wait for the coordinates of the searching user
          searchingUserCoordinates = await _getCoordinatesFromPlaceName(this.placeName);

          //Wait for the distance to be calculated
          distance = await _calculateDistance(searchingUserCoordinates, possibleMatchCoordinates);

          //Get the radius of the possible match
          possibleMatchRadius = documentSnapshot.data["radius"];
          print("POSSIBLE MATCH RADIUS: $possibleMatchRadius");

          //If the possible match is within the searching user's radius and the possible match radius does not exceed the searching user radius...
          if (distance <= this.radius && distance <= possibleMatchRadius) {
              print("FOUNDMATCH");
              //...gather the match's info from Firestore...
              List<String> matchBadges = documentSnapshot.data["badges"];
              String matchFirstName = documentSnapshot.data["first-name"];
              String matchLastName = documentSnapshot.data["last-name"];
              String matchGender = documentSnapshot.data["gender"];
              int matchAge = documentSnapshot.data["age"];
              String matchAboutMe = documentSnapshot.data["about-me"];
              String matchPreferredGender = documentSnapshot.data["perferred-gender"];
              String matchCity = documentSnapshot.data["city"];
              String matchState = documentSnapshot.data["state"];


              //...and add a new profile object containing that data to the matches list
              matches.add(Profile(matchBadges, matchFirstName, matchLastName, matchGender, matchAge, matchAboutMe, matchPreferredGender, matchCity, matchState));
          }
        }
      }).then((dummyVar) {
        for (Profile match in matches) {
          print(match.firstName);
        }
      });
      return matches;
  }

  //This method gets the exact coordinates of a place's location
  Future<Position> _getCoordinatesFromPlaceName(String placeName) async {
    //Wait for the geolocator's geocoder functionality to get the position of the city based on the given place name
    List<Placemark> placemark = await Geolocator().placemarkFromAddress(placeName);
  
    //Return the coordinates (position) of the top result
    return placemark.first.position;
  }

  //Converts the given double in degrees to radians and returns the result
  double _degreesToRadians(double degrees) => degrees * pi / 180.0; //Pi constant is from dart:math library

  //An implementation of the haversine formula
  double _haversine(double theta) => pow(sin(theta / 2.0), 2);

  //Calculates the distance between two coordinates using the Haversine formula
  Future<double> _calculateDistance(Position coordinates1, Position coordinates2) async {
    const double _kEARTH_RADIUS_IN_MILES = 3963.2;

    //Converting the first coordinate's members to radians
    double latitude1InRadians = _degreesToRadians(coordinates1.latitude);
    double longitutde1InRadians = _degreesToRadians(coordinates1.longitude);

    //Converting the second coodinate's members to radians
    double latitude2InRadians = _degreesToRadians(coordinates2.latitude);
    double longitude2InRadians = _degreesToRadians(coordinates2.longitude);

    //Finding the difference between the latitude and longitudes for use in the haversine distance calculation
    double latitudeDifference = latitude2InRadians - latitude1InRadians;
    double longitudeDifference = longitude2InRadians - longitutde1InRadians;

    //Returns the distance between the two points using the haversine formula
    return 2 * _kEARTH_RADIUS_IN_MILES * asin(sqrt(_haversine(latitudeDifference) + cos(latitude1InRadians) * cos(latitude2InRadians) * _haversine(longitudeDifference)));
  }
}