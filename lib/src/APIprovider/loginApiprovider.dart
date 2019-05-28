
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:split/src/Models/loginmodel.dart';
// import 'package:split/src/Models/loginmodel.dart';

class LoginApi {

  Client client =Client();
  Future<bool> checkUserLogin(Users users) async{
    String userID = users.userID;
    String pwd = users.password;
    String root = 'http://posapi.logiconglobal.com';
    String url = '$root/api/auth/login/userdo/$userID/$pwd';
    bool respVal =false;
    // var usr = json.encode(user.toJson());
    final response =  await client.get(url,headers: {"Accept": "application/json","content-type": "application/json"});
    if (response.statusCode == 200) {
      var isLoginSuccess = json.decode(response.body); 
      respVal = isLoginSuccess ? true:false;
    } else throw Exception('Login Failed! Invalid UserID or Password');
        return respVal;
  } 
}

