//This screen lets user create a new account if they do not already have one
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:roommate_app/field_enforcer.dart';
import 'package:roommate_app/screens/login.dart';
import 'package:roommate_app/screens/profile_creation_screen.dart';
import 'package:roommate_app/user_info.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController reEnterPasswordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
              height: 25.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              //Confirm password text field
              child: TextField(
                controller: reEnterPasswordTextController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Re-enter Password",
                  prefixIcon: Icon(Icons.vpn_key),
                ),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Container(
              width: 280.0,
              height: 60.0,
              //Sign up button
              child: FlatButton(
                onPressed: () async {
                  //Validate that all fields are full
                  if (!FieldEnforcer.enforceFullFields(context, [emailTextController, passwordTextController, reEnterPasswordTextController])) {
                    return;
                  }

                  String email = emailTextController.text;
                  String password = passwordTextController.text;
                  String reEnteredPassword = passwordTextController.text;

                  if (password != reEnteredPassword) {
                    FieldEnforcer.showErrorDialog(context, "Passwords do not match!");
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

                    //Write the user's UID to the user info class
                    UserInformation.uid = user.uid;

                    //Route to profile creation screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileCreationScreen())
                    );
                  }).catchError((_) {
                    FieldEnforcer.showErrorDialog(context, "That email is already in use or is invalid. Please try another one");
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen())
                      );
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

