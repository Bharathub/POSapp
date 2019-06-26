//import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:path_provider/path_provider.dart';
//import 'package:open_file/open_file.dart';
//import 'package:flutter/src/gestures/tap.dart';
import 'package:url_launcher/url_launcher.dart';


class StaticsVar {

  static const root = 'http://posapi.logiconglobal.com';
  static const branchID = 160;
  static const double vatPercent = 7.0;
  static const double whTaxPercent = 3.0;

  // Static Methods
  // to pop up any message to the User
  static showAlert(BuildContext context, String strVal) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) 
      {
        // return object of type Dialog
        return SimpleDialog(
          elevation: 10.0,
          children: <Widget>[ 
            Text(strVal,textAlign: TextAlign.center, style: TextStyle(fontFamily: 'roboto', fontSize: 20),),
            Container(color: Colors.blueGrey,height: 1.0,),
            new FlatButton(child: new Text("Close",style:  TextStyle(fontFamily: 'roboto', fontSize: 15, color: Colors.blue),),
                          onPressed: () {Navigator.of(context).pop();},
            )
          ],);
      },
    );
  }
  
  //static downloadPDF(String urlPath, String localfileName) async
  static downloadPDF(String urlPath) async
  {
    //Dio dio = Dio();
    
    try
    {
      if (await canLaunch(urlPath)) 
      { await launch(urlPath, forceWebView: false);} //, forceSafariVC: false, forceWebView: false

      // var localDirPath = await getApplicationDocumentsDirectory();
      // var localPath = localDirPath.path + '/' + localfileName;
      
      // await dio.download(urlPath, localPath,
      //           onReceiveProgress: (rec, total){ 
      //             print("Received: $rec / Total : $total");
      //             print("Percentage: " + ((rec/total)*100).toStringAsFixed(0) + "%");});
      // // OpenFile.open(localPath);
      

      // print("Url Path => " + urlPath);
      // print("File Path => " + localPath);
    }
    catch(err){
      throw err;
    }
  }

  // static showAlert1(BuildContext context, String strVal) {
  //   // flutter defined function
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) 
  //     {
  //       // return object of type Dialog
  //       return SimpleDialog(
  //         elevation: 10.0,
  //         children: <Widget>[ 
  //         //showRadioBtn(context),
  //         Text(strVal,textAlign: TextAlign.center, style: TextStyle(fontFamily: 'roboto', fontSize: 20),),
  //         // Container(color: Colors.blueGrey,height: 1.0,),
  //         new FlatButton(
  //           child: new Text("Close",style:  TextStyle(fontFamily: 'roboto', fontSize: 15,color: Colors.blue),),
  //            onPressed: () {Navigator.of(context).pop();},
  //         )
  //       ],);
  //     },
  //   );
  //   //return true;
  // }

}

