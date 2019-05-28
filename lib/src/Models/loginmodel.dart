


// import 'package:http/http.dart' show get;
// import 'dart:convert';

class LoginUserInfo{
  final String message;                //": "SUCCESS",
  final String userID; 
  final String userPwd;                //": "admin",


  LoginUserInfo({this.message,  this.userID,this.userPwd
              });

  factory LoginUserInfo.fromJSon(Map<String, dynamic> json)
  {
     return new LoginUserInfo( 
      message: json['message'],
      userID: json['userID'],
      userPwd: json['userPwd']
);
  }

}

class Users{
  String userID; 
  String password; 
  String message;
 

  Users({this.userID,this.password,this.message});

  Map<String, dynamic> toJSon() =>
  { 
      'userID': userID,
      'password': password,
      'message': message,

  };

}
