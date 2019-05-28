import 'dart:async';

import 'package:http/http.dart' show Client;
import 'package:http/http.dart';
import 'package:split/Bloc/CommonVariables.dart';
import 'dart:convert';
import 'package:split/src/Models/lookupModel.dart';

class LookUpApiProvider
{

  Client client =  new Client();
  Future<List<Lookup>> uomList() async{
    List<Lookup> uomList;
    String root = StaticsVar.root;
    String url = '$root/api/lookups/uomlist';
    print('URL'+ url);
    var future = client.get(url,headers:{"Accept": "application/json","content-type": "application/json"});
    final response = await future;
    if(response.statusCode==200){
      List showUom = json.decode(response.body);
      print(response.body);
      uomList = showUom.map((uom) => Lookup.fromJson(uom)).toList();
      return uomList;
    }else {throw Exception('Failed to show UomList');}
  }
      // returns the perticular object
  //   Future<List<Lookup>> uomPopUpObj(Lookup lookups) async{
  //   List<Lookup> uomList;
  //   String root = StaticsVar.root;
  //   String url = '$root/api/lookups/getlookup/$lookups';
  //   var future = client.get(url,headers:{"Accept": "application/json","content-type": "application/json"});
  //   final response = await future;
  //   if(response.statusCode==200){
  //     List showUom = json.decode(response.body);
  //     uomList = showUom.map((uom) => Lookup.fromJson(uom)).toList();
  //     return uomList;
  //   }else {throw Exception('Failed to show UomList');}
  // }


   //  Saving Promotion data
    Future<bool> saveLookUptList(Lookup uomSavDtls) async {
      String root = 'http://posapi.logiconglobal.com';
      String url = '$root/api/lookups/save';
      bool respVal = false;
      var uomListDts = json.encode(uomSavDtls.toJson());
      print(uomListDts);
      var future = client.post(url,body:uomListDts,headers: {"Accept": "application/json", "content-type": "application/json" });
      final response = await future;
      print(response.body);
      if(response.statusCode == 200){
        var isUomDtsSuccess = json.decode(response.body);
        respVal = isUomDtsSuccess ? true : false;
        return respVal;
      }else  throw Exception('Failed to Save LookUp List');

  }

  // Delete data
  Future<bool> delLookup(String lookupCode) async 
  {
    String root = StaticsVar.root;
    String url = '$root/api/lookups/delete/$lookupCode';
    bool respVal = true;
    // var lookupDtls = json.encode(lookupDel.toJson());
    // print(lookupDtls);
    var future = client.get(url,headers: {"Accept": "application/json", "content-type": "application/json" });
    final response = await future;
    print(response.body);
    if(response.statusCode == 200){
      var isLookupDtls = json.decode(response.body);
      respVal = isLookupDtls ? true : false;
      return respVal;
    }else throw Exception('Item not Deleted');
  }

  // Returns particular objects

   Future<List<Lookup>> lookupObj() async{
    List<Lookup> uomList;
    String root = StaticsVar.root;
    String url = '$root/api/lookups/uomlist';
    var future = client.get(url,headers:{"Accept": "application/json","content-type": "application/json"});

    final response = await future;
    if(response.statusCode==200){
      List showUom = json.decode(response.body);
      uomList = showUom.map((uom) => Lookup.fromJson(uom)).toList();
      return uomList;
    }else {throw Exception('Failed to show UomList');}
  }












}
