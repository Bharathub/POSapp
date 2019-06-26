import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//import 'package:intl/intl.dart';
import 'package:split/Bloc/Bloc.dart';
import 'package:split/Bloc/CommonVariables.dart';
import 'package:split/Bloc/provider.dart';
import 'package:split/src/APIprovider/invoiceApiProvider.dart';
import 'package:split/src/APIprovider/reportsApiProvider.dart';
//import 'package:split/Bloc/CommonVariables.dart';
import 'package:split/src/Billing/billingnew.dart';
import 'package:split/src/Billing/customerInvoice.dart';
import 'package:split/src/Models/invoiceModel.dart';
import 'package:split/src/Models/loginmodel.dart';
import 'package:split/src/Models/reportModel.dart';
import 'package:url_launcher/url_launcher.dart';


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
    var bloc = Provider.of(context);
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
    body: 
    // SingleChildScrollView(
    //   child:Column(children: <Widget>[
        Container( child: listTile(bloc,widget.loginInfo))

      // ],) 
      //   )
  );
  }
}

  Widget listTile(Bloc bloc,Users loginInfo)
  {
    InvoiceApi inAPI = new InvoiceApi();
    return FutureBuilder(
      future: inAPI.getInvoiceList(),
      builder: (context, ssInvoices) {
      List invoices = ssInvoices.hasData ? ssInvoices.data : <InvoiceHeader>[];
        return ListView.builder(
            itemCount: invoices.length,
            itemBuilder: (context, index) 
            { return Container(height: 125.0,padding: EdgeInsets.only(top:5.0),
                child: Card(
                  margin: EdgeInsets.only(right: 5.0, left: 5.0),
                  elevation: 5.0,
                  child: ListTile(
                    title: Row(children: <Widget>[
                      Expanded(flex: 5,child: Text('Inv. No.:')),
                      Expanded(flex: 5,child: Text(invoices[index].invoiceNo)),
                      ],
                    ),  
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => 
                        CustomerInv(loginInfo: loginInfo,invNo: invoices[index].invoiceNo.trim())));},                   
                    subtitle: Container(
                      child: Align(
                      alignment: Alignment.centerLeft,
                        child: Column(
                          children: <Widget>[
                          Row(
                            children: <Widget>[
                            Expanded(flex: 5,child: Text('Order No.:')),
                            Expanded(flex: 5,child: Text(invoices[index].orderNo)),
                            ],),
                          Row(
                            children: <Widget>[
                            Expanded(flex: 5,child: Text('Customer Name:')),
                            Expanded(flex: 5,child: Text(invoices[index].customerName)),
                          ],),
                          Row(
                            children: <Widget>[
                            Expanded(flex: 5,child: Text('Invoice Date:')),
                            Expanded(flex: 5,child: Text(DateFormat('dd/MM/yyyy').format(invoices[index].invoiceDate).toString())),
                          ],),
                          Row(
                            children: <Widget>[
                            Expanded(flex: 5,child: Text('Invoice Type:')),
                            Expanded(flex: 5,child: Text(invoices[index].invoiceType)),
                          ],),
                          Row(
                            children: <Widget>[
                            Expanded(flex: 5,child: Text('Invoice Amt:')),
                            Expanded(flex: 4,child: Text(invoices[index].invoiceAmount.toString())),
                            //Expanded(flex: 1,child: _displayPDFPic(bloc),),
                            Expanded(flex: 1,child: GestureDetector(
                                child: Container(width: 5.0, height: 25.0,
                                  decoration: new BoxDecoration(
                                    image: new DecorationImage( image: new AssetImage('lib/images/pdf.png'),fit: BoxFit.fill,),),),
                                onTap: () async {
                                  ReportsAPI invRepAPI = new ReportsAPI();
                                  ReportOptions rptOpts = new ReportOptions(documentNo: invoices[index].invoiceNo, 
                                                                branchID: StaticsVar.branchID, reportName: "Invoice", 
                                                                dateFrom: DateTime.now(), dateTo: DateTime.now());
                                  print("inv no: " + invoices[index].invoiceNo );                                                                
                                  await (invRepAPI.invoiceReport(rptOpts).then((onValue) async
                                    {
                                      if(onValue != ""){
                                        print("URL: " + onValue);
                                        await launch(onValue, forceWebView: false);
                                        //StaticsVar.downloadPDF(onValue); //, invoices[index].invoiceNo.trim() + ".pdf");
                                      } else {return  Exception('Report Loading Failed');}
                                    }
                                  ));
                                })), 
                          ],),
                        ])
                    ))
                  ),
              )); 
          });
      //} else { return Center(child:CircularProgressIndicator());}
    });
  }

  // Widget _displayPDFPic(Bloc bloc)
  // {
  //   return GestureDetector(
  //     onTap: () { },
  //     child: Container(width: 5.0, height: 25.0,
  //       decoration: new BoxDecoration(
  //         image: new DecorationImage( image: new AssetImage('lib/images/pdf.png'),fit: BoxFit.fill,),),),
  //   );
  // }
