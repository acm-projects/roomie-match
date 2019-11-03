//This screen lets users log in to their existing account
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:roommate_app/constants.dart';
import 'package:roommate_app/field_enforcer.dart';
import 'package:roommate_app/screens/test.dart';
import 'package:roommate_app/user_info.dart';
import 'signup.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  FocusNode passwordFieldFocusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            //X button
            onPressed: (){
              //Exit the app when the x button is pressed
              exit(0);
            },
            icon: Icon(Icons.close),
            iconSize: 35,
            color: Colors.black,
          ),
        ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Container(
                  child: Text("Log in",
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
                //Email text field
                child: TextField(
                  controller: emailTextController,
                  //When the user enters their email, shift the focus to the password field
                  onSubmitted: (_) {
                    FocusScope.of(context).requestFocus(passwordFieldFocusNode);
                  },
                  decoration: InputDecoration(
                    hintText: "Email",
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                //Password text field
                child: TextField(
                  controller: passwordTextController,
                  focusNode: passwordFieldFocusNode,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: Icon(Icons.vpn_key),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              //Forgot password button
              FlatButton(
                onPressed: (){},
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Text("Forgot password?",
                style: TextStyle(
                  color: Colors.deepPurpleAccent,
                )),
              ),
              SizedBox(
                height: 40.0,
              ),
              Container(
                width: 280.0,
                height: 60.0,
                //Log in button
                child: FlatButton(
                  onPressed: () async {
                    //Validate the none of the fields have been left blank
                    if (!FieldEnforcer.enforceFullFields(context, [emailTextController, passwordTextController])) {
                      return;
                    }

                    String email = emailTextController.text;
                    String password = passwordTextController.text;

                    //Trim whitespace off of email string
                    email = email.trim();

                    //Try to log the user in 
                    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
                    await _firebaseAuth.signInWithEmailAndPassword(
                      email: email,
                      password: password
                    ).then((authResult) {
                      //Process the gotten user auth info
                      FirebaseUser user = authResult.user;

                      //Write the uid to the UserInformation class
                      UserInformation.uid = user.uid;

                      //Gather this user's data from Firestore
                      CollectionReference userDataCollection = Firestore.instance.collection(kUSER_INFO_COLLECTION_NAME);
                      
                      //Find this user's ID in Firestore
                      userDataCollection.document(user.uid).get()
                      .then((DocumentSnapshot documentSnapshot) {
                        //Assign all of this user's Firestore fields to the UserInformation class
                        //TODO: read profile image
                        UserInformation.matches = documentSnapshot.data[kMATCHES_DOCUMENT_NAME];
                        UserInformation.badges = documentSnapshot.data[kBADGES_DOCUMENT_NAME];
                        UserInformation.firstName = documentSnapshot.data[kFIRST_NAME_DOCUMENT_NAME];
                        UserInformation.lastName = documentSnapshot.data[kLAST_NAME_DOCUMENT_NAME];
                        UserInformation.gender = documentSnapshot.data[kGENDER_DOCUMENT_NAME];
                        UserInformation.age = documentSnapshot.data[kAGE_DOCUMENT_NAME];
                        UserInformation.aboutMe = documentSnapshot.data[kABOUT_ME_DOCUMENT_NAME];
                        UserInformation.preferredGender = documentSnapshot[kPREFERRED_GENDER_DOCUMENT_NAME];
                        UserInformation.preferredAgeLower = documentSnapshot[kPREFERRED_AGE_LOWER_DOCUMENT_NAME];
                        UserInformation.preferredAgeUpper = documentSnapshot[kPREFERRED_AGE_UPPER_DOCUMENT_NAME];
                        UserInformation.city = documentSnapshot.data[kCITY_DOCUMENT_NAME];
                        UserInformation.state = documentSnapshot.data[kSTATE_DOCUMENT_NAME];
                        UserInformation.radius = documentSnapshot.data[kRADIUS_DOCUMENT_NAME];
                      }).catchError((_) {
                        FieldEnforcer.showErrorDialog(context, "Could not connect to databse. Check your network connection and try again");
                      });

                      //Navigate to the matches screen
                      Navigator.push(
                        context,
                        //TEST ROUTING
                        MaterialPageRoute(builder: (context) => Test())
                      );
                    }).catchError((_) {
                      FieldEnforcer.showErrorDialog(context, "Invalid email or password");
                    });
                    
                  },
                  child: Text("Log in", style: TextStyle(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("New user?",
                    style: TextStyle(
                      fontSize: 16.0,
                    )),
                  SizedBox(
                    width: 70.0,
                    child: IconButton(
                      padding: EdgeInsets.all(0.0),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen())
                        );
                      },
                      icon: Text("Sign up",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16.0,
                            color: Colors.deepPurpleAccent,
                          ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          )
        )
      )
    );
  }
}


