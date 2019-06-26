import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:split/Bloc/Bloc.dart';
import 'package:split/Bloc/CommonVariables.dart';
import 'package:split/Bloc/provider.dart';
import 'package:split/Transaction/purchaseorderlist.dart';

import 'package:split/src/APIprovider/purchaseOrderApiProvider.dart';
import 'package:split/src/Models/currencyModel.dart';
import 'package:split/src/Models/loginmodel.dart';
import 'package:split/src/Models/lookupModel.dart';
import 'package:split/src/Models/paymentModel.dart';
import 'package:split/src/Models/productModel.dart';
import 'package:split/src/Models/purchaserOrderModel.dart';
import 'package:split/src/Models/suppliermodel.dart';

class PurchaseOrder extends StatefulWidget {
  
  final  Users loginInfo;
  final String poNum;
  final List<Product> products;
  PurchaseOrder({Key key, @required this.loginInfo,this.poNum,this.products}) :super(key: key);
  @override
  _PurchaseOrder createState() => _PurchaseOrder();
}

class _PurchaseOrder extends State<PurchaseOrder> 
{
  int intCount = 0;
   
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of(context);
    bool isInEditMode = (widget.poNum != ""); // true : means Edit mode // false: means New Quotation
    // if(isInEditMode) 
    //   { 
      intCount = intCount+1; print('No Of Times Executed: ' + intCount.toString()); 
      if(intCount==1) {
        bloc.initiateSuppliers(true);
        bloc.initiatePaymentType(true);
        bloc.initiateProducts(true);
        bloc.initiateUOMs(true);
        bloc.initiateCurrencys(true);
        bloc.poVatchecked();
        bloc.fillPOContactPersonNAddrs();
        bloc.fetchPO(widget.poNum);}
      
