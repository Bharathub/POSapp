
import 'dart:async';
import 'package:http/http.dart' show Client;
import 'package:split/Bloc/CommonVariables.dart';
import 'dart:convert';

import 'package:split/src/Models/paymentModel.dart';


class PaymentApiProvider
{

  Client client =  new Client();
  Future<List<PaymentTypes>> paymentList() async{
    List<PaymentTypes> payList;
    String root = StaticsVar.root;
    String url = '$root/api/lookups/paymentTypelist';
    var future = client.get(url,headers:{"Accept": "application/json","content-type": "application/json"});
    final response = await future;
    if(response.statusCode==200){
      List showPayment = json.decode(response.body);
      payList = showPayment.map((payls) => PaymentTypes.fromJson(payls)).toList();
      return payList;
    }else {throw Exception('Failed to show PaymentList');}
  }

}
