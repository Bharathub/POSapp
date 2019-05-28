import 'dart:async';

import 'package:http/http.dart' show Client;
import 'package:http/http.dart';
import 'package:split/Bloc/CommonVariables.dart';
import 'dart:convert';

import 'package:split/src/Models/quotationModel.dart';

// import 'package:split/src/Models/promotionModel.dart';

class QuotationApiProvider
{

  Client client =  new Client();
  String root = StaticsVar.root;
  
  Future<QuotationHd> quotationList(int brnId)async
  {
    QuotationHd quotList;
    
    String url = '$root/api/tariff/quotation/getstandardrateprofile/$brnId';
    var future = client.get(url,headers:{"Accept": "application/json","content-type": "application/json"});
    final response = await future;
    if(response.statusCode==200){
       var shoQt = json.decode(response.body);
      // List shoQt = json.decode(response.body);
      //for(var item in shoQt){ tempHD.add(item);}

      //quotList = tempHD.map((quotation) => QuotationHd.fromJson(quotation)).toList();
      quotList =  new QuotationHd.fromJson(shoQt);
      return quotList;
    }else {throw Exception('Failed to List Quotation');}
  }


  Future<List<QuotationHd>> quotationCustomerList(int brnId)async
  {
    List<QuotationHd> quotList;
    
    String url = '$root/api/tariff/quotation/getcustomerquotationlist/$brnId';
    var future = client.get(url,headers:{"Accept": "application/json","content-type": "application/json"});
    final response = await future;
    if(response.statusCode==200){
      // var shoQt = json.decode(response.body);
       List shoQt = json.decode(response.body);
      //for(var item in shoQt){ tempHD.add(item);}

      quotList = shoQt.map((quotation) => QuotationHd.fromJson(quotation)).toList();
      //quotList =  new QuotationHd.fromJson(shoQt);
      return quotList;
    } else {throw Exception('Failed to List Quotation');}
  }



  Future<List<QuotationHd>> quotationSupplierList(int brnId) async
  {
    List<QuotationHd> quotList;
    
    String url = '$root/api/tariff/quotation/getsupplierquotationlist/$brnId';
    var future = client.get(url,headers:{"Accept": "application/json","content-type": "application/json"});
    final response = await future;
    if(response.statusCode==200){
      // var shoQt = json.decode(response.body);
       List shoQt = json.decode(response.body);
      //for(var item in shoQt){ tempHD.add(item);}

      quotList = shoQt.map((quotation) => QuotationHd.fromJson(quotation)).toList();
      //quotList =  new QuotationHd.fromJson(shoQt);
      return quotList;
    } else {throw Exception('Failed to List Supplier');}
  }


    
  Future<QuotationHd> getQuotation(int brnId,String quotNo) async
  {
    QuotationHd quotList;
    
    String url = '$root/api/tariff/quotation/getquotation/$brnId/$quotNo';
    var future = client.get(url,headers:{"Accept": "application/json","content-type": "application/json"});
    final response = await future;
    if(response.statusCode==200){
       var shoQt = json.decode(response.body);
      quotList =  new QuotationHd.fromJson(shoQt);
      return quotList;
    }else {throw Exception('Failed to List Quotation');}
  }





   //  Saving Promotion data
    Future<bool> saveCustQuotaion(QuotationHd qHD) async {
      String root = StaticsVar.root;
      String url = '$root/api/tariff/quotation/savequotation';
      bool respVal = false;
      var quotHD = json.encode(qHD.toJson());
      print(quotHD);
      var future = client.post(url,body:quotHD,headers: {"Accept": "application/json", "content-type": "application/json" });
      final response = await future;
      print(response.body);
      if(response.statusCode == 200){
        var isUomDtsSuccess = json.decode(response.body);
        respVal = isUomDtsSuccess ? true : false;
        return respVal;
      }else  throw Exception('Failed to Save LookUp List');

  }


  

  // Delete data
  Future<bool> delQuotList(String usrId, int brId,String quotnNo) async 
  {
    String root = StaticsVar.root;
    String url = '$root/api/tariff/quotation/deletequotation/$usrId/$brId/$quotnNo';
    bool respVal = true;
    var future = client.get(url,headers: {"Accept": "application/json", "content-type": "application/json" });
    final response = await future;
    print(response.body);
    if(response.statusCode == 200){
      var isPromotionDtls = json.decode(response.body);
      respVal = isPromotionDtls ? true : false;
      return respVal;
    }else throw Exception('Item not Deleted');
  }

  












}
