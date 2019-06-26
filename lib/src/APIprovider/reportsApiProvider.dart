import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:split/src/Models/reportModel.dart';

class ReportsAPI
{
  Client client = Client();
  
  Future<String> invoiceReport(ReportOptions repOpts) async
  {
    var shoQt = "";
    String url = 'http://posapi.logiconglobal.com/api/operation/salesorder/printreport';
    var bodyObj = json.encode(repOpts.toJSon());
    print(bodyObj);
    var future = client.post(url, body: bodyObj, headers:{"Accept": "application/json","content-type": "application/json"});
    final response = await future;
    if(response.statusCode==200){
       shoQt = json.decode(response.body);
    } else {throw Exception('Failed to fetch Invoice (${repOpts.documentNo}) Report');}

    return shoQt.toString();
  }

}