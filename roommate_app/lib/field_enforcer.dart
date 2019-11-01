import 'package:flutter/material.dart';

abstract class FieldEnforcer {

  //Displays a message if any of the passed text editing controllers are blank; returns true if all fields are full and false if at least one field is empty
  static bool enforceFullFields(BuildContext context, List<TextEditingController> textEditingControllers) {
    Widget okButton = FlatButton(
      child: Text(
        "Ok",
        style: TextStyle(
          color: Colors.deepPurpleAccent
        )
      ),
      onPressed: () {
        Navigator.pop(context);
      }
    );

    AlertDialog loginAlertDialog = AlertDialog(
      title: Text("Error"),
      content: Text("No fields can be left blank"),
      actions: [okButton]
    );

    //Iterate through passed text editing controllers and shoose
    for (TextEditingController textEditingController in textEditingControllers) {
      //If at least one field is found to be empty, show the error dialog
      if (textEditingController.text.isEmpty) {
        print("REACHED IF");
        showDialog(
          context: context,
          builder: (BuildContext context) {
            print("REACHED BUILDER");
            return loginAlertDialog;
          }
        );
        return false;
      }
    } //end for

    //If all fields are full, return true
    return true;
  }

  //Display a generic error dialog message
  static void showErrorDialog(BuildContext context, String message) {
    Widget okButton = FlatButton(
      child: Text(
        "Ok",
        style: TextStyle(
          color: Colors.deepPurpleAccent
        )
      ),
      onPressed: () {
        Navigator.pop(context);
      }
    );

    AlertDialog loginAlertDialog = AlertDialog(
      title: Text("Error"),
      content: Text(message),
      actions: [okButton]
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return loginAlertDialog;
        }
      );
  }
}