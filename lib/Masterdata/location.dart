import 'package:flutter/material.dart';
import 'package:split/Bloc/Bloc.dart';
import 'package:split/Bloc/provider.dart';
import 'package:split/Masterdata/locationpopup.dart';
import 'package:split/Masterdata/masterdatatab.dart';
import 'package:split/src/APIprovider/lookUpApiProvider.dart';
import 'package:split/src/APIprovider/werehouseLocApiProvider.dart';
import 'package:split/src/Models/loginmodel.dart';

class WareHouseLocation extends StatefulWidget {


  final Users loginInfo;
  WareHouseLocation({Key key, @required this.loginInfo}) :super(key: key);


  @override
  State<StatefulWidget> createState() {return _WareHouseLocationState();}
}

class _WareHouseLocationState extends State<WareHouseLocation> {
  
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of(context);  

    return new Scaffold(
            appBar: AppBar(
            backgroundColor: Color(0xffd35400),
            title: Text('Location'),
            leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MasterDataTab(loginInfo: widget.loginInfo,))
                 ); },
            ),
          ),
        body:
           Container(
              child:listTile(bloc,widget.loginInfo) ),


          floatingActionButton: FloatingActionButton(heroTag: 'btn5',
            backgroundColor:Color(0xffd35400),  child: Icon(Icons.add),  onPressed: (){
         Navigator.push(context, MaterialPageRoute(builder: (context)=> Locationpopup(loginInfo: widget.loginInfo,locCode: "",locDes: "",)));


        },  ),

      );
      
   
  }
}



Widget listTile(Bloc bloc, Users loginInfo) {
  WareHouseLocApi wrHsLocApi = new WareHouseLocApi();

  return FutureBuilder(
      future: wrHsLocApi.wareHousLocList(),
      builder: (context, ssWrHsLoc) {
        if (ssWrHsLoc.hasData) {
          return ListView.builder(
              itemCount: ssWrHsLoc.data.length,
              itemBuilder: (context, index) 
              {
                return Container(
                  height: 80.0,padding: EdgeInsets.only(top:15.0), 
                  child:Card(
                  margin: EdgeInsets.only(right: 5.0, left: 5.0),
                  elevation: 10.0,
                  child: ListTile(
                  title:Row(children: <Widget>[
                    Expanded(flex: 4,child:  Text('Code:'),),
                    Expanded(flex: 6,child: Text(ssWrHsLoc.data[index].lookupCode),)
                  ],
                ),
                 onTap: ()
                    {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    Locationpopup(loginInfo:loginInfo,locCode:  ssWrHsLoc.data[index].lookupCode.trim(),
                    locDes:ssWrHsLoc.data[index].description)));
                    },
                  trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async
                   {
                    LookUpApiProvider lukup = new LookUpApiProvider();
                    await (lukup.delLookup(ssWrHsLoc.data[index].lookupCode)).then((onValue)
                    {
                      if(onValue == true)
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> WareHouseLocation(loginInfo:loginInfo,)));
                      }else {return  Exception('Loading Failed');}
                    });
                  },
                ),
                subtitle: Container(
                child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(flex: 4,child: Text('Description:'),),
                      // SizedBox(width: 20,),
                      Expanded(flex: 6,child: Text( ssWrHsLoc.data[index].description.trim()))
                      ],),
                    ],
                  )
                ),
              )
            ),
           )
          );
              
           });
        } else {return Center(child: CircularProgressIndicator(),);}
      }
    );
}



            
