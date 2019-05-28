import 'package:flutter/material.dart';
import 'package:split/Bloc/Bloc.dart';
import 'package:split/Bloc/provider.dart';
import 'package:split/Masterdata/masterdatatab.dart';
import 'package:split/Masterdata/uompopup.dart';
import 'package:split/src/APIprovider/lookUpApiProvider.dart';
import 'package:split/src/Models/loginmodel.dart';
// import 'package:split/Bloc/providers.dart';

// void main() => runApp(new UomList()); //one-line function

class UomList extends StatefulWidget {

  final  Users loginInfo;
  UomList({Key key, @required this.loginInfo}) :super(key: key);

  @override
  _ListCardsState createState() => _ListCardsState();
}

class _ListCardsState extends State<UomList> {
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of(context);

    return Scaffold(
            appBar: AppBar(
                backgroundColor: Color(0xffd35400),
                title: Text('UOM'),
                leading: IconButton(
                icon: Icon(Icons.arrow_back),
                  color: Colors.white,
                  onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context) => MasterDataTab(loginInfo:widget.loginInfo)));},
                ),
            ),
            body: Container(
                  child: listTile(bloc),),
            floatingActionButton: FloatingActionButton(heroTag: 'btn1',
              backgroundColor:Color(0xffd35400),  child: Icon(Icons.add),  
              onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context)=> UOMpopup(loginInfo:widget.loginInfo,lkupCode: "",desc: ""))); }
            ),
    ); 
}

  Widget listTile(Bloc bloc) 
  {
  LookUpApiProvider uomApi = new LookUpApiProvider();
   return FutureBuilder(
            future: uomApi.uomList(),
            builder: (context, ssUom) {
            if (ssUom.hasData) {
            return ListView.builder(
            itemCount: ssUom.data.length,
            itemBuilder: (context, index) 
            {
            return Container(height: 80.0,padding: EdgeInsets.only(top:15.0),
            child: Card( 
            margin: EdgeInsets.only(right: 5.0, left: 5.0),
            elevation: 10.0,
            child: ListTile(
            title: Row(children: <Widget>[
              Expanded(flex: 5,child: Text('Code:'),),
              Expanded(flex:5,child: Text(ssUom.data[index].lookupCode))
              ],),
              onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) =>
                UOMpopup(loginInfo: widget.loginInfo,lkupCode: ssUom.data[index].lookupCode.trim(),desc:ssUom.data[index].description)));},
            trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
                    LookUpApiProvider lukup = new LookUpApiProvider();
                    await (lukup.delLookup(ssUom.data[index].lookupCode)).then((onValue)
                    {
                      if(onValue == true){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> UomList(loginInfo: widget.loginInfo,)));
                      }else {return  Exception('Loading Failed');}
                    }
                    );
                  },),
            subtitle: Container(
            child: Align(
            alignment: Alignment.topLeft,
            child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                Expanded(flex: 5,child:  Text('Description'),),
                  // SizedBox(width: 20.0,),
                  Expanded(flex: 5,child:   Text(ssUom.data[index].description))

                  // SizedBox(width: 10,),
                  // Expanded(flex: 6,child:ssUom.data[index].description)
                ],
              )
              // Text('Description' +ssUom.data[index].description),
                    ],
                  )
                ),
            )
          ),
        )
      );
    }
              );
        } else {
          return Center(child: CircularProgressIndicator(),);}
      });
  }
}
