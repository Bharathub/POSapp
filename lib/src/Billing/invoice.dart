import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import 'package:split/Bloc/Bloc.dart';
import 'package:split/src/APIprovider/invoiceApiProvider.dart';
//import 'package:split/Bloc/CommonVariables.dart';
import 'package:split/src/Billing/billingnew.dart';
import 'package:split/src/Models/invoiceModel.dart';
import 'package:split/src/Models/loginmodel.dart';


class Invoice extends StatefulWidget {

  final Users loginInfo;
  Invoice({Key key, @required this.loginInfo}) :super(key: key);
  @override
  _InvoiceState createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  final bloc = new Bloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
      title: new Text("Invoice"),
      backgroundColor: Color(0xffd35400),         
      leading: IconButton(
      icon: Icon(Icons.arrow_back),
      color: Colors.white,
      onPressed: () {
          Navigator.push(context,
          MaterialPageRoute(builder: (context) => BillingNew(loginInfo: widget.loginInfo)));
        },
      ),
    ),
    body: SingleChildScrollView(
      child: Container(height: 450.0,child: listTile(bloc))
        )
  );
  }
}


  Widget listTile(Bloc bloc)
  {
    InvoiceApi inAPI = new InvoiceApi();
    return FutureBuilder(
      future: inAPI.getInvoiceList(),
      builder: (context, ssInvoices) {
      List invoices = ssInvoices.hasData ? ssInvoices.data : <InvoiceHeader>[];
        return ListView.builder(
            itemCount: invoices.length,
            itemBuilder: (context, index) 
            { return Container(height: 100.0,padding: EdgeInsets.only(top:15.0),
                child: Card(
                  margin: EdgeInsets.only(right: 5.0, left: 5.0),
                  elevation: 10.0,
                  child: ListTile(
                    title: Row(children: <Widget>[
                      Expanded(flex: 5,child: Text('Inv. No.:')),
                      Expanded(flex: 5,child: Text(invoices[index].invoiceNo)),
                      ],
                    ),                     
                    subtitle: Container(
                      child: Align(
                      alignment: Alignment.centerLeft,
                        child: Column(
                        children: <Widget>[
                        Row(
                          children: <Widget>[
                          Expanded(flex: 5,child: Text('OrderNo:')),
                          Expanded(flex: 5,child: Text(invoices[index].orderNo)),
                          ],)
                        ],
                      )),
                    )),
                )); 
          });
      //} else { return Center(child:CircularProgressIndicator());}
    });
  }