    // }
    return MaterialApp(
      theme: ThemeData(
        buttonColor: Color(0xffd35400),
      ),
      home: Scaffold(
           appBar: AppBar(
            backgroundColor: Color(0xffd35400),
            title: Text('Purchase Order'),
            leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context) => PurchaseOrderList(loginInfo: widget.loginInfo,)));},
            ),
          ),
      body:SingleChildScrollView(
          child: Center(
            child:Column(
              children: <Widget>[
                // posupCodeTxtFld(bloc),
                poNotxtFld(bloc),
                poDateFld(bloc, !isInEditMode),
                poSupplerDD(bloc),
                Wrap(spacing: 30.0,
                  children: <Widget>[
                    poContactPersonTxtFld(bloc),
                    poAddressFld(bloc),
                ],),
                Wrap(spacing: 30,
                children: <Widget>[
                poShipmentDate(bloc),
                poEstimatedDate(bloc),

                ],),
                
                poRefNoFld(bloc),
                poPaymentTerm(bloc),
                Wrap(spacing: 30.0,
                  children: <Widget>[
                    poPRNoFld(bloc),
                    poRemarkFld(bloc),
                ],),
                Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <Widget>[
                  Text('Product Details',style: TextStyle(fontSize: 24.0),),
                   poAddbtn(bloc, context, widget.loginInfo, widget.poNum),
                   ], ),
               
                Container( height: 225.0,child: listTile(bloc,widget.loginInfo,widget.poNum),),
                //Divider(),
                SizedBox(height: 15.0,),
                // orederBtn(context,bloc,widget.loginInfo,widget.poNum),
              ],
            )
        ),    
      ),
      // floatingActionButton: FloatingActionButton(backgroundColor:Color(0xffd35400),child: Icon(Icons.add),  
      // onPressed: (){ _showDialog(context, bloc);
      // //Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetails(loginInfo: widget.loginInfo,)));
      // },),
      bottomNavigationBar: summaryBtn(context, bloc, widget.loginInfo, widget.poNum),
    ));
  }

}

  poAddbtn(Bloc bloc,BuildContext context, Users loginInfo, String poNum)
  {
    return FlatButton(color: Color(0xffd35400),
      child: Text('Add',style: TextStyle(color: Colors.white),),
      onPressed: (){ 
        if(bloc.validateSupplierCode())
        {
        _showDialog(context, bloc, 'ADDDETAIL', loginInfo, poNum);
        }else{StaticsVar.showAlert(context, 'Please Select Supplier');}
        },);
  }

  dispProductDetails(BuildContext context, Bloc bloc)
  {
    return  SingleChildScrollView(
      child: Container(
      margin: EdgeInsets.all(10.0),
      child: Center(
        child: Column(
          children: <Widget>[
            poProductdownValue(bloc),
            poUOMdownValue(bloc),
            poQtyTxtFld(bloc),
            poCurrencyPopup(bloc),
            poUnitPriceTxtFld(bloc),
            SizedBox(height: 10.0,),
            saveProductCodeBtn(context, bloc),
            ],
          ),
        ),
      ),
    );

  }



  poProductdownValue(Bloc bloc)
  {
      bloc.initiateProducts(false);  
      //ProductApiProvider wlApi = new ProductApiProvider();                   
      return StreamBuilder<String>(
        stream: bloc.poProdCodeDDpopupStream,
        builder: (context,snapshot)
        {
        return StreamBuilder(
          stream: bloc.initProducts,
          builder: (context,ssWLDD)
          { 
          if (ssWLDD.hasData)
            {
              // bloc.initiateProductList(ssWLDD.data);                
              return SizedBox(width: 300, child: InputDecorator(decoration: InputDecoration(labelText: 'Product Code'),
                child:DropdownButtonHideUnderline(
                  child:  DropdownButton<String>(
                  isDense: true,
                  items: ssWLDD.data
                  .map<DropdownMenuItem<String>>(
                  (Product dropDownStringitem){ 
                    return DropdownMenuItem<String>(
                      value: dropDownStringitem.productCode.trim(), 
                      child: Text(dropDownStringitem.description),);},).toList(),
                      value: snapshot.data,
                      onChanged: bloc.poProdCodeDDpopupChanged,
                      isExpanded: true,
                      elevation: 10,
                    ) ) ) );
          } else { return CircularProgressIndicator(); }
      });
    });
  }

  poUOMdownValue(Bloc bloc)
  {
      bloc.initiateUOMs(false);  
      // LookUpApiProvider wlApi = new LookUpApiProvider();
      //LookUpApiProvider proApi = LookUpApiProvider();
                          
      return StreamBuilder<String>(
        stream: bloc.poUOMunitDDStream,
        builder: (context,snapshot)
        {
        return StreamBuilder(
          stream: bloc.initUOM,
          builder: (context,ssWLDD)
          { 
          if (ssWLDD.hasData)
              {
              return SizedBox(width: 300, child: InputDecorator(decoration: InputDecoration(labelText: 'UOM/Counting Unit'),
                child:DropdownButtonHideUnderline(
                  child:  DropdownButton<String>(
                  isDense: true,
                  items: ssWLDD.data
                  .map<DropdownMenuItem<String>>(
                  (Lookup dropDownStringitem){ 
                    return DropdownMenuItem<String>(
                      value: dropDownStringitem.lookupCode, 
                      child: Text(dropDownStringitem.description),);},).toList(),
                      value: snapshot.data,
                      onChanged: bloc.poUOMunitDDChanged,
                      isExpanded: true,
                      elevation: 10,
                    ) ) ) );
          } else { return CircularProgressIndicator(); }
              });
              });
  }


  poQtyTxtFld(Bloc bloc)
  {
    TextEditingController _controller = new TextEditingController();
    return StreamBuilder<String>(
      stream: bloc.poQuantitypopupStream,
      builder:(context,snapshot){
         if(snapshot.hasData)
        {_controller.value = _controller.value.copyWith(text: snapshot.data.toString());} 
        return SizedBox(
          width: 300.0,
          child:TextField(
          onChanged: bloc.poQuantitypopupsChanged,
          controller: _controller,
          keyboardType: TextInputType.numberWithOptions(),
          decoration: InputDecoration(labelText: 'Quantity'),) 
          );}
        ); 
  }

  poCurrencyPopup(Bloc bloc)
  {
      bloc.initiateCurrencys(false);
    //CurrencyApiProvider wlApi = new CurrencyApiProvider();
      //LookUpApiProvider proApi = LookUpApiProvider();
                          
      return StreamBuilder<String>(
        stream: bloc.poCurrencyPopupStream,
        builder: (context,snapshot)
        {
        return StreamBuilder(
          stream: bloc.initCurrency,
          builder: (context,ssWLDD)
          { 
          if (ssWLDD.hasData)
              {
              return SizedBox(width: 300, child: InputDecorator(decoration: InputDecoration(labelText: 'Currency'),
                child:DropdownButtonHideUnderline(
                  child:  DropdownButton<String>(
                  isDense: true,
                  items: ssWLDD.data
                  .map<DropdownMenuItem<String>>(
                  (Currency dropDownStringitem){ 
                    return DropdownMenuItem<String>(
                      value: dropDownStringitem.currencyCode.toString(), 
                      child: Text(dropDownStringitem.description),);},).toList(),
                      value: snapshot.data,
                      onChanged: bloc.poCurrencyPopupChanged,
                      isExpanded: true,
                      elevation: 10,
                    ) ) ) );
          } else { return CircularProgressIndicator(); }
      });
    });

  }

  poUnitPriceTxtFld(Bloc bloc)
  {
    TextEditingController _controller = new TextEditingController();
    return StreamBuilder<String>(
      stream: bloc.unitPricePopupStream,
      builder:(context,snapshot){
        if(snapshot.hasData)
        {_controller.value = _controller.value.copyWith(text: snapshot.data.toString());}        
             return SizedBox(
               width: 300.0,
               child: TextField(
                onChanged: bloc.unitPricePopupChanged,
                controller: _controller, 
                keyboardType: TextInputType.numberWithOptions(),
                decoration: InputDecoration(labelText: 'Unit Price'),
                )
              );}
            ); 
  }


  Widget saveProductCodeBtn(BuildContext context, Bloc bloc)
  {   
    //LookUpApiProvider uomApi = LookUpApiProvider();
    return Container(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            FlatButton(child: Text('CANCEL',style: TextStyle(color: Colors.blue),),
              onPressed: () { Navigator.of(context).pop(); bloc.clearDisplay4PO();},),
            FlatButton( child: Text( 'SAVE', style: TextStyle(color: Colors.blue),),
            onPressed: ()
              {
                Navigator.of(context).pop();                  
                bloc.addPODetails();
                bloc.clearDisplay4PO();
              }, 
            ),
          ],
        ),
      );
  
  }
              

  void _showDialog(BuildContext context, Bloc bloc, String showScreen, Users loginInfo, String poNum) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return SimpleDialog(children: <Widget>[ 
          //showRadioBtn(context),
          showPopUpList(context, bloc, showScreen, loginInfo, poNum)
                 ],);
      },
    );
  }

  Widget showPopUpList(BuildContext context, Bloc bloc, String showScreen, Users loginInfo, String poNum) {
    double hgt = showScreen == 'ADDDETAIL' ? 390 : 260;
    double wdt = showScreen == 'ADDDETAIL' ? 300 : 300;

    return Container( width: wdt, height: hgt, 
        // decoration: BoxDecoration(border: Border.all(color: Colors.blueGrey), 
        //               shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(5.0)),
        padding: EdgeInsets.only(left:10.00, right:5.00),
        //elevation: 24,
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
          showScreen == 'ADDDETAIL' ? dispProductDetails(context, bloc) : dispSummaryDetails(context, bloc, loginInfo, poNum)
          ],
      )
    );
  }


  poNotxtFld(Bloc bloc)
  {
    TextEditingController _controller = new TextEditingController();
    return StreamBuilder(
      stream: bloc.poNumberStream,
      builder:(context,snapshot)
      {
      if(snapshot.hasData)
      {_controller.value = _controller.value.copyWith(text: snapshot.data.toString());}
      return SizedBox(width: 325.0,
      child: TextField(
        onChanged: bloc.poNumberChanged,
        controller: _controller, 
        enabled: false,
        decoration: InputDecoration(labelText: 'PO No.'),
          )
        );
      }
    );

  }



