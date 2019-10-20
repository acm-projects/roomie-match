import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Container(
              child: Text("Login",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),),
              alignment: Alignment.centerLeft,
            ),
          ),
          SizedBox(
            height: 25.0,
          ),
          SingleLineTextField("Email", Icons.email, false),
          SizedBox(
            height: 25.0,
          ),
          SingleLineTextField("Password", Icons.vpn_key, true),
          SizedBox(
            height: 10.0,
          ),
          FlatButton(
            onPressed: (){},
            child: Text("Forgot password?",
            style: TextStyle(
              color: Colors.deepPurpleAccent,
            )),
          ),
          SizedBox(
            height: 40.0,
          ),
          FlatButton(
            onPressed: (){},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 110.0, vertical: 20.0),
              child: Text("Login", style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              ),
            ),
            color: Colors.deepPurpleAccent,
            splashColor: null,
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("New user?"),
              FlatButton(
                padding: EdgeInsets.all(0.0),
                onPressed: (){},
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1.0),
                  child: Text("Sign up",
                      style: TextStyle(
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

class SingleLineTextField extends StatelessWidget {
  SingleLineTextField(this.label, this.icon, this.isPassword);

  final String label;
  final IconData icon;
  final bool isPassword;

  Widget customPrefixIcon(IconData iconData) {
    return Container(
      width: 0,
      alignment: Alignment(-0.99, 0.0),
      child: Column(
        children: <Widget>[
          Icon(
            iconData,
          ),
        ],
      ),
    );
  }

  bool obscure(bool isPassword) {
    if (isPassword) return true;
    else return false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: TextField(
              obscureText: obscure(isPassword),
              decoration: InputDecoration(
                hintText: label,
//                prefixIcon: customPrefixIcon(icon),
                prefixIcon: customPrefixIcon(icon),
            ),
          ),
          ),
        ],
      ),
    );
  }
}

