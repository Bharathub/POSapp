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
  int branchID = StaticsVar.branchID;

  //Unapproved invoice list 
  Future<List<UnApprovedInvoice>> getUnApprovedInvoices(SrchUnApprdInvoice srUnApprovedInvoices) async
  {
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

  Future<List<InvoiceHeader>> getInvoiceList() async
  {
    String url = '$root/api/operation/invoice/invoicelist/$branchID';
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
  //get customer invoice list

  Future<CustomerInvHd> getCusInvList(int branchID,String invoiceNo) async
  {
    String url = '$root/api/operation/invoice/getinvoice/$branchID/$invoiceNo';
    CustomerInvHd custDtls;
    var future = client.get(url,headers: {"Accept": "application/json", "content-type": "application/json" });
    final response = await future;
    print(response.body);
    if(response.statusCode == 200){
      var invHDs = json.decode(response.body);
      custDtls =  CustomerInvHd.fromJson(invHDs);
      return custDtls;    
    }else  throw Exception('Failed to Get Invoice List');
  }


  //Approve invoie save

   Future<bool> approveInvoices(List<SelectedInvoices> selectedInvoices) async
   {
    String url = '$root/api/operation/invoice/approveInvoice';
    bool respVal = false;
    var selInvs = json.encode(selectedInvoices.map((selinv) => selinv.toJson()).toList());
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


  Future<CustomerInvDts> getInvoiceDetails(int branchID, String invoiceNo) async {
    CustomerInvDts invHD;
    String url = '$root/api/operation/invoice/getinvoice/$branchID/$invoiceNo';
    var future = client.get(url,headers: {"Accept": "application/json", "content-type": "application/json" });
    final response = await future;
    print(response.body);
    if(response.statusCode == 200){
      var shoQt = json.decode(response.body);
      invHD =  new CustomerInvDts.fromJson(shoQt);
      return invHD;
    }else  throw Exception('Failed to Get Invoice Details');
  }

  //Unbilled invoicelist 

 Future<List<UnBilledInvoice>> getUnBilledInvoices(SrchUnApprdInvoice srUnBilledInvoices) async
 {
    String url = '$root/api/operation/invoice/unbilledinvoicelist';
    List<UnBilledInvoice> unBilledList = [];
    var unBldDtls = json.encode(srUnBilledInvoices.toJson());
    print(unBldDtls);
    var future = client.post(url,body:unBldDtls,headers: {"Accept": "application/json", "content-type": "application/json" });
    final response = await future;
    print(response.body);
    if(response.statusCode == 200){
      List unBilledInv = json.decode(response.body);
      unBilledList = unBilledInv.map((inv) => UnBilledInvoice.fromJson(inv)).toList();
      return unBilledList;    
    }else  throw Exception('Failed to Get UnbilledList');
  }

  
   Future<bool> unBilledInvoices(List<SelectedInvoices> selectedInvoices) async
   {
    String url = '$root/api/operation/invoice/approveunbilledinvoice';
    bool respVal = false;
    var selInvs = json.encode(selectedInvoices.map((selinv) => selinv.toJson()).toList());
    //print('Unbilled invs: ' + selInvs);
    var future = client.post(url,body:selInvs,headers: {"Accept": "application/json", "content-type": "application/json" });
    final response = await future;
    //print('Unbilled invs: ' + response.body);
    if(response.statusCode == 200){
      var isInvoicesSuccess = json.decode(response.body);
      respVal = isInvoicesSuccess ? true : false;
      return respVal;
    }else  throw Exception('Failed to Approve Invoice List');
  }

}



 