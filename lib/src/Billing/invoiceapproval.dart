import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:split/src/Billing/billingnew.dart';
import 'package:split/Bloc/Bloc.dart';
import 'package:split/Bloc/provider.dart';
import 'package:split/src/Models/customermodel.dart';
import 'package:split/src/Models/invoiceModel.dart';
import 'package:split/src/Models/loginmodel.dart';
import 'package:split/src/Models/paymentModel.dart';

class InvoiceApproval extends StatefulWidget {
  final Users loginInfo;
  InvoiceApproval({Key key, @required this.loginInfo}) : super(key: key);
  @override
  _InvoiceApprovalState createState() => _InvoiceApprovalState();
}

class _InvoiceApprovalState extends State<InvoiceApproval> 
{
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of(context);
    bloc.initiateCustomers();
    bloc.initiatePaymentType();
    // SrchUnApprdInvoice unApprovedInvoices;
    return MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("Invoice Approval"),
          backgroundColor: Color(0xffd35400),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => BillingNew(loginInfo: widget.loginInfo,)
              )
            );
          },
        ),
      ),
        body: SingleChildScrollView(
          child: Center(
              
              child:Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
              Container(width: 300.0,height:220.0,child: Card(
                margin: EdgeInsets.only(left:10.0,right: 10.0),
                elevation: 10,
                child:Column(children:<Widget>[
                  Expanded(flex:5, child: Container(height:40.0, child: FittedBox(child:  inCustomer(bloc),))),
                  Expanded(flex:5, child: Container(height:40.0, child: FittedBox(child:  inDateFld(bloc),))),
                  Expanded(flex:5, child: Container(height:40.0, child: FittedBox(child:  inDateToFld(bloc),))),

              //  Wrap(
              //    spacing: 10.0,
              //    children: <Widget>[
              //   Expanded(flex:5, child: Container(height:40.0, child: FittedBox(child:  inDateFld(bloc),))),
              //     Expanded(flex:5, child: Container(height:40.0, child: FittedBox(child:  inDateToFld(bloc),)))
              //    ],
              //  ),
                 Expanded(flex:5, child: Container(height:40.0, child: FittedBox(child:  invCurrencyType(bloc),))),
                searchBtn(bloc),
                 ]),
               ) ),
                Divider(),
                Container( height: 300.0,child: listTile(bloc))
              ],
             ) 
            
            ),
          ),
          bottomNavigationBar:  apprvBtn(context),
      ),
    );
  }
}

  searchBtn(Bloc bloc) 
  {
    
    return  RaisedButton(
      color: Color(0xffd35400),
      child: Text('Search',style: TextStyle(color: Colors.white),),
      onPressed: (){
        // bloc.getPODetilsforGoodsReceive();
        bloc.getSr4unApprvdInvoices();
      },
    );
  }


  inCustomer(Bloc bloc) 
  {
    bloc.initiateCustomers();
    // CustomerApiProvider wlApi = new CustomerApiProvider();
    return StreamBuilder<String>(
        stream: bloc.invAprCustomer,
        builder: (context, snapshot)
        {
          return StreamBuilder(
            stream:bloc.initCustomers,
            builder: (context, ssWLDD) {
            if (ssWLDD.hasData) {
            return SizedBox(
              width: 300,
              child: InputDecorator(
              decoration: InputDecoration(labelText:'Customer'),
              child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
              isDense: true,
              items: ssWLDD.data.map<DropdownMenuItem<String>>(
              (Customer dropDownStringitem)
              {
              return DropdownMenuItem<String>(
                value:dropDownStringitem.customerName.toString(),
                child: Text( dropDownStringitem.customerName,));
              },).toList(),
              value: snapshot.data,
              onChanged: bloc.invAprCustomerChanged,
              isExpanded: true,
              elevation: 10,
                      )
                    )
                  )
                );
            } else {return CircularProgressIndicator();
            }
          }
        );
      }
    );
  }

  inDateFld(Bloc bloc)
  {
    final formats = { InputType.date: DateFormat('yyyy-MM-dd'),};
    InputType inputType = InputType.date;
    bool editable = true;
    return StreamBuilder<DateTime>(
        stream: bloc.invApDateFrom,
        builder: (context, snapshot) => 
        SizedBox(
          width: 300,
          child: new DateTimePickerFormField(
          inputType: inputType,
          format: formats[inputType],
          editable: editable,
          decoration: const InputDecoration(labelText: 'DATE FORM', hasFloatingPlaceholder: true),
          onChanged: bloc.invApDateChanged),
            )
          );
  }

  inDateToFld(Bloc bloc)
  {
    final formats = {InputType.date: DateFormat('yyyy-MM-dd'),};
    InputType inputType = InputType.date;
    bool editable = true;
    return StreamBuilder<DateTime>(
        stream: bloc.invApDateTo,
        builder: (context, snapshot) => 
        SizedBox(
          width: 300,
          child: new DateTimePickerFormField(
          inputType: inputType,
          format: formats[inputType],
          editable: editable,
          decoration: const InputDecoration(labelText: 'DATE TO', hasFloatingPlaceholder: true),
          onChanged: bloc.invApDateToChanged),
            )
          );
  }


  

  invCurrencyType(Bloc bloc)
  {
   
    bloc.initiatePaymentType();
      return StreamBuilder<String>(
        stream: bloc.invApprvlPayment,
        builder: (context,snapshot)
        {
          return StreamBuilder(
          stream: bloc.initPaymentType,
          builder: (context,ssWLDD)
          { 
            if (ssWLDD.hasData)
            {
              return SizedBox(
                width: 300,
                child: InputDecorator(
                  decoration: InputDecoration(labelText: 'Payment Type'),
         
                child:  DropdownButtonHideUnderline(
                child:  DropdownButton<String>(
                  isDense: true,
                  items: ssWLDD.data
                  .map<DropdownMenuItem<String>>((PaymentTypes dropDownStringitem)
                  { return DropdownMenuItem<String>(
                    value: dropDownStringitem.lookupCode.toString(), 
                    child: Text(dropDownStringitem.description));},
                  ).toList(),
                value: snapshot.data,
                onChanged: bloc.invApprvlPaymentChenged,
                // isExpanded: true,
                elevation: 10,
                ) ) ) );
            } else { return CircularProgressIndicator(); }
        });
      });
  }

  apprvBtn(BuildContext context,) 
  {
    // InvoiceApi invApi = new InvoiceApi();
    return  RaisedButton(
      color: Color(0xffd35400),
      child: Text('Approve',style: TextStyle(color: Colors.white),),
      onPressed: (){
      // invApi.approveInvoices();
      },
    );
  }
  
  Widget listTile(Bloc bloc, )
  {
    //ProductApiProvider pProductDtApi = new ProductApiProvider();
    return StreamBuilder(
      stream: bloc. unApprvdInvoices,
      builder: (context, ssUnAppInv) {
      List unInvData = ssUnAppInv.hasData ? ssUnAppInv.data : <UnApprovedInvoice>[];
      print('inv length : ' + unInvData.length.toString());
        return ListView.builder(
            itemCount: unInvData.length,
            itemBuilder: (context, index)
            { return Container(height: 120.0,padding: EdgeInsets.only(top:15.0),
                child: Card(
                  margin: EdgeInsets.only(right: 5.0, left: 5.0),
                  elevation: 10.0,
                  child: ListTile(
                    title:  Row(
                            children: <Widget>[
                              Expanded(flex: 5,child:Text('Invoice No.:'),),
                              Expanded(flex: 5,child: Text(unInvData[index].invoiceNo),),                            
                            ],
                          ),
                    // trailing: IconButton( icon: Icon(Icons.delete), onPressed: () { bloc.deletePODetail(unInvData[index].productCode); StaticsVar.showAlert(context, "Product Deleted"); }),
                      subtitle: Container(
                      child: Align(
                      alignment: Alignment.centerLeft,
                        child: Column(
                        children: <Widget>[
                        Row(
                            children: <Widget>[
                              Expanded(flex: 5,child:Text('Customer:'),),
                              Expanded(flex: 5,child: Text(unInvData[index].customerName),),                            
                            ],
                          ),
                          // Row(
                          //   children: <Widget>[
                          //     Expanded(flex: 5,child:Text('invoiceDate:'),),
                          //     Expanded(flex: 5,child: Text(DateFormat('dd/MM/yyyy').format(unInvData[index].invoiceDate),) ),                            
                          //     // Expanded(flex: 5,child: Text(poData[index].productCode),)
                          //   ],
                          // ),
                              Row(
                            children: <Widget>[
                              Expanded(flex: 5,child:Text('invoiceType:'),),
                              Expanded(flex: 5,child: Text(unInvData[index].invoiceType),),                            
                              // Expanded(flex: 5,child: Text(poData[index].productCode),)
                            ],
                          ),

                        ],
                      )),
                    )),
                ));
          });
      //} else { return Center(child:CircularProgressIndicator());}
    });
  }