poDateFld(Bloc bloc,bool isEditable)
{
  TextEditingController _controller = new TextEditingController();
  final formats = { InputType.date: DateFormat('dd/MM/yyyy'),};
  InputType inputType = InputType.date;
  // bool editable = true;
   bloc.initPODate(isEditable);
  return StreamBuilder<DateTime>( 
        stream: bloc.datePurStream,
        builder:(context,snapshot){
           if(snapshot.hasData)
            {_controller.value = _controller.value.copyWith(text:DateFormat("dd/MM/yyyy").format(snapshot.data));}
          return SizedBox(width:325,
          child: new DateTimePickerFormField(
            inputType: inputType,
            format: formats[inputType],
            editable: isEditable,
            initialValue: DateTime.now(),
            decoration: const InputDecoration(
            labelText: 'Date',hasFloatingPlaceholder: true
            ), 
            onChanged: bloc.datePurChanged,
            controller: _controller,
          ), 
        );}
    );
}

  poSupplerDD(Bloc bloc)
  {
    bloc.initiateSuppliers(false);
    //SupplierApiProvider wlApi = new SupplierApiProvider();
    return StreamBuilder<String>(
      stream: bloc.poSuppCodeStream,
      builder: (context,snapshot)
      {
        return StreamBuilder(
      stream: bloc.initSuppliers,
      builder: (context,ssWLDD)
      { 
      if (ssWLDD.hasData)
    {
      return SizedBox(
        width: 325, child: InputDecorator(decoration: InputDecoration(labelText: 'Supplier'),
        child:DropdownButtonHideUnderline(
        child:  DropdownButton<String>(
        isDense: true,
        items: ssWLDD.data
        .map<DropdownMenuItem<String>>(
        (Supplier dropDownStringitem){ 
        return DropdownMenuItem<String>(
        value: dropDownStringitem.customerCode.trim(), 
        child: Text(dropDownStringitem.customerName,),
          );},
        ).toList(),
        value: snapshot.data,
        onChanged: bloc.poSuppCodeChanged,
        isExpanded: true,
        elevation: 10,
              )
            )
          )
        );
    }else { return CircularProgressIndicator();}
  }
    );
    }
  );


  }

  poContactPersonTxtFld(Bloc bloc)
  {
     TextEditingController _controller = new TextEditingController();
     return StreamBuilder<String>(
              stream: bloc.contactPerStream,
              builder:(context,snapshot){
                if(snapshot.hasData)
      {_controller.value = _controller.value.copyWith(text: snapshot.data.toString());}
                return SizedBox(
                  width: 150.0,
                  child: TextField(
                    onChanged: bloc.contactPerChanged,
                    controller: _controller, 
                    decoration: InputDecoration(labelText: 'Contact Person.'),) );});

}

  poAddressFld(Bloc bloc)
  {
    TextEditingController _controller = new TextEditingController();
    return StreamBuilder<String>(
              stream: bloc.adressStream,
              builder:(context,snapshot){
                if(snapshot.hasData)
      {_controller.value = _controller.value.copyWith(text: snapshot.data.toString());}
                return SizedBox(
                  width: 150.0,
                  child: TextField(
                    onChanged: bloc.adressChanged, 
                    controller: _controller,
                    decoration: InputDecoration(labelText: 'Address'),) );});
  

}

  poShipmentDate(Bloc bloc)
  {
    TextEditingController _controller = new TextEditingController();
    final formats = { InputType.date: DateFormat('dd/MM/yyyy'),};
    InputType inputType = InputType.date;
    bool editable = true;
    return StreamBuilder<DateTime>( 
        stream: bloc.shipDateStream,
        builder:(context,snapshot){
           if(snapshot.hasData)
            {_controller.value = _controller.value.copyWith(text:DateFormat("dd/MM/yyyy").format(snapshot.data));}
       return SizedBox(width:150,
          child: new DateTimePickerFormField(
            inputType: inputType,
            format: formats[inputType],
            editable: editable,
            decoration: const InputDecoration(
            // prefixIcon: const Icon(Icons.calendar_today, color: Colors.green), 
            labelText: 'Shipment Date(ETD)',hasFloatingPlaceholder: true
            ), 
            onChanged: bloc.shippingdateChanged,
            controller: _controller,
          ), 
        );}
    );
  }
  poEstimatedDate(Bloc bloc)
  {
      TextEditingController _controller = new TextEditingController();
      final formats = { InputType.date: DateFormat('dd/MM/yyyy'),};
      InputType inputType = InputType.date;
      bool editable = true;
      return StreamBuilder<DateTime>(
        stream: bloc.estDateStream,
        builder:(context,snapshot){
          if(snapshot.hasData)
              {_controller.value = _controller.value.copyWith(text:DateFormat("dd/MM/yyyy").format(snapshot.data));}      
        return  SizedBox(width:150,
            child: new DateTimePickerFormField(
            inputType: inputType,
            format: formats[inputType],
            editable: editable,
            decoration: const InputDecoration(
            // prefixIcon: const Icon(Icons.calendar_today, color: Colors.green), 
            labelText: 'Estimate DATE',hasFloatingPlaceholder: true
            ), 
            onChanged: bloc.estDateChanged,
            controller: _controller,
          ), 
        );} 
    );
}

  poRefNoFld(Bloc bloc)
  {
     TextEditingController _controller = new TextEditingController();
    return StreamBuilder<String>(
            stream: bloc.refNumStream,
            builder:(context,snapshot){
               if(snapshot.hasData)
      {_controller.value = _controller.value.copyWith(text: snapshot.data.toString());}
            return SizedBox(width: 325.0,
            child: TextField(
              onChanged: bloc.refNumChanged,
              controller: _controller, 
              decoration: InputDecoration(labelText: 'Reference No'),) );});

}

