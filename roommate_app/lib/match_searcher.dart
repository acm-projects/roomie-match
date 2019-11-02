//This class is used to search for matches given a user's gender and location preferences
import 'dart:async';
import 'package:roommate_app/field_enforcer.dart';
import 'package:roommate_app/profile.dart';
import 'package:roommate_app/user_info.dart';
import "dart:math";
import "constants.dart";
import "package:geolocator/geolocator.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class MatchSearcher {
  //Creating a reference to the user info Firestore collection
  CollectionReference userDataCollection = Firestore.instance.collection(kUSER_INFO_COLLECTION_NAME);

  //This method returns a list of matched profiles
  Future<List<Profile>> findMatches() async {
    Position searchingUserCoordinates;        //The coordinates of the searching user
    Position possibleMatchCoordinates;        //The coordinates of a potential match

    String possibleMatchPreferredGender;      //The gender of a possible match
    int possibleMatchRadius;                  //The search radius of a possible match
    String possibleMatchPlaceName;            //The place name of a possible match
    int possibleMatchPreferredAgeUpper;       //The upper bound of a possible match's age preferences
    int possibleMatchPreferredAgeLower;       //The lower bound of a possible match's age preferences

    List<Profile> matches = List();           //A list containing profile objects of every match found

    double distance;                          //The calculated distance between the searching user and a possible match

    Query genderQuery;                        //A query that will be used to query the correct gender based on the user's preference
    
    String placeName;                         //A string used to poll the geocoder API

    placeName = UserInformation.city + UserInformation.state;

    //Wait for the coordinates of the searching user
    searchingUserCoordinates = await _getCoordinatesFromPlaceName(placeName);

    //Determine which gender to query for based on user preferences
    if (UserInformation.preferredGender != kGENDER_EITHER) {
      //If the searching user didn't ask to look for either gender, look for their selected preferred gender
      genderQuery = userDataCollection.where(kGENDER_DOCUMENT_NAME, isEqualTo: UserInformation.preferredGender);
    } else {
      //If the searching user picked either gender, then simply set gender query to the data collection reference;
      //this will act as not performing any query at all
      genderQuery = userDataCollection;
    }

    //Query the database for matches who live in the same state and within the right age range
    genderQuery
      .where("state", isEqualTo: UserInformation.state)
      .where("age", isGreaterThanOrEqualTo: UserInformation.preferredAgeLower)
      .where("age", isLessThanOrEqualTo: UserInformation.preferredAgeUpper)
      .getDocuments() //At this point, all documents are users that are in this.state and are of this.preferredGender and in the correct age range
      .then((QuerySnapshot querySnapshot) async {
        //Iterate through possible matches returned by query and determine if they are the appropriate distance
        for (DocumentSnapshot documentSnapshot in querySnapshot.documents) {
          //Creating a string to pass into the _getCoordinatesFromPlacename method to get the potential matche's coordinates
          possibleMatchPlaceName = documentSnapshot.data[kCITY_DOCUMENT_NAME] + " " + documentSnapshot.data[kSTATE_DOCUMENT_NAME];        

          //Wait for the coordinates of the possible match
          possibleMatchCoordinates = await _getCoordinatesFromPlaceName(possibleMatchPlaceName);  

          //Wait for the distance to be calculated
          distance = await _calculateDistance(searchingUserCoordinates, possibleMatchCoordinates);

          //Get the radius of the possible match
          possibleMatchRadius = documentSnapshot.data[kRADIUS_DOCUMENT_NAME];

          //Get the possible match's preferred gender
          possibleMatchPreferredGender = documentSnapshot.data[kPREFERRED_GENDER_DOCUMENT_NAME];

          //Get the age bound of the possible match
          possibleMatchPreferredAgeLower = documentSnapshot.data[kPREFERRED_AGE_LOWER_DOCUMENT_NAME];
          possibleMatchPreferredAgeUpper = documentSnapshot.data[kPREFERRED_AGE_UPPER_DOCUMENT_NAME];

          //If the possible match is within the searching user's radius and the possible match radius does not exceed the searching user radius and the gender is the same as the possible matche's preferred gender and the age is in the correct range...
          if (distance <= UserInformation.radius && distance <= possibleMatchRadius 
          && (UserInformation.gender == possibleMatchPreferredGender || possibleMatchPreferredGender == kGENDER_EITHER)
          && (UserInformation.age <= possibleMatchPreferredAgeUpper && UserInformation.age >= possibleMatchPreferredAgeLower)) {
              //...gather the match's info from Firestore...
              String matchUid = documentSnapshot.documentID;
              List<dynamic> matchBadges = documentSnapshot.data[kBADGES_DOCUMENT_NAME];
              String matchFirstName = documentSnapshot.data[kFIRST_NAME_DOCUMENT_NAME];
              String matchLastName = documentSnapshot.data[kLAST_NAME_DOCUMENT_NAME];
              String matchGender = documentSnapshot.data[kGENDER_DOCUMENT_NAME];
              int matchAge = documentSnapshot.data[kAGE_DOCUMENT_NAME];
              String matchAboutMe = documentSnapshot.data[kABOUT_ME_DOCUMENT_NAME];
              String matchPreferredGender = documentSnapshot.data[kPREFERRED_GENDER_DOCUMENT_NAME];

              //...and add a new profile object containing that data to the matches list
              matches.add(Profile(matchUid, matchBadges, matchFirstName, matchLastName, matchGender, matchAge, matchAboutMe, matchPreferredGender, distance));
          }
        }
      }).then((_) {
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