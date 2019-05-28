
import 'package:flutter/material.dart';
import 'package:split/Bloc/Bloc.dart';
import 'package:split/Bloc/provider.dart';
import 'package:split/Masterdata/currencylistpopup.dart';
import 'package:split/Masterdata/masterdatatab.dart';
import 'package:split/src/APIprovider/currencyApiProvider.dart';
import 'package:split/src/Models/loginmodel.dart';

// void main() => runApp(new CurrencyList()); //one-line function

class CurrencyList extends StatefulWidget {

  final Users loginInfo;
  CurrencyList({Key key, @required this.loginInfo}) :super(key: key);


  @override
  _ListCardsState createState() => _ListCardsState();
}

class _ListCardsState extends State<CurrencyList> {
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of(context);
    
    return Scaffold(
            appBar: AppBar(
            backgroundColor: Color(0xffd35400),
            title: Text('Currency'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
             color: Colors.white,

              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MasterDataTab(loginInfo: widget.loginInfo,)));
              },
            ),
          ),

      body: Container(
        child: listTile(bloc),
  ),

            floatingActionButton: FloatingActionButton(heroTag: 'btn1',
            backgroundColor:Color(0xffd35400),  child: Icon(Icons.add),  onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> CurrencyPopup(loginInfo: widget.loginInfo,curCode: "",curDes: "",curDes1: "",)));
          },

      
       ),

    ); 
}

Widget listTile(Bloc bloc) {
  CurrencyApiProvider currencyApi = new CurrencyApiProvider();

  return FutureBuilder(
      future: currencyApi.currencyList(),
      builder: (context, ssCurrency) {
        if (ssCurrency.hasData) {
          return ListView.builder(
              itemCount: ssCurrency.data.length,
              itemBuilder: (context, index) {
                return Container(height: 80.0,padding: EdgeInsets.only(top:15.0), child:  Card(
                  
                  margin: EdgeInsets.only(right: 5.0, left: 5.0),
                  elevation: 10.0,
                  child: ListTile(
                      title:Row(children: <Widget>[
                      Expanded(flex: 4,child:Text('Code:'),),
                      Expanded(flex: 6,child: Text(ssCurrency.data[index].currencyCode))
                      ]),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>
                          CurrencyPopup(loginInfo: widget.loginInfo,curCode: ssCurrency.data[index].currencyCode.trim(),
                          curDes:ssCurrency.data[index].description,curDes1: ssCurrency.data[index].description1,)));
                      },
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: ()async {
                          CurrencyApiProvider currApi = new CurrencyApiProvider();

                          await (currApi.delCurrList(ssCurrency.data[index].currencyCode)).then((onValue)
                          {
                            if(onValue == true){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> CurrencyList(loginInfo: widget.loginInfo,)));
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
                            Row(
                              children: <Widget>[
                               Expanded(flex: 4,child: Text('Description:'),),
                                // SizedBox(width: 20,),
                               Expanded(flex: 6,child: Text( ssCurrency.data[index].description))

                              ],
                            )
                           

                            // Text('Description1:                           ' +
                            //     ssCurrency.data[index].description1),
                              ],
                            )),
                      )),
               ) );
              
              }
              );
        } else {
          return Center(child: CircularProgressIndicator(),); }
      });
}
}

