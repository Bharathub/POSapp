import 'dart:async';

import 'package:http/http.dart' show Client;
import 'package:split/Bloc/CommonVariables.dart';
import 'package:split/src/Models/incotermModel.dart';
import 'dart:convert';


class IncotermApiProvider{

  Client client =  new Client();

  Future<List<Incoterm>> incotermList() async{
    List<Incoterm> incoList;
    String root = StaticsVar.root;
    String url = '$root/api/lookups/incotermlist';
    var future = client.get(url,headers:{"Accept": "application/json","content-type": "application/json"});

    final response = await future;
    if(response.statusCode==200){
      List showIncoterm = json.decode(response.body);

      incoList = showIncoterm.map((inco) => Incoterm.fromJson(inco)).toList();

   
      return incoList;
    }else {throw Exception('Failed to show IncotermList');}
  }

}
