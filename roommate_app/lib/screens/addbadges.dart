import 'package:flutter/material.dart';
import 'package:roommate_app/screens/preferences.dart';
import 'aboutme.dart';
import 'preferences.dart';

class AddBadgesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => AboutMeScreen()
            ));
          },
          icon: Icon(Icons.chevron_left,
              color: Colors.deepPurpleAccent),
            iconSize: 40.0,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            child: Text("Go to preferences"),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => PreferencesScreen()
              ));
            }
          )
        ],
      ),
    );
  }
}
