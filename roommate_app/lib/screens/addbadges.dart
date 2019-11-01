//This screen lets the user pick badges that will be displayed on their profile
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:roommate_app/screens/location_entry_screen.dart';
import 'package:roommate_app/screens/preferences.dart';
import 'aboutme.dart';
import 'preferences.dart';

abstract class BadgeSelectionInformation {
  static final int MAX_NUMBER_BADGES = 5; //The maximum number of badges that can be selected
  static List<String> badges = List();    //A list of file paths containing the selected bages
}

//Custom widget for selecting badges
class BadgeButton extends StatefulWidget {
  String _iconFilePath;

  BadgeButton(this._iconFilePath);

  @override
  _BadgeButtonState createState() => _BadgeButtonState();
}

//State class for BadgeButton
class _BadgeButtonState extends State<BadgeButton> {
  bool _isSelected = false;

  void _toggleSelection() {
    _isSelected = !_isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: FlatButton(
        shape: StadiumBorder(),
        onPressed: () => setState(() {
          print(BadgeSelectionInformation.badges.length);
          //If this badge isn't yet selected and the max number of badges hasn't been reached, then this badge will be selected
          if (BadgeSelectionInformation.badges.length < BadgeSelectionInformation.MAX_NUMBER_BADGES && !_isSelected) {
            _toggleSelection();
            BadgeSelectionInformation.badges.add(widget._iconFilePath);
          }
          //If the badge is selected, then toggle the selection and remove it from the list of selected badges
          else if (_isSelected) {
            _toggleSelection();
            BadgeSelectionInformation.badges.remove(widget._iconFilePath);
          }
        }),
        color: _isSelected ? Colors.deepPurpleAccent : Colors.transparent,
        child: Image.asset(widget._iconFilePath)
      ),
    );
  }
}

class AddBadgesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        //Back button -- goes to about me screen
        leading: IconButton(
          onPressed: (){
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => AboutMeScreen()
            ));
          },
          icon: Icon(Icons.chevron_left,
              color: Colors.deepPurpleAccent),
            iconSize: 40.0,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LocationEntryScreen())
          );
        },
          icon: Icon(Icons.arrow_forward),
        label: Text("Choose"),
        backgroundColor: Colors.deepPurpleAccent
      ),
      //Main list view for organizing widgets
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Text(
              "Add Badges",
                style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Sports/Activities",
                style: TextStyle(
                    fontSize: 15
                  )
                ),
            ),
          ),
          //Sports/activities badges
          GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              //Sports icons
              BadgeButton("assets/images/badges/sports/american-football.png"),
              BadgeButton("assets/images/badges/sports/archery.png"),
              BadgeButton("assets/images/badges/sports/baseball.png"),
              BadgeButton("assets/images/badges/sports/basketball-1.png"),
              BadgeButton("assets/images/badges/sports/boxing-1.png"),
              BadgeButton("assets/images/badges/sports/chess.png"),
              BadgeButton("assets/images/badges/sports/cricket.png"),
              BadgeButton("assets/images/badges/sports/curling.png"),
              BadgeButton("assets/images/badges/sports/eight-ball.png"),
              BadgeButton("assets/images/badges/sports/fishing.png"),
              BadgeButton("assets/images/badges/sports/golf-1.png"),
              BadgeButton("assets/images/badges/sports/hockey.png"),
              BadgeButton("assets/images/badges/sports/karate.png"),
              BadgeButton("assets/images/badges/sports/kayak.png"),
              BadgeButton("assets/images/badges/sports/lacrosse.png"),
              BadgeButton("assets/images/badges/sports/ping-pong-1.png"),
              BadgeButton("assets/images/badges/sports/rugby.png"),
              BadgeButton("assets/images/badges/sports/surf-1.png"),
              BadgeButton("assets/images/badges/sports/tennis-ball.png"),
              BadgeButton("assets/images/badges/sports/waterpolo.png"),
              BadgeButton("assets/images/badges/sports/weight-3.png"),
              BadgeButton("assets/images/badges/sports/yachting.png"),
              ],
            ), 
            Padding(
              padding: EdgeInsets.all(20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Religion",
                  style: TextStyle(
                    fontSize: 15
                  ),
                ),
              ),
            ),
          //Religion badges
          GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              //Religion icons
              BadgeButton("assets/images/badges/religion/angel.png"),
              BadgeButton("assets/images/badges/religion/bahai.png"),
              BadgeButton("assets/images/badges/religion/bible.png"),
              BadgeButton("assets/images/badges/religion/buddhism.png"),
              BadgeButton("assets/images/badges/religion/christianity.png"),
              BadgeButton("assets/images/badges/religion/ganesha.png"),
              BadgeButton("assets/images/badges/religion/hinduism.png"),
              BadgeButton("assets/images/badges/religion/islam.png"),
              BadgeButton("assets/images/badges/religion/jainism.png"),
              BadgeButton("assets/images/badges/religion/judaism.png"),
              BadgeButton("assets/images/badges/religion/paganism.png"),
              BadgeButton("assets/images/badges/religion/rosary.png"),
              BadgeButton("assets/images/badges/religion/shinto.png"),
              BadgeButton("assets/images/badges/religion/taoism.png"),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Lifestyle",
                  style: TextStyle(
                    fontSize: 15
                  ),
                ),
              ),
            ),
          //Lifestyle badges
          GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              //Lifestyle icons
              //TODO: replace with hobbies badges
              BadgeButton("assets/images/badges/religion/angel.png"),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Weather Preferences",
                  style: TextStyle(
                    fontSize: 15
                  ),
                ),
              ),
            ),
          //Weather badges
          GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              //Weather icons
              BadgeButton("assets/images/badges/weather/bolt.png"),
              BadgeButton("assets/images/badges/weather/clouds.png"),
              BadgeButton("assets/images/badges/weather/snowflake.png"),
              BadgeButton("assets/images/badges/weather/sunny.png"),
              BadgeButton("assets/images/badges/weather/temperature-1.png"),
              BadgeButton("assets/images/badges/weather/temperature-2.png"),
              BadgeButton("assets/images/badges/weather/temperature.png"),
              BadgeButton("assets/images/badges/weather/umbrella-1.png"),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(40),
            )
          ],
        ),
    );
  }
}
