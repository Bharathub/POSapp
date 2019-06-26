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
import 'package:split/src/Models/paymentModel.dart';

class UnbilledInvoices extends StatefulWidget {

   final Users loginInfo;
  UnbilledInvoices({Key key, @required this.loginInfo}) :super(key: key);
  @override
  _UnbilledInvoicesState createState() => _UnbilledInvoicesState();
}

class _UnbilledInvoicesState extends State<UnbilledInvoices> {
//final bloc = new Bloc();

  int count = 0;

  @override
  Widget build(BuildContext context) {
    
    bool isEditMode;
    var bloc = Provider.of(context);

    count = count + 1;
    if(count == 1)
    {
      bloc.initiateCustomers(true);
      bloc.initiateCurrencys(true);
      bloc.clearUnbilledInv();
    }

    return MaterialApp(
      theme: ThemeData(buttonColor: Color(0xffd35400)),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("Unbilled Invoices"),
          backgroundColor: Color(0xffd35400),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () { 
              Navigator.push(context,
              MaterialPageRoute(builder: (context) => BillingNew(loginInfo: widget.loginInfo,)));
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            // child: new GestureDetector(
            //         onTap: () {FocusScope.of(context).requestFocus(new FocusNode());},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                padding: EdgeInsets.only(left:5.0, right:5, top: 5), //width: 400.0,height:220.0,
                child: Card(
                margin: EdgeInsets.only(left:5.0,right: 5.0),
                elevation: 5,
                child:Column(children:<Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      unInvCustomer(bloc),
                      // Expanded(flex:5, child:  unInvCustomer(bloc),),
                      SizedBox(width: 8.0,),
                      unInvCurrencyType(bloc)
                    // Expanded(flex:5, child:  unInvCurrencyType(bloc),),
                  ],),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,                   
                    children: <Widget>[
                    unInvDateFld(bloc,isEditMode),
                    // Expanded(flex:5, child:  unInvDateFld(bloc,isEditMode),),
                    SizedBox(width: 8.0,),
                    unInvDateToFld(bloc,isEditMode)
                    // Expanded(flex:5, child:  unInvDateToFld(bloc,isEditMode),),
                  ],),                 
                  SizedBox(height: 15.0,),
                  searchBtn(bloc) 
                 ]),
               ) ),
                Divider(),
                Container( height: 400.0,child: listTile(bloc))          
              ],
            ),
          )
        ),
        bottomNavigationBar: recvdPayment(context,bloc,widget.loginInfo),
      ),
    );
  }
  
 searchBtn(Bloc bloc) 
  {
    return  RaisedButton(
      // color: Color(0xffd35400),
      child: Text('Search',style: TextStyle(color: Colors.white),),
      onPressed: (){
        bloc.getSr4UnBilledInvoices();
      },
    );
  }

  unInvCustomer(Bloc bloc)
  {
    bloc.initiateCustomers(false);
    return StreamBuilder<String>(
      stream: bloc.unBilldCustomer,
      builder: (context,snapshot)
      {
        return StreamBuilder(
      stream: bloc.initCustomers,
      builder: (context,ssWLDD)
      {
      if (ssWLDD.hasData)
      {
        return SizedBox(width: 150, child: InputDecorator(decoration: InputDecoration(labelText: 'Customer'),
        child:DropdownButtonHideUnderline(
        child:  DropdownButton<String>(
          isDense: true,
          items: ssWLDD.data
          .map<DropdownMenuItem<String>>(
          (Customer dropDownStringitem){ 
          return DropdownMenuItem<String>(
          value: dropDownStringitem.customerCode.toString(), 
          child: Text(dropDownStringitem.customerName,),);}, ).toList(),
          value: snapshot.data,
          onChanged: bloc.unBilldCustomerChanged,
          isExpanded: true,
          elevation: 10,
        )
        )
        )
      );
      } else { return CircularProgressIndicator(); }
    }
    );
    }
  );


  }
    
  unInvDateFld(Bloc bloc,bool isEditMode)
  {
    TextEditingController _controller = new TextEditingController();
    // bloc.initUnbldInvDateFrom(isEditMode);
    //  final formats = { InputType.date: DateFormat('dd-MM-yyyy'),};
    //  InputType inPutType = InputType.date;
    // bool editable = true;
    // var date = DateTime.now(); // (date.year, date.month, 0);
    // print(DateTime(date.year, date.month,1) );

    return StreamBuilder<DateTime>( 
          stream: bloc.unBilldDateFrom,
          builder:(context,snapshot){
          if(snapshot.hasData)
           { //print("DATE FROM: " +  DateTime(snapshot.data.year, snapshot.data.month, 1).toString());
            _controller.value = _controller.value.copyWith(text: DateFormat("dd-MM-yyyy").format(snapshot.data));}   
            return  SizedBox(width:150,
            child: new DateTimePickerFormField( // was using ^0.1.8 changed to any
              dateOnly: true,
              inputType: InputType.date,
              format: DateFormat('dd-MM-yyyy'),
              //keyboardType: TextInputType.datetime,
              //onSaved: (dt){print(dt.toIso8601String());},
              editable: isEditMode,
              decoration: const InputDecoration(
                labelText: 'DATE FROM',
                hasFloatingPlaceholder: true,
                ), 
              controller: _controller,  
              onChanged: bloc.unBilldDateFormChanged
            ), 
          );}
      );
    
  }

  unInvDateToFld(Bloc bloc,bool isEditMode)
  { 
    TextEditingController _controller = new TextEditingController();
    // bloc.initUnBldInvDateTo(isEditMode);
    // final formats = { InputType.date: DateFormat('dd-MM-yyyy'),};
    // InputType inputType = InputType.date;
    // bool editable = true;
    return StreamBuilder<DateTime>( 
          stream: bloc.unBilldDateTo,
          builder:(context,snapshot){
          if(snapshot.hasData)
          { //print("DATE TO: " + snapshot.data.toString());
            _controller.value = _controller.value.copyWith(text:  DateFormat("dd-MM-yyyy").format(snapshot.data));}                      
          return SizedBox(width:150,
            child: new DateTimePickerFormField(
              dateOnly: true,

              inputType: InputType.date,
              format: DateFormat('dd-MM-yyyy'),
              editable: isEditMode,
              decoration: const InputDecoration(
                labelText: 'DATE TO',
                hasFloatingPlaceholder: true,
              ), 
              //onSaved: (dt){print(dt.toIso8601String());},
              controller: _controller,              
              onChanged: bloc.unBilldDateToChanged
            ), 
          );}
      );
    
  }

  // unInvDateFrom(Bloc bloc,bool isEditMode)
  // {
  //   TextEditingController _controller = new TextEditingController();
  //   // bloc.initUnbldInvDateFrom(isEditMode);
  //   final formats = { InputType.date: DateFormat('dd-MM-yyyy'),};
  //   InputType inPutType = InputType.date;
  //   // bool editable = true;
  //   return StreamBuilder<DateTime>( 
  //         stream: bloc.unBilldDateFrom,
  //         builder:(context,snapshot){
  //           if(snapshot.hasData)
  //           {_controller.value = _controller.value.copyWith(text:  DateFormat("dd-MM-yyyy").format(snapshot.data));}   
  //           return  SizedBox(width:150,
  //             child: Text(showDatePicker().then(onValue){}
  //           );
  //         }
  //     );    
  // }


  unInvCurrencyType(Bloc bloc)
  {
    
    bloc.initiatePaymentType(false);
      return StreamBuilder<String>(
        stream: bloc.unBilldPayment,
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
                onChanged: bloc.unBilldPaymentChanged,
                isExpanded: true,
                elevation: 10,
                ) ) ) );
            } else { return CircularProgressIndicator(); }
        });
      });
  }

  recvdPayment(BuildContext context,Bloc bloc, Users loginInfo) 
  {
    InvoiceApi invApi = new InvoiceApi();
    return  RaisedButton(
      color: Color(0xffd35400),
      child: Text('Received Payment',style: TextStyle(color: Colors.white),),
      onPressed: (){
           invApi.unBilledInvoices(bloc.selectedInvs(loginInfo.userID))
        .then((isSuccess) 
        {isSuccess ? StaticsVar.showAlert(context, 'Invoice Approved') : StaticsVar.showAlert(context, 'Invoices NOT Approved');},
        onError: (e){ StaticsVar.showAlert(context, e.toString());})
        .catchError((onError){ StaticsVar.showAlert(context, onError.toString());});     
         bloc.clearUnbilledInv();
      },
    );
  }


  Widget listTile(Bloc bloc)
    {
      return StreamBuilder(
        stream: bloc.unBilledInvoices,
        builder: (context, ssUnAppInv) {
        List unBildInv = ssUnAppInv.hasData ? ssUnAppInv.data : <UnBilledInvoice>[];
        print('inv length : ' + unBildInv.length.toString());
          return ListView.builder(
              itemCount: unBildInv.length,
              itemBuilder: (context, index)
              { 
                return Container(height: 100.0,padding: EdgeInsets.only(top:5.0),
                  child: Card(
                    margin: EdgeInsets.only(right: 5.0, left: 5.0),
                    elevation: 5.0,
                    child: ListTile(
                      // onTap: (){bloc.isInvoiceChecked(unBildInv[index].invoiceNo, true);},
                      title: Row(children: <Widget>[
                        Expanded(flex: 5,child:Text('Invoice No.:'),),
                        Expanded(flex: 5,child: Text(unBildInv[index].invoiceNo),),                            
                            ],
                          ),
                      trailing: Checkbox(
                      activeColor: Colors.blue,
                      onChanged: (bool respVal){bloc.isUnbldInvoiceChecked(unBildInv[index].invoiceNo,respVal);},
                      value: unBildInv[index].isChecked,
                      ),                                                  
                      subtitle: Container(
                      child: Align(
                      alignment: Alignment.centerLeft,
                        child: Column(
                        children: <Widget>[
                          Row(children: <Widget>[
                            Expanded(flex: 5,child:Text('Customer:'),),
                            Expanded(flex: 5,child: Text(unBildInv[index].customerName),),                            
                            ],
                          ),
                          Row(children: <Widget>[
                            Expanded(flex: 5,child:Text('Date:'),),
                            Expanded(flex: 5,child: Text(DateFormat('dd-MM-yyyy').format(unBildInv[index].invoiceDate),)),                            
                            
                            ],
                          ),
                          Row(children: <Widget>[
                            Expanded(flex: 5,child:Text('Type:'),),
                            Expanded(flex: 5,child: Text(unBildInv[index].invoiceType),),                            
                            ],
                          ),
                          Row(children: <Widget>[
                            Expanded(flex: 5,child:Text('Amount:'),),
                            Expanded(flex: 5,child: Text(unBildInv[index].invoiceAmount.toString()),),                            
                            ],
                          ),
                        ],
                      )),
                    )),
                ));
              }
            );
        //} else { return Center(child:CircularProgressIndicator());}invoiceAmount
      });
    }

}


