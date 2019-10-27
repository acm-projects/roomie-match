//This screen will let the user pick basic info like age range, distance, and gender preference
import 'package:flutter/material.dart';
import 'package:roommate_app/screens/location_entry_screen.dart';
import 'addbadges.dart';
import 'dart:math' as math;

class PreferencesScreen extends StatefulWidget {
  @override
  _PreferencesScreenState createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  static final RangeThumbSelector _defaultRangeThumbSelector = (
      TextDirection textDirection,
      RangeValues values,
      double tapValue,
      Size thumbSize,
      Size trackSize,
      double dx, // drag displacement
      ) {

    final double touchRadius = math.max(thumbSize.width, 48 / 2);

    final bool inStartTouchTarget = (tapValue - values.start).abs() * trackSize.width < touchRadius;

    final bool inEndTouchTarget = (tapValue - values.end).abs() * trackSize.width < touchRadius;


    if (inStartTouchTarget && inEndTouchTarget) {
      bool towardsStart;
      bool towardsEnd;
      switch (textDirection) {
        case TextDirection.ltr:
          towardsStart = dx < 0;
          towardsEnd = dx > 0;
          break;
        case TextDirection.rtl:
          towardsStart = dx > 0;
          towardsEnd = dx < 0;
          break;
      }
      if (towardsStart)
        return Thumb.start;
      if (towardsEnd)
        return Thumb.end;
    } else {
      if (tapValue < values.start || inStartTouchTarget)
        return Thumb.start;
      if (tapValue > values.end || inEndTouchTarget)
        return Thumb.end;
    }
    return null;
  };

  RangeValues _values = RangeValues(18, 65);
  var _isSelected1 = false;
  var _isSelected2 = false;
  var _isSelected3 = false;

  static int _ageLower = 18;
  static int _ageUpper = 65;
  static int _distance = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        //Back button -- goes to location entry screen
        leading: IconButton(
          onPressed: (){
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => LocationEntryScreen())
            );
          },
          icon: Icon(Icons.chevron_left,
              color: Colors.deepPurpleAccent),
          iconSize: 40.0,
        ),
      ),
      body: Column(
          children: <Widget>[
            Column(
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
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ChoiceChip(
                      selectedColor: Colors.deepPurpleAccent,
                      labelPadding: EdgeInsets.all(10.0),
                      label: Image.asset('assets/images/man.png',
                        scale: 10,),
                      selected: _isSelected1,
                      onSelected: (isSelected) {
                        setState(() {
                          _isSelected1 = isSelected;
                          if (_isSelected2 || _isSelected3) {
                            _isSelected2 = false;
                            _isSelected3 = false;
                          }
                        });
                      },
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    ChoiceChip(
                      selectedColor: Colors.deepPurpleAccent,
                      labelPadding: EdgeInsets.all(10.0),
                      label: Image.asset('assets/images/woman.png',
                        scale: 10,),
                      selected: _isSelected2,
                      onSelected: (isSelected) {
                        setState(() {
                          _isSelected2 = isSelected;
                          if (_isSelected1 || _isSelected3) {
                            _isSelected1 = false;
                            _isSelected3 = false;
                          }
                        });
                      },
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    ChoiceChip(
                      selectedColor: Colors.deepPurpleAccent,
                      labelPadding: EdgeInsets.all(10.0),
                      label: Image.asset('assets/images/bigender.png',
                        scale: 10,),
                      selected: _isSelected3,
                      onSelected: (isSelected) {
                        setState(() {
                          _isSelected3 = isSelected;
                          if (_isSelected2 || _isSelected1) {
                            _isSelected1 = false;
                            _isSelected2 = false;
                          }
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 40.0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40.0, 5.0, 40.0, 5.0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Age",
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),),
                        Row(
                          children: <Widget>[
                            Text(_ageLower.toString(),
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),),
                            Text(" - ", style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(_ageUpper.toString(),
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),),
                          ],
                        ),
                      ],
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
                  child: SliderTheme(
                    data: SliderThemeData(
                      rangeThumbShape: RoundRangeSliderThumbShape(enabledThumbRadius: 15.0),
                      thumbSelector: _defaultRangeThumbSelector,
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
                      overlayShape:
                      RoundSliderOverlayShape(overlayRadius: 20.0),
                      trackHeight: 6,
                    ),
                    child: RangeSlider(
                      activeColor: Colors.deepPurpleAccent,
                      inactiveColor: Colors.grey.shade300,
                      values: _values,
                      min: 18,
                      max: 65,
                      onChanged: (RangeValues values) {
                        setState(() {
                          _values = values;
                          _ageLower = values.start.toInt();
                          _ageUpper = values.end.toInt();
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40.0, 5.0, 40.0, 5.0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Distance",
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),),
                    Row(
                      children: <Widget>[
                        Text(_distance.toString(),
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),),
                        Text(" miles",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),),
                      ],
                    ),
                  ],
                ),
                alignment: Alignment.centerLeft,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  thumbShape:
                  RoundSliderThumbShape(enabledThumbRadius: 15.0),
                  overlayShape:
                  RoundSliderOverlayShape(overlayRadius: 20.0),
                  trackHeight: 6,
                ),
                child: Slider(
                  activeColor: Colors.deepPurpleAccent,
                  inactiveColor: Colors.grey.shade300,
                  min: 0,
                  max: 30,
                  onChanged: (double newValue){
                    setState(() {
                      _distance = newValue.toInt();
                    });
                  },
                  value: _distance.toDouble(),
                ),
              ),
            ),
            SizedBox(
              height: 60.0,
            ),
            Container(
              width: 280.0,
              height: 60.0,
              //Finished button
              child: FlatButton(
                onPressed: () {
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
        ],
      ),
    );
  }
}



