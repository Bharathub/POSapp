import 'package:flutter/material.dart';
import 'package:split/Bloc/Bloc.dart';
import 'package:split/Bloc/CommonVariables.dart';
import 'package:split/Bloc/provider.dart';
import 'package:split/Quotation/standardQuotationTarrif.dart';
import 'package:split/src/APIprovider/quotationApiProvider.dart';
import 'package:split/src/Models/loginmodel.dart';
import 'package:intl/intl.dart';

class Standardquotation2 extends StatefulWidget
{
  final Users loginInfo;
  Standardquotation2({Key key, @required this.loginInfo}) :super(key: key);
  @override
  _Standardquotation2State createState() => _Standardquotation2State();
}

class _Standardquotation2State extends State<Standardquotation2>
{

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of(context);
    
    return Scaffold(
      body: Container(child: listTile(bloc, widget.loginInfo)),
      floatingActionButton: FloatingActionButton(
      backgroundColor:  Color(0xffd35400),
      child: Icon(Icons.add),
      onPressed:(){Navigator.push(context, MaterialPageRoute(builder: (context)=>StandardTariffQuotation(loginInfo: widget.loginInfo,)));
        },
      ),
      );
  }
}

  Widget listTile(Bloc bloc, Users loginInfo) 
  {
    QuotationApiProvider qtApi = new QuotationApiProvider();
    return FutureBuilder(
          future: qtApi.quotationList(StaticsVar.branchID),
          builder: (context, ssQut) 
          {
            if (ssQut.hasData) 
            { return ListView.builder(
                itemCount:1,
                itemBuilder: (context, index) 
                {
                  //print(ssQut.data[index].quotationNo);
                  return Container(height: 100.0, padding: EdgeInsets.only(top:15.0),
                    child: Card( 
                      margin: EdgeInsets.only(right: 5.0, left: 5.0),
                      elevation: 10.0,
                      child: ListTile(
                        title: Row(
                    children: <Widget>[
              // FlatButton(
                // child:
                Expanded(flex: 4,child:Text('Quotation No:' ),),
                Expanded(flex: 6,child:Text(ssQut.data.quotationNo.toString()),)
                
              ],
            ),
                        //  Text('Quotation No: ' + ssQut.data.quotationNo.toString()),
                        onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => 
                                  StandardTariffQuotation(loginInfo: loginInfo, quotNo: ssQut.data.quotationNo)));},
                        subtitle: Container(
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Column(children: <Widget>[
                          //             Row( children: <Widget>[
                          // Expanded(flex: 4,child: Text('Customer Name:')),
                          // // SizedBox(width: 10.0,),
                          // Expanded(flex: 6,child: Text(ssQut.data[index].customerName)),
                          //      ],),
                                Row(children: <Widget>[
                                  Expanded(flex: 4,child: Text('Effective Date :')),
                                  // SizedBox(width: 10.0,),
                                  Expanded(flex: 6,child: Text(DateFormat('dd/MM/yyyy').format(ssQut.data.effectiveDate).toString()),),
                                ],),
                                Row(children: <Widget>[
                                  Expanded(flex: 4,child: Text('Expiry Date: ')),
                                  // SizedBox(width: 10.0,),
                                  Expanded(flex: 6,child: Text(DateFormat('dd/MM/yyyy').format(ssQut.data.expiryDate).toString()),),
                                ],),
                            ],)
                          ),
                        )
                      ),
                    )
                  );
                }
            );
          } else { return Center(child: CircularProgressIndicator(),);}
      });
}