poPaymentTerm(Bloc bloc)
{
   //PaymentApiProvider payApi = new PaymentApiProvider();
    return StreamBuilder<String>(
      stream: bloc.payTypeStream,
      builder: (context,snapshot)
      {
        return StreamBuilder(
        stream: bloc.initPaymentType,
        builder: (context,ssWLDD)
        { 
          if (ssWLDD.hasData)
          {
            return SizedBox(width: 325, child: InputDecorator(decoration: InputDecoration(labelText: 'Payment Type'),
            child:DropdownButtonHideUnderline(
              child:  DropdownButton<String>(
                isDense: true,
                items: ssWLDD.data
                .map<DropdownMenuItem<String>>((PaymentTypes dropDownStringitem)
                { return DropdownMenuItem<String>(
                  value: dropDownStringitem.lookupCode.toString(), 
                  child: Text(dropDownStringitem.description));},
                ).toList(),
              value: snapshot.data,
              onChanged: bloc.payTypeChanged,
              isExpanded: true,
              elevation: 10,
              ) ) ) );
          } else { return CircularProgressIndicator(); }
       });
    });
}

  poPRNoFld(Bloc bloc)
  {
    TextEditingController _controller = new TextEditingController();
    return StreamBuilder<String>(
      stream: bloc.prNumStream,
      builder:(context,snapshot){
         if(snapshot.hasData)
      {_controller.value = _controller.value.copyWith(text: snapshot.data.toString());}
             return SizedBox(width: 150.0,
              child: TextField(
                onChanged: bloc.prNumChanged,
                controller: _controller,
              //  keyboardType: TextInputType.numberWithOptions(),
                decoration: InputDecoration(labelText: 'PR No.'),) );});

  }

  poRemarkFld(Bloc bloc)
  {
    TextEditingController _controller = new TextEditingController();
    return StreamBuilder<String>(
      stream: bloc.remarksStream,
      builder:(context,snapshot){
          if(snapshot.hasData)
      {_controller.value = _controller.value.copyWith(text: snapshot.data.toString());}
             return SizedBox(width: 150.0,
                child: TextField(
                onChanged: bloc.remarksChanged,
                controller: _controller, 
                decoration: InputDecoration(labelText: 'Remarks'),) );});

  }

  savePOBtn(BuildContext context, Bloc bloc, Users loginInfo,String poNum)
  {
    return ButtonTheme(
    minWidth: 250.0,
    child: RaisedButton(
      color: Color(0xffd35400),
      elevation: 5.0,
      child: Text('SAVE', style: TextStyle(color: Colors.white),),
      onPressed: () async { 
        PurchaseOrederApi poAPI = new PurchaseOrederApi();
        await poAPI.savePO(bloc.getPurchaseOrder(poNum))
        .then((isSuccess) { if(isSuccess) 
          { StaticsVar.showAlert(context,'Purchase Order Saved');
            bloc.clearPO(); 
            Navigator.push(context, MaterialPageRoute(builder: (context)=> PurchaseOrderList(loginInfo: loginInfo))); }},
          onError: (e) {StaticsVar.showAlert(context, e.toString());} )
        .catchError((onError) {StaticsVar.showAlert(context, onError.toString());});    
      },
    )
  );
}


