//The Location class allows for the storage of location information in the roomate questionaire
class Location {
  String country;
  String state;
  String city;

  int maximumRadius;

  String workplace;             //The current workplace that a user works at
  String educationalInstituion; //The current place of education that a user is attending

  Location(this.country, this.state, this.city, this.maximumRadius, this.workplace, this.educationalInstitution);
}