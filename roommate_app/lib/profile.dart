/*
This class will be used to hold a user's profile information. For example, when a match is found,
their user data is pulled from Firebase and stored in a Profile object
*/
import "location.dart";
import "budget.dart";
import "temperature_range.dart";

class Profile {
  String firstName;
  String lastName;
  String gender;
  int age;

  String preferredGender;

  String city;
  String state;  
  int radius;

  Profile(firstName, lastName, gender, age, preferredGender, city, state, radius);
}
