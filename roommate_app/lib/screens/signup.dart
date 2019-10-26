import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
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
              child: TextField(
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
              child: TextField(
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
            FlatButton(
              onPressed: (){},
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Text("",
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
              child: FlatButton(
                onPressed: (){},
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

