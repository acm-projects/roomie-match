import 'package:flutter/material.dart';
import 'addbadges.dart';

class PreferencesScreen extends StatefulWidget {
  @override
  _PreferencesScreenState createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  var _isSelected1 = false;
  var _isSelected2 = false;
  var _isSelected3 = false;

  int _age = 18;
  int _distance = 0;

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
            height: 15.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ChoiceChip(
                selectedColor: Colors.deepPurpleAccent,
//              padding: EdgeInsets.all(10.0),
                labelPadding: EdgeInsets.all(10.0),
                label: Image.asset('images/man.png',
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
//              padding: EdgeInsets.all(10.0),
                labelPadding: EdgeInsets.all(10.0),
                label: Image.asset('images/woman.png',
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
//              padding: EdgeInsets.all(10.0),
                labelPadding: EdgeInsets.all(10.0),
                label: Image.asset('images/bigender.png',
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
              padding: const EdgeInsets.fromLTRB(40.0, 5.0, 0, 5.0),
              child: Container(
                child: Text("Age",
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),),
                alignment: Alignment.centerLeft,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Slider(
                activeColor: Colors.deepPurpleAccent,
                inactiveColor: Colors.grey.shade300,
                min: 18,
                max: 55,
                onChanged: (double newValue){
                  setState(() {
                    _age = newValue.toInt();
                  });
                },
                value: _age.toDouble(),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40.0, 5.0, 0, 5.0),
              child: Container(
                child: Text("Distance",
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),),
                alignment: Alignment.centerLeft,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  thumbShape:
                  RoundSliderThumbShape(enabledThumbRadius: 15.0),
                  overlayShape:
                  RoundSliderOverlayShape(overlayRadius: 20.0),
                  trackHeight: 4,
                ),
                child: Slider(
                  activeColor: Colors.deepPurpleAccent,
                  inactiveColor: Colors.grey.shade300,
                  min: 0,
                  max: 55,
                  onChanged: (double newValue){
                    setState(() {
                      _distance = newValue.toInt();
                    });
                  },
                  value: _distance.toDouble(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

