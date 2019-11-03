import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:roommate_app/field_enforcer.dart';
import 'package:roommate_app/screens/profile_creation_screen.dart';
import 'package:roommate_app/user_info.dart';
import 'login.dart';
import 'addbadges.dart';

class AboutMeScreen extends StatefulWidget {
  @override
  _AboutMeScreenState createState() => _AboutMeScreenState();
}

class _AboutMeScreenState extends State<AboutMeScreen> {
  TextEditingController aboutMeTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        //Back button
        leading: IconButton(
          onPressed: (){
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => ProfileCreationScreen()
            ));
          },
          icon: Icon(Icons.chevron_left,
            color: Colors.deepPurpleAccent),
            iconSize: 40.0,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(40.0, 5.0, 0, 5.0),
                child: Container(
                  child: Text("About me",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      ),
                    ),
                  alignment: Alignment.centerLeft,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: TextField(
                  controller: aboutMeTextController,
                  maxLines: 5,
                  maxLength: 150,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintMaxLines: 2,
                    hintText: "Share your interests, hobbies preferences, etc…",
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 12.0, 0, 50.0),
                child: Container(
                  width: 280.0,
                  height: 60.0,
                  child: FlatButton(
                    //Next button
                    onPressed: (){
                      //Validate that the bio field is filled
                      if (!FieldEnforcer.enforceFullFields(context, [aboutMeTextController])) {
                        return;
                      }

                      UserInformation.aboutMe = aboutMeTextController.text;

                      //Route to add badges screen
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => AddBadgesScreen())
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
              ),
            ],
          ),
        )
      )
    );
  }
}
