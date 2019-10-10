//This class is used to search for matches given a user's gender and location preferences

import "gender.dart";
import "dart:math";
import "constants.dart";
import "package:geocoder/geocoder.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class MatchSearcher {
  String placeName;       //The name of the city that the searching user lives in
  int radius;             //The radius (in miles) that a user wants to search for matches in
  Gender preferredGender; //The preferred gender of the searching user

  MatchSearcher(this.placeName, this.radius, this.preferredGender);

  Future<Coordinates> getCoordinatesFromPlaceName() async {
    List<Address> addresses = await Geocoder.local.findAddressesFromQuery(this.placeName);

    Address firstAddress = addresses.first;
    
    return firstAddress.coordinates;
  }

  //Converts the given double in degrees to radians and returns the result
  double degreesToRadians(double degrees) => degrees * pi / 180.0; //Pi constant is from dart:math library

  //An implementation of the haversine formula
  double haversine(double theta) => pow(sin(theta / 2.0), 2);

  //Calculates the distance between two coordinates using the Haversine formula
  double calculateDistance(Coordinates coordinates1, Coordinates coordinates2) {
    const double _kEARTH_RADIUS_IN_MILES = 3963.2;

    //Converting the first coordinate's members to radians
    double latitude1InRadians = degreesToRadians(coordinates1.latitude);
    double longitutde1InRadians = degreesToRadians(coordinates1.longitude);

    //Converting the second coodinate's members to radians
    double latitude2InRadians = degreesToRadians(coordinates2.latitude);
    double longitude2InRadians = degreesToRadians(coordinates2.longitude);

    //Finding the difference between the latitude and longitudes for use in the haversine distance calculation
    double latitudeDifference = latitude2InRadians - latitude1InRadians;
    double longitudeDifference = longitude2InRadians - longitutde1InRadians;

    //Returns the distance between the two points using the haversine formula
    return 2 * _kEARTH_RADIUS_IN_MILES * asin(sqrt(haversine(latitudeDifference) + cos(latitude1InRadians) * cos(latitude2InRadians) * haversine(longitudeDifference)));
  }
}