//This screen lets users log in to their existing account
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:roommate_app/field_enforcer.dart';
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

                      //TODO: Gather the user's info from firestore

                      //Navigate to the home screen
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


