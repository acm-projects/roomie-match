import "package:flutter/material.dart";

//LogInScreen contains all of the UI and functionality for the main landing page that requires users to log in
class LogInScreen extends StatelessWidget {
  static const Color _FOREGROUND_WIDGET_COLOR = Colors.white;     //The color for foreground widgets such as TextField
  static const Color _BACKGROUND_COLOR = Colors.deepPurple;       //The color of the scaffold background
  static const double _WIDGET_PADDING = 7.0;                      //The padding size between foreground widgets
  static const double _HEADER_FONT_SIZE = 40;                     //The size of the font for the main log in screen header
  static const double _TEXT_FIELD_BORDER_SIZE = 15.0;             //The size of the textfield's rounded border

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _BACKGROUND_COLOR,
      body: Center(
        //The main widget that will contain all of the child widgets that make up this screen
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //Main text heading for the log in screen
            const Text(
              "Log In",
              style: TextStyle(
                color: _FOREGROUND_WIDGET_COLOR,
                fontSize: _HEADER_FONT_SIZE,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(_WIDGET_PADDING),
            ),
            //Username entry field
            TextField(
              autocorrect: true,
              decoration: InputDecoration(
                fillColor: _FOREGROUND_WIDGET_COLOR,
                filled: true,
                hintText: "Username",
                //OutlineInputBorder allows for the creation of rounded borders
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(_TEXT_FIELD_BORDER_SIZE),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(_WIDGET_PADDING),
            ),
            //Password entry field
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                fillColor: _FOREGROUND_WIDGET_COLOR,
                filled: true,
                hintText: "Password",
                //OutlineInputBorder allows for the creation of rounded borders
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(_TEXT_FIELD_BORDER_SIZE),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(_WIDGET_PADDING),
            ),
            //The main button that initiates the user authorization process
            RaisedButton(
              child: Text("Go"),
              color: _FOREGROUND_WIDGET_COLOR,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
