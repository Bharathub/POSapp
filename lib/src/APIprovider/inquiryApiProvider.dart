 

import 'dart:async';

import 'package:http/http.dart' show Client;
import 'package:split/Bloc/CommonVariables.dart';
import 'dart:convert';

import 'package:split/src/Models/inquiryModel.dart';


class InquiryApi {
    Client client =  new Client();

  //    Future<List<InquiryModel>> inquiryLists() async{
  //   List<InquiryModel> inqList;
  //   String root = StaticsVar.root;
  //   String url = '$root/api/inquiry/inquiry/stockinquiry';
  //   var future = client.post(url,headers:{"Accept": "application/json","content-type": "application/json"});

  //   final response = await future;
  //   if(response.statusCode==200){
  //     List showInquiry = json.decode(response.body);
  //     inqList = showInquiry.map((inquiry) => InquiryModel.fromJson(inquiry)).toList();
  //     return inqList;
  //   }else {throw Exception('Failed to show InquiryList');}
  // }




  

   //  Saving Inquiry data
      Future<List> inquiryList(InquiryModel showSerDtls) async {
       String root = StaticsVar.root;
       String url = '$root/api/inquiry/inquiry/stockinquiry';
      // bool respVal = false;
      List respVal;
      var inqListDts = json.encode(showSerDtls.toJson());
      print(inqListDts);
      var future = client.post(url,body:inqListDts,headers: {"Accept": "application/json", "content-type": "application/json" });
      final response = await future;
      print(response.body);
      if(response.statusCode == 200){
        List isInqDtsSuccess = json.decode(response.body);
        // respVal = isInqDtsSuccess ? true : false;

        respVal = isInqDtsSuccess.map((inquiry) =>InquiryModel.fromJson(inquiry)).toList();
        return respVal;
      }else  throw Exception('Failed to Save LookUp List');

  }







}

