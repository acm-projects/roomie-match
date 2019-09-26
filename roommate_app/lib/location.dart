//The Location class allows for the storage of location information in the roomate questionaire
class Location {
  String country;
  String state;
  String city;

  int maximumRadiusInMiles;

  String workplace;               //The current workplace that a user works at
  String educationalInstitution;  //The current place of education that a user is attending

  Location(this.country, this.state, this.city, this.maximumRadiusInMiles, this.workplace, this.educationalInstitution);
}
