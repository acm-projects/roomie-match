import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(60),
        child: FlatButton(
          child: Text("Test"),
            onPressed: () {
              _testGeoCoder("askldjffkas;lkdjf");
          }
        )
      )
    );


  }
}