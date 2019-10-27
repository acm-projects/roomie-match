/*
This class will be used to hold a user's profile information. For example, when a match is found,
their user data is pulled from Firebase and stored in a Profile object. The profile object does not
include all of the data that needs to be stored in Firestore, as things such as the UID do not need
to be dislayed to other users when there is a match or potential match.
*/

class Profile {
  List<String> badges;    //The badges that the user has selected; stored as the names of the icons internally
  String firstName;       //The user's first name
  String lastName;        //The user's last name
  String gender;          //The user's gender
  int age;                //The user's age
  String aboutMe;         //The user's bio description

  String preferredGender; //The preferred gender of the user

  String city;            //The city that the user lives in
  String state;           //The state that the user lives in

  Profile(this.badges, this.firstName, this.lastName, this.gender, this.age,  this.aboutMe, this.preferredGender, this.city, this.state);
}
