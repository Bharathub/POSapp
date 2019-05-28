import 'dart:async';
import 'package:http/http.dart' show Client;
import 'package:http/http.dart';
import 'package:split/Bloc/CommonVariables.dart';
import 'dart:convert';
import 'package:split/src/Models/purchaserOrderModel.dart';

class PurchaseOrederApi
{

  Client client =  new Client();
  String root = StaticsVar.root;

  Future<List<PurchaeOrderHD>> pOList() async
  {
    List<PurchaeOrderHD> poList;
    String url = '$root/api/operation/purchaseorder/list/160';
    var future = client.get(url,headers:{"Accept": "application/json","content-type": "application/json"});
    final response = await future;

    if(response.statusCode==200)
    {
      List showUom = json.decode(response.body);
      poList = showUom.map((po) => PurchaeOrderHD.fromJson(po)).toList();
      return poList;
    }else {throw Exception('Failed to show UomList');}
  }

  


  //  Saving Purchase Order
    Future<bool> savePO(PurchaeOrderHD poHd) async 
    {
      String url = '$root/api/operation/purchaseorder/save';
      bool respVal = false;
      var poHDObj = json.encode(poHd.toJson());
      print(poHDObj);
      var future = client.post(url,body:poHDObj,headers: {"Accept": "application/json", "content-type": "application/json" });
      final response = await future;
      print(response.body);
      if(response.statusCode == 200){
        var isUomDtsSuccess = json.decode(response.body);
        respVal = isUomDtsSuccess ? true : false;
        return respVal;
      }else  throw Exception('Failed to Save Purchase Order.');

  }

    // DELETING PO

  Future<bool> delPoList(int branchId,String poNo,String userId) async 
  {
    String root = StaticsVar.root;
    String url = '$root/api/operation/purchaseorder/delete/$branchId/$poNo/$userId';
    bool respVal = true;
    // var lookupDtls = json.encode(lookupDel.toJson());
    // print(lookupDtls);
    var future = client.get(url,headers: {"Accept": "application/json", "content-type": "application/json" });
    final response = await future;
    print(response.body);
    if(response.statusCode == 200){
      var isPoDtls = json.decode(response.body);
      respVal = isPoDtls ? true : false;
      return respVal;
    }else throw Exception('Item not Deleted');
  }

    // get PO 
  Future<PurchaeOrderHD> getPO(int brnId,String poNum) async
  {
    PurchaeOrderHD poMaster;
    String url = '$root/api/operation/purchaseorder/getpo/$brnId/$poNum';
    var future = client.get(url,headers:{"Accept": "application/json","content-type": "application/json"});
    final response = await future;
    if(response.statusCode==200){
       var showPO = json.decode(response.body);
      poMaster =  new PurchaeOrderHD.fromJson(showPO);
      return poMaster;
    }else {throw Exception('Failed to Edit');}
  }



}