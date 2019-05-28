import 'package:flutter/material.dart';
import 'package:split/Bloc/Bloc.dart';
import 'package:split/Bloc/provider.dart';
import 'package:split/Masterdata/incotermpopup.dart';
import 'package:split/Masterdata/masterdatatab.dart';
import 'package:split/src/APIprovider/incotermApiProvider.dart';
import 'package:split/src/APIprovider/lookUpApiProvider.dart';
import 'package:split/src/Models/loginmodel.dart';

// void main() => runApp(new IncoTerms()); //one-line function

class IncoTerms extends StatefulWidget 
{
  final Users loginInfo;
  IncoTerms({Key key, @required this.loginInfo}) :super(key: key);
   @override
  _ListCardsState createState() => _ListCardsState();
}

class _ListCardsState extends State<IncoTerms> 
 {
   @override
   Widget build(BuildContext context)
   {
     var bloc = Provider.of(context);
          
     return Scaffold(
       appBar: AppBar(
          backgroundColor: Color(0xffd35400),
          title: Text('IncoTerms'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed:(){Navigator.push(context,MaterialPageRoute(builder: (context) => MasterDataTab(loginInfo: widget.loginInfo,)));},
            ),
          ),
          body: Container(child: listTile(bloc),),
          floatingActionButton: FloatingActionButton(
            heroTag: 'btn4',
            backgroundColor:Color(0xffd35400),
            child:Icon(Icons.add),onPressed: ()
            {Navigator.push(context, MaterialPageRoute(builder: (context)=> Incotermpopup(loginInfo: widget.loginInfo,incoCode: "",incoDes: "")));})
            ); 
  }

Widget listTile(Bloc bloc) 
{
  IncotermApiProvider incoApi = new IncotermApiProvider();
   return FutureBuilder(
     future: incoApi.incotermList(),
     builder: (context, ssinco){
       if (ssinco.hasData) {
          return ListView.builder(
              itemCount: ssinco.data.length,
              itemBuilder: (context, index) {
                return Container(height: 80.0,padding: EdgeInsets.only(top:15.0),
                child:Card(
                  margin: EdgeInsets.only(right: 5.0, left: 5.0),
                  elevation: 10.0,
                  child: ListTile(
                  title:Row(children: <Widget>[
                  Expanded(flex: 4,child:Text('Code:'),),
                  Expanded(flex: 6,child:Text( ssinco.data[index].lookupCode))
                  ],),
                   onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                        Incotermpopup(loginInfo: widget.loginInfo,incoCode:ssinco.data[index].lookupCode.trim(),
                        incoDes: ssinco.data[index].description)));
                      },
                  trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: ()async
                  {
                  LookUpApiProvider lukup = new LookUpApiProvider();
                  await (lukup.delLookup(ssinco.data[index].lookupCode)).then((onValue)
                    {
                      if(onValue == true){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> IncoTerms(loginInfo: widget.loginInfo,)));
                      }else {return  Exception('Loading Failed');}
                    }
                  );
                  },
                 ),
                 subtitle: Container(
                   child: Align(
                     alignment: Alignment.topLeft,
                     child: Column(
                       children: <Widget>[
                         Row(children: <Widget>[
                           Expanded(flex: 4,child: Text('Description:'),),
                           Expanded(flex: 6,child:  Text(ssinco.data[index].description))
                           ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(flex: 4,child:Text('Category:'),),
                              Expanded(flex: 6,child: Text(ssinco.data[index].category))
                              ],
                            ),
                          ],
                         )
                        ),
                      )
                     ),
                    )
                   );
                  }
                );
              } else {return Center(child: CircularProgressIndicator(),);}
            }
          );
        }
}
