//This class is used to search for matches given a user's gender and location preferences

import 'package:roommate_app/profile.dart';
import "dart:math";
import "constants.dart";
import "package:geocoder/geocoder.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class MatchSearcher {
  String placeName;       //The name of the location that the searching user lives in
  String state;           //The state that the searching user is searching in
  int radius;             //The radius (in miles) that a user wants to search for matches in
  String preferredGender; //The preferred gender of the searching user

  MatchSearcher(this.placeName, this.state, this.radius, this.preferredGender);

  //Creating a reference to the user info Firestore collection
  CollectionReference userDataCollection = Firestore.instance.collection(kUSER_INFO_COLLECTION_NAME);

  //This method returns a list of matched profiles
  List<Profile> getMatches() {
    Coordinates searchingUserCoordinates; //The coordinates of the searching user
    Coordinates possibleMatchCoordinates; //The coordinates of a potential match

    //Asynchronously obtain the searching user's coordinates
    Future<Coordinates> searchingUserCoordinatesFuture = _getCoordinatesFromPlaceName(this.placeName);
    searchingUserCoordinatesFuture.then((Coordinates coordinates) {
      searchingUserCoordinates = coordinates;
    });

    //Query the database for matches who live in the same state and match the searching user's perferred gender
    userDataCollection
      .where("state", isEqualTo: this.state)
      .where("gender", isEqualTo: this.preferredGender)
      .getDocuments() //At this point, all documents are users that are in this.state and are of this.preferredGender
      .then((QuerySnapshot querySnapshot) {
        //Iterate through possible matches returned by query and determine if they are the appropriate distance
        for (DocumentSnapshot documentSnapshot in querySnapshot.documents) {
          //Creating a string to pass into the _getCoordinatesFromPlacename method to get the potential matche's coordinates
          String possibleMatchPlaceName = documentSnapshot.data["state"] + " " + documentSnapshot.data["city"];        
        
          //Asynchronously obtain the possible matches's coordinates
          Future<Coordinates> possibleMatchCoordinatesFuture = _getCoordinatesFromPlaceName(possibleMatchPlaceName);
          possibleMatchCoordinatesFuture.then((Coordinates coordinates) {
            possibleMatchCoordinates = coordinates;
          });

          //Calculate the distance between the searching user and possible match user
          double distance = _calculateDistance(searchingUserCoordinates, possibleMatchCoordinates); 
          
        }
      });
  }

  //This method gets the exact coordinates of a place's location
  Future<Coordinates> _getCoordinatesFromPlaceName(String placeName) async {
    List<Address> addresses = await Geocoder.local.findAddressesFromQuery(placeName);

    Address firstAddress = addresses.first;
    
    return firstAddress.coordinates;
  }

  //Converts the given double in degrees to radians and returns the result
  double _degreesToRadians(double degrees) => degrees * pi / 180.0; //Pi constant is from dart:math library

  //An implementation of the haversine formula
  double _haversine(double theta) => pow(sin(theta / 2.0), 2);

  //Calculates the distance between two coordinates using the Haversine formula
  double _calculateDistance(Coordinates coordinates1, Coordinates coordinates2) {
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