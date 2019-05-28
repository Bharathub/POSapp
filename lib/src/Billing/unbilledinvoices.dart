import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:split/src/Billing/billingnew.dart';
import 'package:split/Bloc/Bloc.dart';
import 'package:split/Bloc/provider.dart';
import 'package:split/src/Models/customermodel.dart';
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

  @override
  Widget build(BuildContext context) {

    var bloc = Provider.of(context);
    bloc.initiateCustomers();
    bloc.initiateCurrencys();
    
    return MaterialApp(
      title: '',
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
          child: Center(child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                unInvCustomer(bloc),
                unInvDateFld(bloc),
                unInvDateToFld(bloc),
                unInvCurrencyType(bloc),
                recvdPayment(context)
              ],
            ),
          )
        ),
      ),
    );
  }
}



  unInvCustomer(Bloc bloc)
  {
    bloc.initiateCustomers();
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
        return SizedBox(width: 300, child: InputDecorator(decoration: InputDecoration(labelText: 'Customer'),
        child:DropdownButtonHideUnderline(
        child:  DropdownButton<String>(
        isDense: true,
        items: ssWLDD.data
        .map<DropdownMenuItem<String>>(
        (Customer dropDownStringitem){ 
        return DropdownMenuItem<String>(
        value: dropDownStringitem.customerName.toString(), 
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
    
  unInvDateFld(Bloc bloc)
  {
    final formats = { InputType.date: DateFormat('dd/MM/yyyy'),};
    InputType inputType = InputType.date;
    bool editable = true;
    return StreamBuilder<DateTime>( 
          stream: bloc.unBilldDateForm,
          builder:(context,snapshot)=>       
          SizedBox(width:300,
            child: new DateTimePickerFormField(
              inputType: inputType,
              format: formats[inputType],
              editable: editable,
              decoration: const InputDecoration(
              labelText: 'DATE FORM',hasFloatingPlaceholder: true
              ), 
              onChanged: bloc.unBilldDateFormChanged
            ), 
          ) 
      );
    
  }

  unInvDateToFld(Bloc bloc)
  {
    final formats = { InputType.date: DateFormat('dd/MM/yyyy'),
    };
    InputType inputType = InputType.date;
    bool editable = true;
    return StreamBuilder<DateTime>( 
          stream: bloc.unBilldDateTo,
          builder:(context,snapshot)=>       
          SizedBox(width:300,
            child: new DateTimePickerFormField(
              inputType: inputType,
              format: formats[inputType],
              editable: editable,
              decoration: const InputDecoration(
              labelText: 'DATE TO',hasFloatingPlaceholder: true
              ), 
              onChanged: bloc.unBilldDateToChanged
            ), 
          ) 
      );
    
  }



  unInvCurrencyType(Bloc bloc)
  {
    
    bloc.initiatePaymentType();
    //PaymentApiProvider payApi = new PaymentApiProvider();
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
                width: 250,
                child: InputDecorator(
                  decoration: InputDecoration(labelText: 'Payment Type'),
              child: new IgnorePointer(
                // ignoring:isInEditMode,
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
                ) ) ) ) );
            } else { return CircularProgressIndicator(); }
        });
      });
  }

  recvdPayment(BuildContext context) 
  {
    return  RaisedButton(
      color: Color(0xffd35400),
      child: Text('Received Payment',style: TextStyle(color: Colors.white),),
      onPressed: (){},
    );
  }

// Widget listTile(Bloc bloc, )
// {
//   //ProductApiProvider pProductDtApi = new ProductApiProvider();
//   return StreamBuilder(
//     stream: bloc.poDetails,
//     builder: (context, ssPOproDt) {
//     List poData = ssPOproDt.hasData ? ssPOproDt.data : <PurchaseOrderDetails>[];
//     //if (poData.) {
//       return ListView.builder(
//           itemCount: poData.length,
//           itemBuilder: (context, index) 
//           { return Container(height: 150.0,padding: EdgeInsets.only(top:15.0),
//               child: Card(
//                 margin: EdgeInsets.only(right: 5.0, left: 5.0),
//                 elevation: 10.0,
//                 child: ListTile(
//                   title: Text('Code:   ' + poData[index].productCode),
//                   trailing: IconButton( icon: Icon(Icons.delete), onPressed: () { bloc.deletePODetail(poData[index].productCode); StaticsVar.showAlert(context, "Product Deleted"); }),
//                   subtitle: Container(
//                     child: Align(
//                     alignment: Alignment.centerLeft,
//                       child: Column(
//                       children: <Widget>[
//                         //Text('Description:' + poData[index].description),
//                         Text('Qty:    ' + poData[index].quantity.toString()),
//                         Text('Unit Price:    ' + poData[index].unitPrice.toString()),
//                         Text('UOM:    ' + poData[index].uom),

//                       ],
//                     )),
//                   )),
//               )); 
//         });
//     //} else { return Center(child:CircularProgressIndicator());}
//   });
// }
