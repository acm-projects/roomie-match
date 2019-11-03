//This screen is the start of the user profile creation process
import 'package:flutter/material.dart';
import 'package:roommate_app/constants.dart';
import 'package:roommate_app/field_enforcer.dart';
import 'package:roommate_app/screens/aboutme.dart';
import '../user_info.dart';
import 'signup.dart';

class ProfileCreationScreen extends StatefulWidget {
  String _selectedGender = kGENDER_MALE;  //Holds the current gender selection; initialzed to the default gender

  @override
  _ProfileCreationScreenState createState() => _ProfileCreationScreenState();
}

class _ProfileCreationScreenState extends State<ProfileCreationScreen> {
  TextEditingController firstNameTextController = TextEditingController();
  TextEditingController lastNameTextController = TextEditingController();
  TextEditingController ageTextController = TextEditingController();

  FocusNode lastNameFieldFocusNode = new FocusNode();
  FocusNode ageFieldFocusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            //Back button -- goes to sign up page
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignupScreen())
              );
            },
            icon: Icon(Icons.chevron_left),
            iconSize: 40.0,
            color: Colors.deepPurpleAccent,
          ),
        ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //Profile image selection button
              FlatButton(
                onPressed: () {},
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 100),
                  child: Icon(
                  Icons.add_a_photo,
                  color: Colors.black54,
                  size: 100,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Container(
                  child: Text("Profile",
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),),
                  alignment: Alignment.centerLeft,
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                //First name text field
                child: TextField(
                  controller: firstNameTextController,
                  onSubmitted: (_) {
                    FocusScope.of(context).requestFocus(lastNameFieldFocusNode);
                  },
                  decoration: InputDecoration(
                    hintText: "First Name",
                  ),
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                //Last name text field
                child: TextField(
                  controller: lastNameTextController,
                  onSubmitted: (_) {
                    FocusScope.of(context).requestFocus(ageFieldFocusNode);
                  },
                  focusNode: lastNameFieldFocusNode,
                  decoration: InputDecoration(
                    hintText: "Last Name",
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(40, 25, 180, 25),
                      //Age numeric text field
                      child: TextField(
                      controller: ageTextController,
                      focusNode: ageFieldFocusNode,
                      maxLength: 2,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        hintText: "Age",
                        counterText: ""
                      ),
                    ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 14.77, 40, 0),
                      //Gender selection dropdown button
                      child: DropdownButton<String>(
                      value: widget._selectedGender,
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 30,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 17,
                        fontFamily: "Poppins"
                      ),
                      underline: Container(
                        height: 1.1,
                        color: Colors.grey
                      ),
                      onChanged: (String newSelection) => setState(() => widget._selectedGender = newSelection),
                      items: <String>[kGENDER_MALE, kGENDER_FEMALE]
                      .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value)
                        );
                      }).toList(),
                      ),
                    ),
                ],
              ),
              SizedBox(
                height: 50.0,
              ),
              Container(
                width: 280.0,
                height: 60.0,
                //Next button
                child: FlatButton(
                  onPressed: () {
                    //Validate that the first name, last name, and age fields are not empty (gender cannot be empty because it has a default value)
                    if (!FieldEnforcer.enforceFullFields(context, [firstNameTextController, lastNameTextController, ageTextController])) {
                      return;
                    }
                    
                    //Store the user's info in the UserInformation abstract class
                    UserInformation.firstName = firstNameTextController.text;
                    UserInformation.lastName = lastNameTextController.text;
                    UserInformation.gender = widget._selectedGender;
                    UserInformation.age = int.parse(ageTextController.text);

                    //Route to about me page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AboutMeScreen())
                    );
                  },
                  child: Text("Next", style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                  ),
                  color: Colors.deepPurpleAccent,
                  splashColor: null,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
