import 'dart:async';
import 'package:http/http.dart' show Client;
import 'package:split/Bloc/CommonVariables.dart';
import 'dart:convert';
import 'package:split/src/Models/branchmodel.dart';

class  BranchApiProvider {
   Client client =new Client();

  Future<List<BranchModel>> branchList() async{
    List<BranchModel> brnList;
    String root = StaticsVar.root;
    String url = '$root/api/master/branch/branchlist';
    var future = client.get(url,headers:{"Accept": "application/json","content-type": "application/json"});

    final response = await future;
    if(response.statusCode==200){
      List showUom = json.decode(response.body);
      brnList = showUom.map((uom) => BranchModel.fromJson(uom)).toList();
      return brnList;
    }else {throw Exception('Failed to show BranhList');}
  }

}



