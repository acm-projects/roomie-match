//This screen lets users log in to their existing account
import 'package:flutter/material.dart';
import 'signup.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatelessWidget {
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
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            //X button
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.close),
            iconSize: 35,
            color: Colors.black,
          ),
        ),
      body: Column(
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
                String email = emailTextController.text;
                String password = passwordTextController.text;

                //Check to make sure neither the email or password fields are blank
                if (email.length == 0 || password.length == 0) {
                  _showLoginAlertDialog(context, "Neither the email or password fields can be left blank");
                  return;
                }

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
                  print("UID: ${user.uid}");

                  //Gather the user's info from firestore

                  //Navigate to the home screen
                }).catchError((_) {
                  _showLoginAlertDialog(context, "Invalid email or password");
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
    );
  }
}


