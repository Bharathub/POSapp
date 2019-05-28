import 'dart:async';

import 'package:http/http.dart' show Client;
import 'package:split/Bloc/CommonVariables.dart';
import 'dart:convert';
import 'package:split/src/Models/suppliermodel.dart';

class SupplierApiProvider{

  Client client =  new Client();

  Future<List<Supplier>> supplierList() async{
    List<Supplier> supList;
    String root = StaticsVar.root;
    String url = '$root/api/master/supplier/supplierlist';
    var future = client.get(url,headers:{"Accept": "application/json","content-type": "application/json"});

    final response = await future;
    if(response.statusCode==200){
      List showSupplier = json.decode(response.body);
      supList = showSupplier.map((suppllier) => Supplier.fromJson(suppllier)).toList();

      //return showSupplier;
      return supList;
    }else {throw Exception('Failed to show SupplierList');}
  }



  //Country Dropdown Data

  Future<List<CountryList>> countrylist() async{
    List<CountryList>countrylist;
    String root = StaticsVar.root;
    String url = '$root/api/master/country/countrylist';
    var future = client.get(url,headers:{"Accept": "application/json","content-type": "application/json"});
    final response = await future;
    if(response.statusCode==200){
      List showContries = json.decode(response.body);
      countrylist = showContries.map((contries) => CountryList.fromJson(contries)).toList();
      
      //return showSupplier;
      return countrylist;
    }else {throw Exception('Failed to show countryList');}
  }

   //  Saving Supplier data
    Future<bool> saveSupplierList(Supplier savsuppDtls) async {
      String root = 'http://posapi.logiconglobal.com';
      String url = '$root/api/master/supplier/save';
      bool respVal = false;
      var suppListDts = json.encode(savsuppDtls.toJson());
      print(suppListDts);
      var future = client.post(url,body:suppListDts,headers: {"Accept": "application/json", "content-type": "application/json" });
      final response = await future;
      print(response.body);
      if(response.statusCode == 200){
        var issuppDtsSuccess = json.decode(response.body);
        respVal = issuppDtsSuccess ? true : false;
        return respVal;
      }else throw Exception('Failed to Save Supplier List');

  }
  // // Deleting data
  Future<bool> delSupplierList(String registrationNo) async 
  {
    String root = StaticsVar.root;
    String url = '$root/api/master/supplier/delete/$registrationNo';
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


  Future<Supplier> getSupplier(String supCode) async
  {
    Supplier supMaster;
    String root = StaticsVar.root;
    String url = '$root/api/master/supplier/getsupplier/$supCode';
    var future = client.get(url,headers:{"Accept": "application/json","content-type": "application/json"});
    final response = await future;
    if(response.statusCode==200){
       var shoQt = json.decode(response.body);
      supMaster =  new Supplier.fromJson(shoQt);
      return supMaster;
    }else {throw Exception('Failed to List Quotation');}
  }

}


