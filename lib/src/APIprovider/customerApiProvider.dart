import 'dart:async';
import 'package:http/http.dart' show Client;
import 'package:split/Bloc/CommonVariables.dart';
import 'package:split/src/Models/customermodel.dart';
import 'dart:convert';

class CustomerApiProvider{

  Client client =  new Client();

  Future<List<Customer>> customerList() async{
    List<Customer> cusList;
    String root = StaticsVar.root;
    String url = '$root/api/master/customer/customerlist';
    var future = client.get(url,headers:{"Accept": "application/json","content-type": "application/json"});

    final response = await future;
    if(response.statusCode==200){
      List showCustomer = json.decode(response.body);
      cusList = showCustomer.map((customer) => Customer.fromJson(customer)).toList();

      //return showSupplier;
      return cusList;
    }else {throw Exception('Failed to show SupplierList');}
  }



  //  Saving Customer data
    Future<bool> saveCustomerList(Customer saveCustDtls) async {
      String root = 'http://posapi.logiconglobal.com';
      String url = '$root/api/master/customer/save';
      bool respVal = false;
      var custListDts = json.encode(saveCustDtls.toJson());
      print(custListDts);
      var future = client.post(url,body:custListDts,headers: {"Accept": "application/json", "content-type": "application/json"});
      final response = await future;
      
      if(response.statusCode == 200){
        var isCustomerDtsSuccess = json.decode(response.body);
        respVal = isCustomerDtsSuccess ? true : false;
        return respVal;
        }else throw Exception('Failed to Save Customer List');

  }

  // // Deleting data
  Future<bool> delCustList(String customerCode) async 
  {
    String code = customerCode.trim();
    String root = StaticsVar.root;
    String url = '$root/api/master/customer/delete/$code';
    bool respVal = true;
    var future = client.get(url,headers: {"Accept": "application/json", "content-type": "application/json" });
    final response = await future;
    print(response.body);
    if(response.statusCode == 200){
      var isCustomerDtls = json.decode(response.body);
      respVal = isCustomerDtls ? true : false;
      return respVal;
    }else throw Exception('Item not Deleted');
  }


  
  // get Customer 

  Future<Customer> getCustomer(String cusCode) async
    {
      Customer cusMaster;
      String root = StaticsVar.root;
      String url = '$root/api/master/customer/getcustomer/$cusCode';
      var future = client.get(url,headers:{"Accept": "application/json","content-type": "application/json"});
      final response = await future;
      if(response.statusCode==200){
        var showCustomer = json.decode(response.body);
        cusMaster =  new Customer.fromJson(showCustomer);
        return cusMaster;
      }else {throw Exception('Failed to Edit');}
  }

}


// Autocomplete text field
// void getUsers() async {
//     try {
//       final response =
//           await http.get("http://posapi.logiconglobal.com/api/master/customer/customerlist");
//       if (response.statusCode == 200) {
//         customers = loadUsers(response.body);
//         print('Users: ${customers.length}');
//         setState(() {
//           loading = false;
//         });
//       } else {
//         print("Error getting users.");
//       }
//     } catch (e) {
//       print("Error getting users.");
//     }
//   }