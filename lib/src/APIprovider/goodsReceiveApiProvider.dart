import 'dart:async';

import 'package:http/http.dart' show Client;
import 'package:http/http.dart';
import 'package:split/Bloc/CommonVariables.dart';
import 'package:split/src/Models/goodsReceiveModel.dart';
import 'dart:convert';

class GoodsReceiverApi
{

  Client client =  new Client();
  String root = StaticsVar.root;
  Future<List<GoodsReceiverHD>> goodsReceiveList() async
  {
    List<GoodsReceiverHD> grList;
    String root = StaticsVar.root;
    String url = '$root/api/operation/goodsreceive/list/160';
    var future = client.get(url,headers:{"Accept": "application/json","content-type": "application/json"});
    final response = await future;

    if(response.statusCode==200)
    {
      List showGoodsReceive = json.decode(response.body);
      grList = showGoodsReceive.map((gr) => GoodsReceiverHD.fromJson(gr)).toList();
      return grList;
    }else {throw Exception('Failed to show Goods Receive List');}
  }


    // Client client =  new Client();
    // String root = StaticsVar.root;

  Future<GoodsReceiverHD> getPOforGoodsReceiver(String pONum) async{
    GoodsReceiverHD gdRecvHD;
    String root = StaticsVar.root;
  
    String url = '$root/api/operation/goodsreceive/seachgrbypo/$pONum';
    var future = client.get(url,headers:{"Accept": "application/json","content-type": "application/json"});

    final response = await future;
    if(response.statusCode==200){
      var grVal = json.decode(response.body);
      gdRecvHD = GoodsReceiverHD.fromJson(grVal);
      return gdRecvHD;
    } else {throw Exception('Failed to Retrive Goods Receiver');}
  }

   //  Saving Goods data
  Future<bool> saveGoodsReceiver(GoodsReceiverHD grHD) async {
    String url = '$root/api/operation/goodsreceive/save';
    bool respVal = false;
    var gsListDts = json.encode(grHD.toJson());
    print(gsListDts);
    var future = client.post(url,body:gsListDts,headers: {"Accept": "application/json", "content-type": "application/json" });
    final response = await future;
    print(response.body);
    if(response.statusCode == 200){
      var isGoodRcDtsSuccess = json.decode(response.body);
      respVal = isGoodRcDtsSuccess ? true : false;
      return respVal;
    }else  throw Exception('Failed to Save Goods Receive List');

  }





 }
