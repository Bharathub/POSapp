import 'dart:async';

import 'package:http/http.dart' show Client;
import 'package:http/http.dart';
import 'package:split/Bloc/CommonVariables.dart';
import 'dart:convert';

import 'package:split/src/Models/invoiceModel.dart';

class InvoiceApi
{

  Client client =  new Client();
  String root = StaticsVar.root;
  int _branchID = StaticsVar.branchID;

  Future<List<UnApprovedInvoice>> getUnApprovedInvoices(SrchUnApprdInvoice srUnApprovedInvoices) async {
    String url = '$root/api/operation/invoice/unapprovedinvoicelist';
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

  Future<List<InvoiceHeader>> getInvoiceList() async {
    String url = '$root/api/operation/invoice/invoicelist/$_branchID';
    List<InvoiceHeader> invoiceHDList = [];
    var future = client.get(url,headers: {"Accept": "application/json", "content-type": "application/json" });
    final response = await future;
    print(response.body);
    if(response.statusCode == 200){
      List invHDs = json.decode(response.body);
      invoiceHDList = invHDs.map((inv) => InvoiceHeader.fromJson(inv)).toList();
      return invoiceHDList;    
    }else  throw Exception('Failed to Get Invoice List');
  }

  // To save the selected invoices
  Future<bool> approveInvoices(SelectedInvoices selectedInvoices) async {
    String url = '$root/api/operation/invoice/unapprovedinvoicelist';
    bool respVal = false;
    var selInvs = json.encode(selectedInvoices.toJson());
    print(selInvs);
    var future = client.post(url,body:selInvs,headers: {"Accept": "application/json", "content-type": "application/json" });
    final response = await future;
    print(response.body);
    if(response.statusCode == 200){
      var isInvoicesSuccess = json.decode(response.body);
      respVal = isInvoicesSuccess ? true : false;
      return respVal;
    }else  throw Exception('Failed to Approve Invoice List');
  }

  // http://posapi.logiconglobal.com/api/operation/invoice/getinvoice/160/PAINV190500008

  //To save the selected invoices
  Future<InvoiceHeader> getInvoiceDetails(int branchID, String invNo) async {
    InvoiceHeader invHD;
    String url = '$root/api/operation/invoice/getinvoice/$branchID/$invNo';
    var future = client.get(url,headers: {"Accept": "application/json", "content-type": "application/json" });
    final response = await future;
    print(response.body);
    if(response.statusCode == 200){
      var shoQt = json.decode(response.body);
      invHD =  new InvoiceHeader.fromJson(shoQt);
      return invHD;
    }else  throw Exception('Failed to Get Invoice Details');
  }

}
