import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "dart:developer";

import 'package:roommate_app/screens/preferences.dart';

class SignupScreen extends StatelessWidget {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  void _showLoginAlertDialog(BuildContext context, String message) {
    Widget okButton = FlatButton(
      child: Text(
        "Ok",
        style: TextStyle(
          color: Colors.deepPurpleAccent
        )
      ),
      onPressed: () {
        Navigator.pop(context);
      }
    );

    AlertDialog loginAlertDialog = AlertDialog(
      title: Text("Error"),
      content: Text(message),
      actions: [okButton]
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return loginAlertDialog;
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0.0,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
          color: Colors.black,
        ),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Container(
                child: Text("Sign up",
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
                obscureText: false,
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
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                  prefixIcon: Icon(Icons.vpn_key),
                ),
              ),
            ),
            SizedBox(
              height: 100.0,
            ),
            Container(
              width: 280.0,
              height: 60.0,
              //Sign up button
              child: FlatButton(
                onPressed: () async {
                  String email = emailTextController.text;
                  String password = passwordTextController.text;

                  //Check to make sure neither the email or password fields are blank
                  if (email.isEmpty || password.isEmpty) {
                    log("EMPTY");
                    _showLoginAlertDialog(context, "Neither the email or password fields can be left blank");
                    return;
                  } 

                  //Trim whitespace off of email string
                  email = email.trim();

                  //Try to log the user in 
                  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
                  await _firebaseAuth.createUserWithEmailAndPassword(
                    email: email,
                    password: password
                  ).then((authResult) {
                    //Process the created user auth info
                    FirebaseUser user = authResult.user;

                    //Navigate to the preferences screen and pass the uid in a constructor
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PreferencesScreen(user.uid))
                    );
                  }).catchError((_) {
                    _showLoginAlertDialog(context, "That email is already in use. Please try another one");
                  });
                },
                child: Text("Sign up", style: TextStyle(
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
                Text("Already have an account?",
                  style: TextStyle(
                    fontSize: 16.0,
                  )),
                SizedBox(
                  width: 60.0,
                  child: IconButton(
                    padding: EdgeInsets.all(0.0),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: Text("Log in",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.deepPurpleAccent,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
    );
  }
}

