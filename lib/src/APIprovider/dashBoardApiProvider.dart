import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:http/http.dart';
import 'package:split/Bloc/CommonVariables.dart';
import 'package:split/src/Models/dashBoardModel.dart';

class DashBoardApi
{
  Client client =  new Client();
  String root = StaticsVar.root;

  Future<DashBoards> getDashBoards(int branchId,int count) async
  {
    String url = '$root/api/operations/orderentry/getdashboard/$branchId/$count';
    // List<DashBoards> DashBoardsList = [];
    DashBoards dblist;
    var future = client.get(url,headers: {"Accept": "application/json", "content-type": "application/json" });
    final response = await future;
    // print(response.body);
    if(response.statusCode == 200){
      var dbDtls = json.decode(response.body);
      // dblist = dbDtls.map((db) => DashBoards.fromJson(db)).toList();
      dblist = DashBoards.fromJson(dbDtls);
      return dblist;    
    }else  throw Exception('Failed to Show DashBoards');
  }
  
}

