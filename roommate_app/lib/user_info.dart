/*
This class holds all of the information of the current user; 
used so that there is easy access to the user's info anwhere in the project.
*/
abstract class UserInformation {
  static String uid;                    //The UID as used for Firebase/Firestore entry relations
  static List<String> matches = List(); //UID's of people that the user has matched with
  static List<String> badges = List();  //The badges that the user has selected; stored as the names of the icons internally
  static String firstName;              //The user's first name
  static String lastName;               //The user's last name
  static String gender;                 //The user's gender
  static int age;                       //The user's age
  static String aboutMe;                //The user's bio description

  static String preferredGender;        //The preferred gender of the user
  static int preferredAgeLower;         //The lower bound of the user's preferred age range
  static int preferredAgeUpper;         //The upper bound of the user's preferred age range

  static String city;                   //The city that the user lives in
  static String state;                  //The state that the user lives in
  static int radius;                    //The radius that the user wants to search in
}