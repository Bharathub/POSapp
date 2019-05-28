
import 'dart:async';

import 'package:http/http.dart' show Client;
import 'package:split/Bloc/CommonVariables.dart';
import 'dart:convert';

import 'package:split/src/Models/productcategorymodel.dart';


class ProductCateProvider{

  Client client =  new Client();

  Future<List<ProductCategorys>> productCatList() async{
    List<ProductCategorys> productCateList;
    String root = StaticsVar.root;
    String url = '$root/api/lookups/productcategory/productcategorylist';
  
    var future = client.get(url,headers:{"Accept": "application/json","content-type": "application/json"});
    final response = await future;
   
    if(response.statusCode==200){
      List showProductCat = json.decode(response.body);
    
      productCateList = showProductCat.map((pCatL) => ProductCategorys.fromJson(pCatL)).toList();
      return productCateList;
    }else {throw Exception('Failed to show PaymentList');}
  }

    //  Saving ProductCategoryList data
    Future<bool> saveProductList(ProductCategorys prolsdts) async {

      String root = 'http://posapi.logiconglobal.com';
      String url = '$root/api/lookups/productcategory/save';
      bool respVal = false;

      var proListDts = json.encode(prolsdts.toJson());
      print(proListDts);
      var future = client.post(url,body:proListDts,headers: {"Accept": "application/json", "content-type": "application/json" });
      final response = await future;
      print(response.body);
      if(response.statusCode == 200){
        var isPrDtsSuccess = json.decode(response.body);
        respVal = isPrDtsSuccess ? true : false;
        return respVal;
      }else throw Exception('Failed to Save Product Category List');

  }


  
  //   Deleting data
  Future<bool> proCatDelt(String proCatDel) async 
  {
    String root = StaticsVar.root;
    String url = '$root/api/lookups/productcategory/delete/$proCatDel';
    bool respVal = true;
    // var lookupDtls = json.encode(lookupDel.toJson());
    // print(lookupDtls);
    var future = client.get(url,headers: {"Accept": "application/json", "content-type": "application/json" });
    final response = await future;
    // print(response.body);
    if(response.statusCode == 200){
      var isProCatDtls = json.decode(response.body);
      respVal = isProCatDtls ? true : false;
      return respVal;
    }else throw Exception('Item not Deleted');
  }

}

