import 'dart:async';

import 'package:http/http.dart' show Client;
import 'package:http/http.dart';
import 'package:split/Bloc/CommonVariables.dart';
import 'dart:convert';

import 'package:split/src/Models/promotionModel.dart';

// import 'package:split/src/Models/promotionModel.dart';

class PromotionApiProvider{

  Client client =  new Client();
  String root = StaticsVar.root;

  Future<List<PromotionMod>> promotionList(int branchId) async{
    
    List<PromotionMod> promoList;
    String url = '$root/api/operation/promotion/list/$branchId';
    var future = client.get(url,headers:{"Accept": "application/json","content-type": "application/json"});
    final response = await future;
    if(response.statusCode==200){
      List showUom = json.decode(response.body);
      promoList = showUom.map((promo) => PromotionMod.fromJson(promo)).toList();
      return promoList;
    }else {throw Exception('Failed to show Promotion List');}
  }

   //  Saving Promotion data
    Future<bool> savePromotionList(PromotionMod promo) async {
      String url = '$root/api/operation/promotion/save';
      bool respVal = false;
      var promotionListDts = json.encode(promo.toJson());
      print(promotionListDts);
      var future = client.post(url,body:promotionListDts,headers: {"Accept": "application/json", "content-type": "application/json" });
      final response = await future;
      print(response.body);
      if(response.statusCode == 200){
        var isUomDtsSuccess = json.decode(response.body);
        respVal = isUomDtsSuccess ? true : false;
        return respVal;
      }else  throw Exception('Failed to Save LookUp List');

  }

  // Delete data
  Future<bool> delPromotion(String brId,String promoId) async 
  {
    String promid = promoId.trim();
    String url = '$root/api/operation/promotion/delete/$brId/$promid';
    bool respVal = true;
    // var lookupDtls = json.encode(lookupDel.toJson());
    // print(lookupDtls);
    var future = client.get(url,headers: {"Accept": "application/json", "content-type": "application/json" });
    final response = await future;
    print(response.body);
    if(response.statusCode == 200){
      var isPromotionDtls = json.decode(response.body);
      respVal = isPromotionDtls ? true : false;
      return respVal;
    }else throw Exception('Item not Deleted');
  }


   
  Future<PromotionMod> getPromotion(int brnId,String prodNo) async
  {
    PromotionMod promMaster;
    
    String url = '$root/api/operation/promotion/getpromotion/$brnId/$prodNo';
    var future = client.get(url,headers:{"Accept": "application/json","content-type": "application/json"});
    final response = await future;
    if(response.statusCode==200){
       var shoQt = json.decode(response.body);
      promMaster =  new PromotionMod.fromJson(shoQt);
      return promMaster;
    }else {throw Exception('Failed to List Quotation');}
  }

}
