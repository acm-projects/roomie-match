String uid;             //The UID as used for Firebase/Firestore entry relations
List<String> matches;   //UID's of people that the user has matched with
List<String> badges;    //The badges that the user has selected; stored as the names of the icons internally
String firstName;       //The user's first name
String lastName;        //The user's last name
String gender;          //The user's gender
int age;                //The user's age
String aboutMe;         //The user's bio description

String preferredGender; //The preferred gender of the user
int preferredAgeLower;  //The lower bound of the user's preferred age range
int preferredAgeUpper;  //The upper bound of the user's preferred age range

String city;            //The city that the user lives in
String state;           //The state that the user lives in
int radius;             //The radius that the user wants to search in