Widget listTile(Bloc bloc, Users loginInfo, String poNum)
{
  return StreamBuilder(
    stream: bloc.poDetails,
    builder: (context, ssPOproDt) {
    List poData = ssPOproDt.hasData ? ssPOproDt.data : <PurchaseOrderDetails>[];
    //if (poData.) {
      return ListView.builder(
          itemCount: poData.length,
          itemBuilder: (context, index) 
          { return poData[index].status ? Container(height: 110.0,padding: EdgeInsets.only(top:15.0),
              child: Card(
                margin: EdgeInsets.only(right: 5.0, left: 5.0),
                elevation: 10.0,
                child: ListTile(
                  title:   Row(
                          children: <Widget>[
                            Expanded(flex: 4,child:Text('Product:'),),
                            Expanded(flex: 6,child: Text(poData[index].productDescription),),                            
                            // Expanded(flex: 5,child: Text(poData[index].productCode),)
                          ],
                        ),
                        //  Text('ProductName:   ' + poData[index].productCode),
                  trailing: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    IconButton(icon: Icon(Icons.edit),
                    onPressed: (){
                      bloc.display4EditPODtls(poData[index].productCode);
                     _showDialog(context,bloc, 'ADDDETAIL', loginInfo, poNum);
                    },),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        bloc.deletePODetail(poData[index].productCode);
                        StaticsVar.showAlert(context, "Product Deleted"); }),
                        ],),                   
                  subtitle: Container(
                    child: Align(
                    alignment: Alignment.centerLeft,
                      child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(flex: 4,child:Text('UOM:'),),
                            Expanded(flex: 6,child: Text(poData[index].uom),)
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(flex: 4,child:Text('Qty:'),),
                            Expanded(flex: 6,child: Text( poData[index].quantity.toString()),)
                          ],
                        ),
                         Row(
                          children: <Widget>[
                            Expanded(flex: 4,child:Text('Currency:'),),
                            Expanded(flex: 6,child: Text(poData[index].currencyCode),)
                          ],
                        ),
                         Row(
                          children: <Widget>[
                            Expanded(flex: 4,child:Text('Unit Price:'),),
                            Expanded(flex: 6,child: Text(poData[index].unitPrice.toString()),)
                          ],
                        ),
                        // SizedBox(width: 250,child: Text('Qty:' + poData[index].quantity.toString())),
                      //  /SizedBox(width: 250,child:Text('Unit Price:    ' + poData[index].unitPrice.toString())),
                        // SizedBox(width: 250,child:Text('UOM:    ' + poData[index].uom)),
                        //  SizedBox(width: 250,child:Text('Currency:    ' + poData[index].currencyCode)),

                      ],
                    )),
                  )),
              )) : Container(); 
        });
    //} else { return Center(child:CircularProgressIndicator());}
  });
}


  Widget summaryFields(BuildContext context, Bloc bloc, Users loginInfo, String poNum)
  {
    double fldHeight = 20.0;
    return StreamBuilder(
      stream: bloc.poDetails,
      builder: (context, ssSEDtl) {
        bool gotData = ssSEDtl.hasData;
        return Container(height: 250, width: 350, padding: EdgeInsets.only(top:5.0),
          child:ListTile(
            title: Column(children: <Widget>[
              SizedBox(height: 5.0),
              Row(children: <Widget>[   
                Expanded(flex:5, child: Text('Total Amt:',style: TextStyle(color: Colors.black, fontSize: fldHeight),)),
                Expanded(flex:5, child: Text((gotData ?  bloc.getPOSummaryAmt('TOTAL').toString() : ""),style: TextStyle(color: Colors.black, fontSize: fldHeight) )),
              ]),
              SizedBox(height: 5.0),
              Row(children: <Widget>[
                Expanded(flex:5, child: Text('Other Charges:' ,style: TextStyle(color: Colors.black,fontSize: fldHeight),)),
                // Expanded(flex:5, child: Text( (gotData ?  bloc.getPOSummaryAmt('OTHER').toString() : ""),style: TextStyle(color: Colors.black,fontSize: fldHeight) )),
                Expanded(flex:5, child: poOtherCharger(bloc)),
              ]),
              Row(children: <Widget>[   
                Expanded(flex:4, child: Text('Vat 7%:',style: TextStyle(color: Colors.black,fontSize: fldHeight),)),
                Expanded(flex:2, child: poVatchkBox(bloc)),
                Expanded(flex:4, child: Text( (gotData ? bloc.getPOSummaryAmt('VAT').toString() : ""),style: TextStyle(color: Colors.black,fontSize: fldHeight),)),                        
              ]),
                            
              Row(children: <Widget>[   
                Expanded(flex:5, child: Text('Net Amt:',style: TextStyle(color: Colors.black,fontSize: fldHeight),)),
                Expanded(flex:5, child: Text((gotData ?  bloc.getPOSummaryAmt('NET').toString() : ""),style: TextStyle(color: Colors.black,fontSize: fldHeight) )),
              ]),  
              SizedBox(height: 10.0),
              Divider(color: Colors.black),      
              Row(children: <Widget>[   
                Expanded(flex:4, child: backBtn(context)),               
                Expanded(flex:2, child: Text("")),
                Expanded(flex:4, child: savePOBtn(context, bloc, loginInfo, poNum)),                
              ]),                        
            ])
            
          ));
        }
      );
  }





  summaryBtn(BuildContext context, Bloc bloc, Users loginInfo, String poNum)
  {
    return RaisedButton(        
        child: Text('SUMMARY',style: TextStyle(color: Colors.white),),
        onPressed:(){ _showDialog(context, bloc, 'SUMMARYSCREEN', loginInfo, poNum); },
      );
  }




  dispSummaryDetails(BuildContext context, Bloc bloc, Users loginInfo,String poNum)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 5.0),
        summaryFields(context, bloc, loginInfo, poNum) 
      ],
    );        
  }  


  backBtn(BuildContext context)
  {
    return  RaisedButton(
      child: Text('BACK',style: TextStyle(color: Colors.white,fontSize: 18.0),),
      color: Color(0xffd35400),
      onPressed: ()async { Navigator.pop(context);},
    );
  }

  poVatchkBox(Bloc bloc)
  {   
    return StreamBuilder<bool>(
      stream: bloc.poVat,
      builder:(context,snapshot){
        return Checkbox(
            checkColor: Colors.black,
            activeColor: Colors.grey,
            onChanged: bloc.poVatChanged,
            value: (snapshot.data == null) ? false : snapshot.data,
        );
      });
  }

  poOtherCharger(Bloc bloc)
  { 
    TextEditingController _controller = new TextEditingController();
    return StreamBuilder<String>(
      stream: bloc.poOtherCharges,
      builder:(context,snapshot){
         if(snapshot.hasData)
         {_controller.value = _controller.value.copyWith(text: snapshot.data.toString(), 
                                                         selection: new TextSelection.collapsed(offset: snapshot.data.length)); }        
        return TextField(
          style: TextStyle(fontSize: 20.0),
          keyboardType: TextInputType.numberWithOptions(),
          textDirection: prefix0.TextDirection.ltr,
          //decoration: InputDecoration(labelText: 'Paid Amount:'),
           controller: _controller,
          onChanged: bloc.poOtherChargesChanged
        );
      });
  }