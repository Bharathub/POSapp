
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StaticsVar {

  static const root = 'http://posapi.logiconglobal.com';
  static const branchID = 160;

  // Static Methods
  // to pop up any message to the User
  static showAlert(BuildContext context, String strVal) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) 
      {
        // return object of type Dialog
        return SimpleDialog(children: <Widget>[ 
          //showRadioBtn(context),
          Text(strVal,textAlign: TextAlign.center, style: TextStyle(fontFamily: 'roboto', fontSize: 40),),
          Container(color: Colors.blueGrey,height: 1.0,),
          new FlatButton(child: new Text("Close",style:  TextStyle(fontFamily: 'roboto', fontSize: 25),),
                         onPressed: () {Navigator.of(context).pop();},
          )
        ],);
      },
    );
    //return true;
  }
  
}

