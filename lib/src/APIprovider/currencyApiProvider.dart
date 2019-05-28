import 'dart:async';

import 'package:http/http.dart' show Client;
import 'package:split/Bloc/CommonVariables.dart';
import 'package:split/src/Models/currencyModel.dart';
import 'dart:convert';

class CurrencyApiProvider{

  Client client =  new Client();

  Future<List<Currency>> currencyList() async{
    List<Currency> curList;
    String root = StaticsVar.root;
    String url = '$root/api/master/currency/currencylist';
    var future = client.get(url,headers:{"Accept": "application/json","content-type": "application/json"});
        final response = await future;
        if(response.statusCode==200){
        List shoCurrency = json.decode(response.body);
        curList = shoCurrency.map((cur) => Currency.fromJson(cur)).toList();
        return curList;
    }else {throw Exception('Failed to show UomList');}
  }



    //  Saving Currencylist data
    Future<bool> saveCurrencyList(Currency currModDtls) async {

      String root = 'http://posapi.logiconglobal.com';
      String url = '$root/api/master/currency/save';
      bool respVal = false;

      var currListDts = json.encode(currModDtls.toJson());
      print(currListDts);
      var future = client.post(url,body:currListDts,headers: {"Accept": "application/json", "content-type": "application/json" });
      final response = await future;
      print(response.body);
      if(response.statusCode == 200){
        var iscurrDtsSuccess = json.decode(response.body);
        respVal = iscurrDtsSuccess ? true : false;
        return respVal;
      }else throw Exception('Failed to Save Product Category List');

  }


  //   Deleting data
  Future<bool> delCurrList(String currencyCode) async 
  {
    String root = StaticsVar.root;
    String url = '$root/api/master/currency/delete/$currencyCode';
    bool respVal = true;
    // var lookupDtls = json.encode(lookupDel.toJson());
    // print(lookupDtls);
    var future = client.get(url,headers: {"Accept": "application/json", "content-type": "application/json" });
    final response = await future;
    print(response.body);
    if(response.statusCode == 200){
      var isCurrencyDtls = json.decode(response.body);
      respVal = isCurrencyDtls ? true : false;
      return respVal;
    }else throw Exception('Item not Deleted');
  }
}
