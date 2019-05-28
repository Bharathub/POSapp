
import 'dart:async';
import 'package:http/http.dart' show Client;
import 'package:split/Bloc/CommonVariables.dart';
import 'dart:convert';
import 'package:split/src/Models/lookupModel.dart';



class WareHouseLocApi
{
    Client client =  new Client();
    Future<List<Lookup>> wareHousLocList() async{
    List<Lookup> wereHosList;
    String root = StaticsVar.root;
    String url = '$root/api/lookups/warehouselocationlist';
    print('URL'+ url);
    var future = client.get(url,headers:{"Accept": "application/json","content-type": "application/json"});
    final response = await future;
     print(response.body);
    if(response.statusCode==200){
    List showWrHsLoc = json.decode(response.body);
   
    wereHosList = showWrHsLoc.map((wrhsLoc)=>Lookup.fromJson(wrhsLoc)).toList();
    return wereHosList;
    }else {throw Exception('Failed to show WareHouseLocation');}
  }

}
