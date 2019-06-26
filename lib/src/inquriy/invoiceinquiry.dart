import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:split/Bloc/Bloc.dart';
import 'package:split/Bloc/provider.dart';
import 'package:split/src/Billing/customerInvoice.dart';

import 'package:split/src/Models/customermodel.dart';
import 'package:split/src/Models/invoiceModel.dart';
import 'package:split/src/Models/loginmodel.dart';
import 'package:split/src/Models/paymentModel.dart';
import 'package:split/src/inquriy/inquiryTab.dart';

class InvoiceInquiry extends StatefulWidget {
  final Users loginInfo;
  InvoiceInquiry({Key key, @required this.loginInfo}) : super(key: key);
  @override
  _InvoiceInquiryState createState() => _InvoiceInquiryState();
}

class _InvoiceInquiryState extends State<InvoiceInquiry> {

  int execCount = 0;

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of(context);
    execCount++;
    if(execCount == 1){ bloc.initiateCustomers(true); bloc.clearInqInvoice(); }

    bool isEditMode = true;    
    return MaterialApp(
      theme: ThemeData(
        buttonColor: Color(0xffd35400),),
      home: new Scaffold(
         appBar: new AppBar(
          title: new Text("Invoices Inquiry"),
          backgroundColor: Color(0xffd35400),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.push(context,
              MaterialPageRoute(builder: (context) => Inquirys(loginInfo: widget.loginInfo,)));
            },
          ),
        ),
      body: SingleChildScrollView(
        
      child: Center(child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                padding: EdgeInsets.all(5.0),//width: 400.0,height:220.0,
                child: Card(
                margin: EdgeInsets.only(left:5.0,right: 5.0),
                elevation: 5,
                child:Column(children:<Widget>[
                  Row(     
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                    // Expanded(flex:5, child: unInvCustomer(bloc),),
                    unInvCustomer(bloc),
                    SizedBox(width: 10.0,),
                    unInvCurrencyType(bloc),
                    // Expanded(flex:5, child: unInvCurrencyType(bloc),),
                   ],),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                    // Expanded(flex:5, child: unInvDateFld(bloc,isEditMode),),
                    unInvDateFld(bloc,isEditMode),
                    SizedBox(width: 10.0,),
                    unInvDateToFld(bloc,isEditMode),
                    // Expanded(flex:5, child: unInvDateToFld(bloc,isEditMode),),
                  ],),
                  SizedBox(height: 10.0,),
                  searchBtn(bloc) 
                 ]),
               ) ),
                Divider(),
                Container( height: 400.0,child: listTile(bloc))          
              ],
            ),
        ),
       )
      ),
    );
  }

  
 searchBtn(Bloc bloc) 
  {
    return  RaisedButton(
      // color: Color(0xffd35400),
      child: Text('Search',style: TextStyle(color: Colors.white),),
      onPressed: (){
       bloc.getSr4InqInvoices();
      },
    );
  }

  unInvCustomer(Bloc bloc)
  {
    bloc.initiateCustomers(false);
    return StreamBuilder<String>(
      stream: bloc.inqInvCustmr,
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
          onChanged: bloc.inqInvCustmrChanged,
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
    // bloc.initinqInvDateFrm(isEditMode);    

    final formats = { InputType.date: DateFormat('dd-MM-yyyy'),};
    InputType inputType = InputType.date;
    // bool editable = true;
    return StreamBuilder<DateTime>( 
          stream: bloc.inqInvDateFrom,
          builder:(context,snapshot){
             if(snapshot.hasData)
        {_controller.value = _controller.value.copyWith(text:  DateFormat("dd-MM-yyyy").format(snapshot.data));}   
            return  SizedBox(width:150,
            child: new DateTimePickerFormField(
              controller: _controller,
              inputType: inputType,
              format: formats[inputType],
              editable: isEditMode,
              decoration: const InputDecoration(
              labelText: 'DATE FROM',
              hasFloatingPlaceholder: true
              ), 
              onChanged: bloc.inqInvDateFromChanged,
            ), 
          );}
      );
    
  }

  unInvDateToFld(Bloc bloc,bool isEditMode)
  {
    
    TextEditingController _controller = new TextEditingController();
    // bloc.initinqInvDateTo(isEditMode);
    final formats = { InputType.date: DateFormat('dd-MM-yyyy'),};
    InputType inputType = InputType.date;
    // bool editable = true;
    return StreamBuilder<DateTime>( 
          stream: bloc.inqInvDateTo,
          builder:(context,snapshot){
          if(snapshot.hasData)
        {_controller.value = _controller.value.copyWith(text:  DateFormat("dd-MM-yyyy").format(snapshot.data));}                      
         return SizedBox(width:150,
            child: new DateTimePickerFormField(
              controller: _controller,
              inputType: inputType,
              format: formats[inputType],
              editable: isEditMode,
              decoration: const InputDecoration(
              labelText: 'DATE TO',
              hasFloatingPlaceholder: true
              ), 
              onChanged: bloc.inqInvDateToChanged,
            ), 
          );}
      );    
  }

  unInvCurrencyType(Bloc bloc)
  {
    
    bloc.initiatePaymentType(false);
      return StreamBuilder<String>(
        stream: bloc.inqInvType,
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
                onChanged: bloc.inqInvTypeChanged,
                isExpanded: true,
                elevation: 10,
                ) ) ) );
            } else { return CircularProgressIndicator(); }
        });
      });
  }


  Widget listTile(Bloc bloc)
    {
      int lblflx = 4;
      int txtflx = 6;
      return StreamBuilder(
        stream: bloc.unApprvdInvoices,
        builder: (context, ssUnAppInv) {
        List unBildInv = ssUnAppInv.hasData ? ssUnAppInv.data : <UnApprovedInvoice>[];
        print('inv length : ' + unBildInv.length.toString());
          return ListView.builder(
              itemCount: unBildInv.length,
              itemBuilder: (context, index)
              { 
                return Container(height: 120.0,padding: EdgeInsets.only(top:15.0),
                  child: Card(
                    margin: EdgeInsets.only(right: 5.0, left: 5.0),
                    elevation: 5.0,
                    child: ListTile(
                      // onTap: (){bloc.isInvoiceChecked(unBildInv[index].invoiceNo, true);},
                      title: Row(children: <Widget>[
                        Expanded(flex: lblflx, child:Text('Invoice No.: '),),
                        Expanded(flex: txtflx, child: Text(unBildInv[index].invoiceNo),),                            
                            ],
                          ),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => 
                            CustomerInv(loginInfo: widget.loginInfo,invNo: unBildInv[index].invoiceNo.trim())));},
                      subtitle: Container(
                      child: Align(
                      alignment: Alignment.centerLeft,
                        child: Column(
                        children: <Widget>[
                          Row(children: <Widget>[
                            Expanded(flex: lblflx, child:Text('Customer: '),),
                            Expanded(flex: txtflx, child: Text(unBildInv[index].customerName),),                            
                            ],
                          ),
                          Row(children: <Widget>[
                            Expanded(flex: lblflx, child:Text('Date: '),),
                            Expanded(flex: txtflx, child: Text(DateFormat('dd-MM-yyyy').format(unBildInv[index].invoiceDate),)),                                                        
                            ],
                          ),
                          Row(children: <Widget>[
                            Expanded(flex: lblflx, child:Text('Type: '),),
                            Expanded(flex: txtflx, child: Text(unBildInv[index].invoiceType),),                            
                            ],
                          ),
                          Row(children: <Widget>[
                          Expanded(flex: lblflx, child:Text('Amount: '),),
                          Expanded(flex: txtflx, child: Text(unBildInv[index].invoiceAmount.toString()),),                            
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

