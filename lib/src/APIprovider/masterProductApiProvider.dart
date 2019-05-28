import 'dart:async';
import 'package:http/http.dart' show Client;
import 'package:http/http.dart';
import 'package:split/Bloc/CommonVariables.dart';
import 'dart:convert';
// import 'package:split/src/Models/Product.dart';
import 'package:split/src/Models/productModel.dart';

class ProductApiProvider
{
  Client client =  new Client();
  Future<List<Product>> productList() async{
    List<Product> productList;
    String root = StaticsVar.root;
    String url = '$root/api/master/product/productlist';
    var future = client.get(url,headers:{"Accept": "application/json","content-type": "application/json"});
    final response = await future;
    if(response.statusCode==200){
      List showUom = json.decode(response.body);
      productList = showUom.map((pro) => Product.fromJson(pro)).toList();
      return productList;
    }else {throw Exception('Failed to show Products');}
  }


  //  //  Saving Products data
    Future<bool> saveProductList(Product proSavDtls) async {
      String root = StaticsVar.root;
      String url = '$root/api/master/product/save';
      bool respVal = false;
      var productListDts = json.encode(proSavDtls.toJson());
      print(productListDts);
      var future = client.post(url,body:productListDts,headers: {"Accept": "application/json", "content-type": "application/json" });
      final response = await future;
      print(response.body);
      if(response.statusCode == 200){
      var isProDtsSuccess = json.decode(response.body);
      respVal = isProDtsSuccess ? true : false;
      return respVal;
      }else  throw Exception('Failed to Save Products List');

  }

  // // Deleting data
  Future<bool> delProducts(String description) async 
  {
    String root = StaticsVar.root;
    String url = '$root/api/master/product/delete/$description';
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


  // get Products 
  Future<Product> getProduct(String prodCode) async
  {
    Product poMaster;
    String root = StaticsVar.root;
    String url = '$root/api/master/product/getproduct/$prodCode';
    var future = client.get(url,headers:{"Accept": "application/json","content-type": "application/json"});
    final response = await future;
    if(response.statusCode==200){
       var showProd = json.decode(response.body);
      poMaster =  new Product.fromJson(showProd);
      return poMaster;
    }else {throw Exception('Failed to Edit');}
  }

  // // Returns particular objects

  //  Future<List<Lookup>> lookupObj() async{
  //   List<Lookup> uomList;
  //   String root = StaticsVar.root;
  //   String url = '$root/api/lookups/uomlist';
  //   var future = client.get(url,headers:{"Accept": "application/json","content-type": "application/json"});

  //   final response = await future;
  //   if(response.statusCode==200){
  //     List showUom = json.decode(response.body);
  //     uomList = showUom.map((uom) => Lookup.fromJson(uom)).toList();
  //     return uomList;
  //   }else {throw Exception('Failed to show UomList');}
  // }

 
 
  // // Product popup dropdown uom


  //  Future<List<Lookup>> uomddforPrdt(String category) async{
  //   List<Lookup> uomList;
  //   String root = StaticsVar.root;
  //   String url = '$root/api/lookups/uomlist/$category';
  //   var future = client.get(url,headers:{"Accept": "application/json","content-type": "application/json"});

  //   final response = await future;
  //   if(response.statusCode==200){
  //     List showUom = json.decode(response.body);
  //     uomList = showUom.map((uom) => Lookup.fromJson(uom)).toList();
  //     return uomList;
  //   }else {throw Exception('Failed to show UomList');}
  // }

  


  }


