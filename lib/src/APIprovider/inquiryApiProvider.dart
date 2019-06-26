 

import 'dart:async';

import 'package:http/http.dart' show Client;
import 'package:split/Bloc/CommonVariables.dart';
import 'package:split/src/Models/inquiryModel.dart';
import 'dart:convert';
import 'package:split/src/Models/invoiceModel.dart';


class InquiryApi {
    Client client =  new Client();
    String root = StaticsVar.root;
    // int _branchID = StaticsVar.branchID;

 //Unapproved invoice list 
  Future<List<UnApprovedInvoice>> getInquiryInvoices(SrchUnApprdInvoice srUnApprovedInvoices) async
  {
    String url = '$root/api/operation/invoice/inquiry';
    List<UnApprovedInvoice> unAppInvoices = [];
    var gsListDts = json.encode(srUnApprovedInvoices.toJson());
    print(gsListDts);
    var future = client.post(url,body:gsListDts,headers: {"Accept": "application/json", "content-type": "application/json" });
    final response = await future;
    print(response.body);
    if(response.statusCode == 200){
      List unAppInvList = json.decode(response.body);
      unAppInvoices = unAppInvList.map((inv) => UnApprovedInvoice.fromJson(inv)).toList();
      return unAppInvoices;    
    }else  throw Exception('Failed to Get Invoice List');
  }




  
  Future<List<StockInquiry>> getStockInquiry(Search4StockEnq srstockEnq) async
  {
    String url = '$root/api/inquiry/inquiry/stockinquiry';
    List<StockInquiry> stockEnqlist = [];
    var gsListDts = json.encode(srstockEnq.toJson());
    print(gsListDts);
    var future = client.post(url,body:gsListDts,headers: {"Accept": "application/json", "content-type": "application/json" });
    final response = await future;
    print(response.body);
    if(response.statusCode == 200){
      List unAppInvList = json.decode(response.body);
      stockEnqlist = unAppInvList.map((inv) => StockInquiry.fromJson(inv)).toList();
      return stockEnqlist;    
    }else  throw Exception('Failed to Get Invoice List');
  }







}

