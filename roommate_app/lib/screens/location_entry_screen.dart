import 'package:flutter/material.dart';
import 'package:roommate_app/field_enforcer.dart';
import 'package:roommate_app/screens/preferences.dart';
import 'addbadges.dart';

class LocationEntryScreen extends StatefulWidget {
  @override
  _LocationEntryScreenState createState() => _LocationEntryScreenState();
}

class _LocationEntryScreenState extends State<LocationEntryScreen> {
  TextEditingController locationTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        //Back button -- goes to badges screen
        leading: IconButton(
          onPressed: (){
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => AddBadgesScreen())
            );
          },
          icon: Icon(Icons.chevron_left,
              color: Colors.deepPurpleAccent
            ),
          iconSize: 40.0,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(40.0, 5.0, 0, 5.0),
            child: Container(
              child: Text("Select Location",
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  ),
                ),
              alignment: Alignment.centerLeft,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            //Location entry text field
            child: TextField(
              controller: locationTextController,
              maxLines: 1,
              obscureText: false,
              decoration: InputDecoration(
                hintMaxLines: 2,
                prefixIcon: Icon(
                  Icons.location_on,
                  size: 40
                  ),
                hintText: "Enter city, state",
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            //Next button
            padding: const EdgeInsets.fromLTRB(0, 150.0, 0, 50.0),
            child: Container(
              width: 280.0,
              height: 60.0,
              child: FlatButton(
                onPressed: () {
                  //Validate that the location text field is filled
                  if (!FieldEnforcer.enforceFullFields(context, [locationTextController])) {
                    return;
                  }

                  //Route to preferences screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PreferencesScreen())
                  );
                },
                child: Text("Next", style: TextStyle(
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
          ),
        ],
      ),
    );
  }
}
