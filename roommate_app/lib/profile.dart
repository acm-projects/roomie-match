/*
This class will be used to hold a user's profile information. For example, when a match is found,
their user data is pulled from Firebase and stored in a Profile object
*/
import "location.dart";
import "budget.dart";
import "temperature_range.dart";

class Profile {
  String gender;
  int age;
  int dailyHoursSpentInApartment;
  List<String> hobbies;
  List<String> allergies;
  TemperatureRange idealTempuratureRange;
  Budget budget;
  List<String> dealBreakers;
  bool doesWantPets;

  //TODO: create class constructor after filling in missing members
}
