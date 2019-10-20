import 'package:flutter/material.dart';
import 'addbadges.dart';

class PreferencesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0.0,
        leading: IconButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddBadgesScreen()
            ));
          },
          icon: Icon(Icons.chevron_left,
              color: Colors.deepPurpleAccent),
          iconSize: 40.0,
        ),
      ),
      body: Column(
//        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(40.0, 5.0, 0, 5.0),
            child: Container(
              child: Text("Preferences",
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),),
              alignment: Alignment.centerLeft,
            ),
          ),
          Row(
            children: <Widget>[

            ],
          )
        ],
      ),
    );
  }
}
