//This screen is the start of the user profile creation process
import 'package:flutter/material.dart';
import 'package:roommate_app/constants.dart';
import 'package:roommate_app/field_enforcer.dart';
import 'package:roommate_app/screens/aboutme.dart';
import '../user_info.dart';
import 'signup.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:roommate_app/field_enforcer.dart';
import 'package:path/path.dart';

class ProfileCreationScreen extends StatefulWidget {
  String _selectedGender = kGENDER_MALE;  //Holds the current gender selection; initialzed to the default gender

  @override
  _ProfileCreationScreenState createState() => _ProfileCreationScreenState();
}

class _ProfileCreationScreenState extends State<ProfileCreationScreen> {
  File _image;
  TextEditingController firstNameTextController = TextEditingController();
  TextEditingController lastNameTextController = TextEditingController();
  TextEditingController ageTextController = TextEditingController();

  FocusNode lastNameFieldFocusNode = new FocusNode();
  FocusNode ageFieldFocusNode = new FocusNode();

  Future getImageFromGallery(BuildContext context) async{
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState((){
      _image = image;
    });
    Navigator.of(context).pop();
  }

  Future getImageFromCamera(BuildContext context) async{
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState((){
      _image = image;
    });
    Navigator.of(context).pop();

  }

  Future<void> _showChoiceDialog(BuildContext context){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text("Make a choice:"),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: Text("Gallery"),
                onTap: (){
                  getImageFromGallery(context);
                },
              ),
              Padding(padding: EdgeInsets.all(8.0),),
              GestureDetector(
                child: Text("Camera"),
                onTap: (){
                  getImageFromCamera(context);
                },
              ),
            ],
          ),
        ),
      );
    });
  }

  Future uploadPic(BuildContext context) async{
      String fileName = basename(_image.path);
      StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot takeSnapshot = await uploadTask.onComplete;
      setState(() {
        print("Profile picture uploaded");
        Scaffold.of(context).showSnackBar(SnackBar(content: Text("Profile picture uploaded")));
      });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            //Back button -- goes to sign up page
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignupScreen())
              );
            },
            icon: Icon(Icons.chevron_left),
            iconSize: 40.0,
            color: Colors.deepPurpleAccent,
          ),
        ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey,
                    child: ClipOval(
                      child: SizedBox(
                        width: 180,
                        height : 180.0,
                        child: (_image != null)? Image.file(_image, fit: BoxFit.fill):
                        Image.network( "https://i0.wp.com/acaweb.org/wp-content/uploads/2018/12/profile-placeholder.png?fit=300%2C300&ssl=1",
                          fit: BoxFit.fill,
                        ),
                      ),
                    )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 60.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.add_a_photo,
                      size: 30.0,
                    ),
                    onPressed: (){ _showChoiceDialog(context);},
                  ),
                )
              ],
          ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Container(
                  child: Text("Profile",
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
                //First name text field
                child: TextField(
                  controller: firstNameTextController,
                  onSubmitted: (_) {
                    FocusScope.of(context).requestFocus(lastNameFieldFocusNode);
                  },
                  decoration: InputDecoration(
                    hintText: "First Name",
                  ),
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                //Last name text field
                child: TextField(
                  controller: lastNameTextController,
                  onSubmitted: (_) {
                    FocusScope.of(context).requestFocus(ageFieldFocusNode);
                  },
                  focusNode: lastNameFieldFocusNode,
                  decoration: InputDecoration(
                    hintText: "Last Name",
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(40, 25, 180, 25),
                      //Age numeric text field
                      child: TextField(
                      controller: ageTextController,
                      focusNode: ageFieldFocusNode,
                      maxLength: 2,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        hintText: "Age",
                        counterText: ""
                      ),
                    ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 14.77, 40, 0),
                      //Gender selection dropdown button
                      child: DropdownButton<String>(
                      value: widget._selectedGender,
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 30,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 17,
                        fontFamily: "Poppins"
                      ),
                      underline: Container(
                        height: 1.1,
                        color: Colors.grey
                      ),
                      onChanged: (String newSelection) => setState(() => widget._selectedGender = newSelection),
                      items: <String>[kGENDER_MALE, kGENDER_FEMALE]
                      .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value)
                        );
                      }).toList(),
                      ),
                    ),
                ],
              ),
              SizedBox(
                height: 50.0,
              ),
              Container(
                width: 280.0,
                height: 60.0,
                //Next button
                child: FlatButton(
                  onPressed: () {
                    //Validate that the first name, last name, and age fields are not empty (gender cannot be empty because it has a default value)
                    if (!FieldEnforcer.enforceFullFields(context, [firstNameTextController, lastNameTextController, ageTextController])) {
                      return;
                    }
                    
                    //Store the user's info in the UserInformation abstract class
                    UserInformation.firstName = firstNameTextController.text;
                    UserInformation.lastName = lastNameTextController.text;
                    UserInformation.gender = widget._selectedGender;
                    UserInformation.age = int.parse(ageTextController.text);

                    uploadPic(context);
                    //Route to about me page
                   Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AboutMeScreen())
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
            ],
          ),
        ),
      )
    );
  }
}
