import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:split/Bloc/CommonVariables.dart';
import 'package:split/src/APIprovider/invoiceApiProvider.dart';
import 'package:split/src/Billing/billingnew.dart';
import 'package:split/Bloc/Bloc.dart';
import 'package:split/Bloc/provider.dart';
import 'package:split/src/Models/customermodel.dart';
import 'package:split/src/Models/invoiceModel.dart';
import 'package:split/src/Models/loginmodel.dart';
//import 'package:split/src/Models/loginmodel.dart' as prefix0;
import 'package:split/src/Models/paymentModel.dart';

class InvoiceApproval extends StatefulWidget {
  final Users loginInfo;
  InvoiceApproval({Key key, @required this.loginInfo}) : super(key: key);
  @override
  _InvoiceApprovalState createState() => _InvoiceApprovalState();
}

class _InvoiceApprovalState extends State<InvoiceApproval> 
{
  
  bool isEditMode;
  @override
  Widget build(BuildContext context)
  {
    var bloc = Provider.of(context);
    bloc.initiateCustomers(true);
    bloc.initiatePaymentType(true);
    bloc.clearInvApprove();
    
    return MaterialApp(
      theme: ThemeData(
        buttonColor: Color(0xffd35400),),
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
              Container(
              padding: EdgeInsets.only(left:5.0, right:5, top:5), //EdgeInsets.only(top: 20.0), width: 400.0,height:220.0,
              child: Card(
                margin: EdgeInsets.only(left:5.0,right: 5.0),
                elevation: 5,
                child:Column(children:<Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                    //Expanded(flex:5, child: Container(height:50.0, child: FittedBox(child: inCustomer(bloc),))),
                    // Expanded(flex:5, child: inCustomer(bloc)),
                    inCustomer(bloc),
                    SizedBox(width: 8.0,), 
                    invPaymentType(bloc)
                    // Expanded(flex:5, child: invCurrencyType(bloc)),
                    //Expanded(flex:5, child: Container(height:50.0, child: FittedBox(child: invCurrencyType(bloc),))),
                  ],),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                    // Expanded(flex:5, child: invDateFrom(bloc,isEditMode)),
                    invDateFrom(bloc,isEditMode),
                    SizedBox(width: 8.0), 
                    inDateToFld(bloc,isEditMode)
                    // Expanded(flex:5, child: inDateToFld(bloc,isEditMode)),
                  ],),
                  SizedBox(height: 15.0,),               
                  searchBtn(bloc),
                ]),
               ) ),
                Divider(),
                Container( height: 400.0,child: listTile(bloc))
              ],
             )            
            ),
          ),
          bottomNavigationBar:  apprvBtn(context, bloc, widget.loginInfo),
      ),
    );
  }

    
  searchBtn(Bloc bloc) 
  {
    
    return  RaisedButton(
      // color: Color(0xffd35400),
      child: Text('Search',style: TextStyle(color: Colors.white),),
      onPressed: (){
        bloc.getSr4unApprvdInvoices();
        // bloc.clearInvApprove();
      },
    );
  }


  inCustomer(Bloc bloc) 
  {
    // bloc.clearInvApprove();
    bloc.initiateCustomers(false);
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
              width: 150,
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

  invDateFrom(Bloc bloc,bool isEditMode)
  {
    TextEditingController _controller = new TextEditingController();
    //bloc.initInvDateFrom(isEditMode);
    final formats = { InputType.date: DateFormat('dd-MM-yyyy'),};
    InputType inputType = InputType.date;
    // bool editable = true;
    return StreamBuilder<DateTime>(
        stream: bloc.invApDateFrom,
        builder: (context, snapshot){
        if(snapshot.hasData)
        {_controller.value = _controller.value.copyWith(text:  DateFormat("dd-MM-yyyy").format(snapshot.data));}       
        //print('DATE FROM : ' + snapshot.data.toString());

          return SizedBox(
          width: 150,
          child: new DateTimePickerFormField(
            controller: _controller,
            inputType: inputType,
            format: formats[inputType],
            editable: isEditMode,
            decoration: const InputDecoration(labelText: 'DATE FROM', hasFloatingPlaceholder: true),
            onChanged: bloc.invApDateChanged),
            );}
          );
  }

  inDateToFld(Bloc bloc,bool isEditMode)
  {
    //bloc.initInvDateTo(isEditMode);
    TextEditingController _controller = new TextEditingController();
    final formats = {InputType.date: DateFormat('dd-MM-yyyy'),};
    InputType inputType = InputType.date;
    // bool editable = true;
    return StreamBuilder<DateTime>(
        stream: bloc.invApDateTo,
        builder: (context, snapshot){
        if(snapshot.hasData)
         {_controller.value = _controller.value.copyWith(text: DateFormat("dd-MM-yyyy").format(snapshot.data));}    
        
        return SizedBox(
          width: 150,
          child: new DateTimePickerFormField(
          controller: _controller,
          inputType: inputType,
          format: formats[inputType],
          editable: isEditMode,
          decoration: const InputDecoration(labelText: 'DATE TO', hasFloatingPlaceholder: true),
          onChanged: bloc.invApDateToChanged),
            );}
          );
  }

  invPaymentType(Bloc bloc)
  {
    bloc.initiatePaymentType(false);
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
              width: 150,
              child: InputDecorator(
              decoration: InputDecoration(labelText: 'Invoice Type'),
              child: new IgnorePointer( // To disable the Selection of dropdown..
                ignoring: true,
                child:  DropdownButtonHideUnderline(
                child:  DropdownButton<String>(
                  isDense: true, 
                  items: ssWLDD.data
                  .map<DropdownMenuItem<String>>((PaymentTypes dropDownStringitem)
                  {return DropdownMenuItem<String>(
                    value: dropDownStringitem.lookupCode.toString(), 
                    child: Text(dropDownStringitem.description));},
                  ).toList(),
                value: snapshot.data,
                onChanged: bloc.invApprvlPaymentChenged,
                elevation: 10,
                ) ) 
                )) 
              );
          } else { return CircularProgressIndicator(); }
      });
    });
  }

  apprvBtn(BuildContext context,Bloc bloc, Users loginInfo) 
  {
    InvoiceApi invApi = new InvoiceApi();
    return  RaisedButton(
      // color: Color(0xffd35400),
      child: Text('Approve',style: TextStyle(color: Colors.white),),
      onPressed: () async {      
      invApi.approveInvoices(bloc.selectedInvs4Approval(loginInfo.userID))
        .then((isSuccess) 
        {isSuccess ? StaticsVar.showAlert(context, 'Invoices Approved') : StaticsVar.showAlert(context, 'Invoices NOT Approved');},
        onError: (e){ StaticsVar.showAlert(context, e.toString());})
        .catchError((onError){ StaticsVar.showAlert(context, onError.toString());});
        bloc.clearInvApprove();
      },
    );
  }
  


  Widget listTile(Bloc bloc)
    {     
      return StreamBuilder(
        stream: bloc.unApprvdInvoices,
        builder: (context, ssUnAppInv) {
        List unInvData = ssUnAppInv.hasData ? ssUnAppInv.data : <UnApprovedInvoice>[];
        print('inv length : ' + unInvData.length.toString());
          return ListView.builder(
              itemCount: unInvData.length,
              itemBuilder: (context, index)
              { 
                return Container(height: 100.0,padding: EdgeInsets.only(top:5.0),
                  child: Card(
                    margin: EdgeInsets.only(right: 5.0, left: 5.0),
                    elevation: 5.0,
                    child: ListTile(
                      // onTap: (){bloc.isInvoiceChecked(unInvData[index].invoiceNo, true);},
                      title: Row(children: <Widget>[
                        Expanded(flex: 4,child:Text('Invoice No.:'),),
                        Expanded(flex: 6,child: Text(unInvData[index].invoiceNo),),                            
                        ]),
                      trailing: Checkbox(
                        activeColor: Colors.blue,
                        onChanged: (bool respVal){bloc.isInvoiceChecked(unInvData[index].invoiceNo,respVal);},
                        value: unInvData[index].isChecked,
                      ),                                                  
                      subtitle: Container(
                      child: Align(
                      alignment: Alignment.centerLeft,
                        child: Column(
                        children: <Widget>[
                        Row(children: <Widget>[
                            Expanded(flex: 4,child:Text('Customer: '),),
                            Expanded(flex: 6,child: Text(unInvData[index].customerName),),                            
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(flex: 4,child:Text('Date: '),),
                              Expanded(flex: 6,child: Text(DateFormat('dd-MM-yyyy').format(unInvData[index].invoiceDate),)),                            
                              // Expanded(flex: 5,child: Text(poData[index].productCode),)
                            ],
                          ),
                          Row(
                            children: <Widget>[
                            Expanded(flex: 4,child:Text('Type: '),),
                            Expanded(flex: 6,child: Text(unInvData[index].invoiceType),),                            
                            // Expanded(flex: 5,child: Text(poData[index].productCode),)
                          ],
                        ),
                         Row(
                            children: <Widget>[
                              Expanded(flex: 4,child:Text('Amount: '),),
                              Expanded(flex: 6,child: Text(unInvData[index].invoiceAmount.toString()),),                            
                              // Expanded(flex: 5,child: Text(poData[index].productCode),)
                            ],
                          ),
                        ],
                      )),
                    )),
                ));
              }
            );
        //} else { return Center(child:CircularProgressIndicator());}
      });
    }


}


