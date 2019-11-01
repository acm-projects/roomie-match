//This screen is the start of the user profile creation process
import 'package:flutter/material.dart';
import 'package:roommate_app/screens/aboutme.dart';
import 'package:roommate_app/screens/location_entry_screen.dart';
import 'signup.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileCreationScreen extends StatefulWidget {
  String _selectedGender = "Male";  //Holds the current gender selection; initialzed to the default gender

  @override
  _ProfileCreationScreenState createState() => _ProfileCreationScreenState();
}

class _ProfileCreationScreenState extends State<ProfileCreationScreen> {
  TextEditingController firstNameTextController = TextEditingController();
  TextEditingController lastNameTextController = TextEditingController();
  TextEditingController ageTextController = TextEditingController();

  String selectedGender = "Male"; //Will hold the selected gender; initialzed to the default selection
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
      body: Column(
        children: <Widget>[
          //Profile image selection button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
            child: FlatButton(
              onPressed: () {},
              child: Icon(
              Icons.person_add,
              color: Colors.black54,
              size: 60,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
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
                height: 5.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                //First name text field
                child: TextField(
                  controller: firstNameTextController,
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
                //Lastname text field
                child: TextField(
                  controller: lastNameTextController,
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
                      icon: Icon(Icons.arrow_drop_down),
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
                      items: <String>["Male", "Female", "Other"]
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AboutMeScreen())
                    );
                    //TODO: write user data to user_info.dart
                    //TODO: validate input -- make sure nothing is blank
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
            ],
          ),

    );
  }
}
