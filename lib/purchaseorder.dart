import 'package:flutter/material.dart';
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
        bloc.initiateSuppliers();
        bloc.initiatePaymentType();
        bloc.initiateProducts();
        bloc.initiateUOMs();
        bloc.initiateCurrencys();
        bloc.fetchPO(widget.poNum);}
      
    // }
    return MaterialApp(
  
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
                poDateFld(bloc, !isInEditMode),
                poSupplerDD(bloc),
                Wrap(spacing: 10.0,
                  children: <Widget>[
                    poContactPersonTxtFld(bloc),
                    poAddressFld(bloc),
                ],),
                Wrap(spacing: 10,
                children: <Widget>[
                poShipmentDate(bloc),
                poEstimatedDate(bloc),

                ],),
                
                poRefNoFld(bloc),
                poPaymentTerm(bloc),
                Wrap(spacing: 10.0,
                  children: <Widget>[
                    poPRNoFld(bloc),
                    poRemarkFld(bloc),
                ],),
                Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <Widget>[
                  Text('Product Details',style: TextStyle(fontSize: 24.0),),
                   seOKbtn(bloc,context,widget.products),
                   ],),
               
                Container( height: 225.0,child: listTile(bloc,widget.products),),
                //Divider(),
                SizedBox(height: 15.0,),
                // orederBtn(context,bloc,widget.loginInfo,widget.poNum),
              ],
            )
        ),    
      ),
      // floatingActionButton: FloatingActionButton(backgroundColor:Color(0xffd35400),child: Icon(Icons.add),  
      // onPressed: (){ _showDialog(context, bloc,widget.products);
      // //Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetails(loginInfo: widget.loginInfo,)));
      // },),
      bottomNavigationBar:  orederBtn(context,bloc,widget.loginInfo,widget.poNum),
    ));
  }

}

 seOKbtn(Bloc bloc,BuildContext context,List<Product> products)
  {
    return FlatButton(color: Color(0xffd35400),
      child: Text('Add',style: TextStyle(color: Colors.white),),
      onPressed: (){ _showDialog(context, bloc,products);
      
        },);
  }


  dispProductDetails(BuildContext context, Bloc bloc, List<Product> products)
  {
    return  SingleChildScrollView(
      child: Container(
      margin: EdgeInsets.only(top: 80.0, left: 10.0, right: 10.0),
      child: Center(
        child: Column(
          children: <Widget>[
            poProductdownValue(bloc,products),
            poUOMdownValue(bloc),
            poQtyTxtFld(bloc),
            poCurrencyPopup(bloc),
            poUnitPriceTxtFld(bloc),
            saveProductCodeBtn(context, bloc),
            ],
          ),
        ),
      ),
    );

  }



  poProductdownValue(Bloc bloc, List<Product> products)
  {
      bloc.initiateProducts();  
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
      bloc.initiateUOMs();  
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
      bloc.initiateCurrencys();
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
              onPressed: () { Navigator.of(context).pop();},),
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
              

  void _showDialog(BuildContext context, Bloc bloc, List<Product> products) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return SimpleDialog(children: <Widget>[ 
          //showRadioBtn(context),
          showPopUpList(context, bloc,products),
                 ],);
      },
    );
  }

  Widget showPopUpList(BuildContext contxt, Bloc bloc, List<Product> products) {
    return Container( width: 250, height: 500, 
        // decoration: BoxDecoration(border: Border.all(color: Colors.blueGrey), 
        //               shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(5.0)),
        padding: EdgeInsets.only(left:10.00, right:5.00),
        //elevation: 24,
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
           dispProductDetails(contxt, bloc,products),
          ],
      )
    );
  }


  poNotxtFld(Bloc bloc)
  {
    TextEditingController _controller = new TextEditingController();
    return StreamBuilder<String>(
                stream: bloc.poNumberStream,
                builder:(context,snapshot){
                if(snapshot.hasData)
                {_controller.value = _controller.value.copyWith(text: snapshot.data.toString());}
                SizedBox(width: 300.0,
                child: TextField(
                  onChanged: bloc.poNumberChanged,
                  controller: _controller, 
                  decoration: InputDecoration(labelText: 'PO No.'),) );});

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
          return SizedBox(width:300,
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
        width: 300, child: InputDecorator(decoration: InputDecoration(labelText: 'Supplier'),
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
      } else { return CircularProgressIndicator();}
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
            return SizedBox(width: 300.0,
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
            return SizedBox(width: 300, child: InputDecorator(decoration: InputDecoration(labelText: 'Payment Type'),
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

  orederBtn(BuildContext context, Bloc bloc, Users loginInfo,String poNum)
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


Widget listTile(Bloc bloc, List<Product> products)
{
  return StreamBuilder(
    stream: bloc.poDetails,
    builder: (context, ssPOproDt) {
    List poData = ssPOproDt.hasData ? ssPOproDt.data : <PurchaseOrderDetails>[];
    //if (poData.) {
      return ListView.builder(
          itemCount: poData.length,
          itemBuilder: (context, index) 
          { return Container(height: 110.0,padding: EdgeInsets.only(top:15.0),
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
                     _showDialog(context, bloc,products);
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
              )); 
        });
    //} else { return Center(child:CircularProgressIndicator());}
  });
}