import 'dart:async';
import 'package:http/http.dart' show Client;
import 'package:http/http.dart';
import 'package:split/Bloc/CommonVariables.dart';
import 'dart:convert';
import 'package:split/src/Models/salesEntryModel.dart';

class SalesEntryApi{

    Client client =  new Client();
    String root = StaticsVar.root;

  Future<List<SalesEntryHd>> salesEntryList(int brID) async{
    List<SalesEntryHd> seList;
    String url = '$root/api/operation/salesorder/list/$brID';
    var future = client.get(url,headers:{"Accept": "application/json","content-type": "application/json"});

    final response = await future;
    if(response.statusCode==200){
      List showSE = json.decode(response.body);
      seList = showSE.map((se) => SalesEntryHd.fromJson(se)).toList();
      return seList;
    }else {throw Exception('Failed to show Sales Entry');}
  }

  Future<SalesEntryDetails> getSalesEntryItem(int brID, String custCode, String prodCode, String qty) async{
    SalesEntryDetails seDetail;  
    String url = '$root/api/operation/salesorder/addproducttogrid/$brID/$custCode/$prodCode/$qty';
    var future = client.get(url,headers:{"Accept": "application/json","content-type": "application/json"});
    final response = await future;
    if(response.statusCode==200){
      var grVal = json.decode(response.body);
      seDetail = SalesEntryDetails.fromJson(grVal);
      return seDetail;
    } else {throw Exception('Failed to Retrive Sales Entry Details');}
  }

   //  Saving Goods data
  Future<bool> saveSalesEntry(SalesEntryHd seOrdHD) async {
    String url = '$root/api/operation/salesorder/save';
    bool respVal = false;
    var seDtls = json.encode(seOrdHD.toJson());
    print(seDtls);
    var future = client.post(url,body:seDtls,headers: {"Accept": "application/json", "content-type": "application/json" });
    final response = await future;
    print(response.body);
    if(response.statusCode == 200){
      var isSESuccess = json.decode(response.body);
      respVal = isSESuccess ? true : false;
      return respVal;
    }else  throw Exception('Failed to Save Sales Entry');

  }

  // DELETING SALES ENTRY LIST ORDER NO

  Future<bool> delSeList(int branchId,String orderNo,String userId) async 
  {
    String root = StaticsVar.root;
    String url = '$root/api/operation/salesorder/delete/$branchId/$orderNo/$userId';
    bool respVal = true;
    // var lookupDtls = json.encode(lookupDel.toJson());
    // print(lookupDtls);
    var future = client.get(url,headers: {"Accept": "application/json", "content-type": "application/json" });
    final response = await future;
    print(response.body);
    if(response.statusCode == 200){
      var isSalesEntry = json.decode(response.body);
      respVal = isSalesEntry ? true : false;
      return respVal;
    }else throw Exception('Item not Deleted');
  }

    // get SE 
  Future<SalesEntryHd> getSalesEntry(int brnId,String orderNum) async
  {
    SalesEntryHd poMaster;
    String url = '$root/api/operation/salesorder/getsalesorder/$brnId/$orderNum';
    var future = client.get(url,headers:{"Accept": "application/json","content-type": "application/json"});
    final response = await future;
    if(response.statusCode==200){
       var showSE = json.decode(response.body);
      poMaster =  new SalesEntryHd.fromJson(showSE);
      return poMaster;
    }else {throw Exception('Failed to Edit');}
  }


}
