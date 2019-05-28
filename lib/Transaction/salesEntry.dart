import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:split/Bloc/Bloc.dart';
import 'package:split/Bloc/CommonVariables.dart';
import 'package:split/Bloc/provider.dart';
import 'package:split/Transaction/salesEntryList.dart';
import 'package:split/src/APIprovider/salesEntryApiProvider.dart';
import 'package:split/src/Models/customermodel.dart';
import 'package:split/src/Models/loginmodel.dart';
import 'package:split/src/Models/lookupModel.dart';
import 'package:split/src/Models/paymentModel.dart';
import 'package:split/src/Models/productModel.dart';
import 'package:split/src/Models/salesEntryModel.dart';

class SalesEntry extends StatefulWidget
{
  final  Users loginInfo;
  final String orderNum;
  SalesEntry({Key key, @required this.loginInfo,this.orderNum}) :super(key: key);
  @override
  _SalesEntryState createState() => _SalesEntryState();
}

class _SalesEntryState extends State<SalesEntry>
{
  final double fldHeight = 45.0;
  int intCount = 0;

  @override
  Widget build(BuildContext context) {

    var bloc = Provider.of(context);
    bool isInEditMode = (widget.orderNum != ""); // true : means Edit mode // false: means New Quotation
    
    // if(isInEditMode) 
    // { 
      intCount = intCount+1; //print('No Of Times Executed: ' + intCount.toString()); 
      if(intCount==1) 
      { bloc.initiatePaymentType(); 
        bloc.initiateCustomers();
        bloc.initiateProducts();
        bloc.initiateUOMs(); 
        bloc.fetchSalesEntry(widget.orderNum);}
    // }
    
    bloc.listenProdCode();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xffd35400),
            title: Text('Sales Entry'),
            leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context) => SalesEntryList(loginInfo: widget.loginInfo,)));},
            ),
          ),
        body:SingleChildScrollView(
          child:
            Container(
            child: Column(
             children: <Widget>[
              Divider(),
              Card(
                elevation: 10.0,
                margin: EdgeInsets.only(left: 8.0,right: 8.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                      //Container(height:50, child: FittedBox(child: seCustomerDD(bloc)),)
                      //Expanded(flex:5, child: Container(height:fldHeight, child: FittedBox(child: sEntryCustomerDD(bloc,isInEditMode)),)),
                      Expanded(flex:5, child: Container(height:fldHeight, child: FittedBox(child: seCustomerDD(bloc,isInEditMode)),)),
                      SizedBox(width:10),
                      Expanded(flex:5, child: Container(height:fldHeight, child: FittedBox(child: sePaymentTerm(bloc,isInEditMode)),)),
                    ],),
                    Row(children: <Widget>[Expanded(flex:1, child: Container(height:fldHeight, child: FittedBox(child: seAddressFld(bloc,isInEditMode))))]),
                    Row(children: <Widget>[
                      Expanded(flex:5, child: Container(height:fldHeight, child: FittedBox(child: seDateFld(bloc,isInEditMode)),)),
                      
                      SizedBox(width:10),
                      Expanded(flex:5, child: Container(height:fldHeight, child: FittedBox(child: seDelvDateFld(bloc,isInEditMode)),)),                 
                    ],),
                    Row(children: <Widget>[Expanded(flex:10, child: Container(height:fldHeight, child: FittedBox(child: seRemarkFld(bloc,isInEditMode))))]),
                  ],
                ),
              ),
              Divider(height:2.5),
              Card(elevation: 10.0,
                margin: EdgeInsets.only(left: 8.0,right: 8.0),
                child: Column(
                  children: <Widget>[
                   Row(children: <Widget>[
                       Expanded(flex:5, child: Container(height:fldHeight, child: FittedBox(child: seOKbtn(bloc,widget.loginInfo,context)),)),                          
                    ],),
                    //Container(height: 300, child: listTile(bloc)),
                  ],
                ),
              ),
              Divider(color: Colors.red,height: 5.0,),
              Container(height: 330, child: listTile(bloc, widget.loginInfo)),
              // summaryFields(context, bloc, widget.loginInfo,widget.orderNum),

              // payBtn(context, bloc, widget.loginInfo ),
            ],
          ),         
            ),
          ),
          bottomNavigationBar:Container(height: 100.0,child: summaryFields(context, bloc, widget.loginInfo,widget.orderNum))
      ),
    );
  }
}

  seCustomerDD(Bloc bloc,bool isInEditMode)
  {
    bloc.initiateCustomers();
    //CustomerApiProvider wlApi = new CustomerApiProvider();
    return StreamBuilder<String>(
    stream: bloc.seCustCode,
    builder: (context,snapshot)
    {
      return StreamBuilder(
        stream: bloc.initCustomers,
        builder: (context,ssWLDD)
        { 
        if (ssWLDD.hasData)
        {
          return SizedBox(
          width: 250,
          child: InputDecorator(
            decoration: InputDecoration(labelText: 'Customer'),
            child:new IgnorePointer(
              ignoring: isInEditMode,
              child: DropdownButtonHideUnderline(
            child:  DropdownButton<String>(
            isDense: true,
            items: ssWLDD.data
              .map<DropdownMenuItem<String>>(
              (Customer dropDownStringitem){ 
              return DropdownMenuItem<String>(
              value: dropDownStringitem.customerCode.toString(), 
              child: Text(dropDownStringitem.customerName.toString()));},
                ).toList(),
                value: snapshot.data,
                onChanged: bloc.seCustCodeChanged,
                isExpanded: true,
                elevation: 10,
              
            )) ) ) );
        } else { return CircularProgressIndicator(); }
      });
    });
  }

  sePaymentTerm(Bloc bloc,bool isInEditMode)
  {
    bloc.initiatePaymentType();
    //PaymentApiProvider payApi = new PaymentApiProvider();
      return StreamBuilder<String>(
        stream: bloc.sePaymentType,
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
                ignoring:isInEditMode,
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
                onChanged: bloc.sePaymentTypeChanged,
                isExpanded: true,
                elevation: 10,
                ) ) ) ) );
            } else { return CircularProgressIndicator(); }
        });
      });
  }

  seAddressFld(Bloc bloc,bool isInEditMode)
  {
    TextEditingController _controller = new TextEditingController();
     return StreamBuilder<String>(
      stream: bloc.seCustAddress,
      builder:(context,snapshot){
        if(snapshot.hasData)
      {_controller.value = _controller.value.copyWith(text: snapshot.data.toString());}
       return SizedBox(width: 600.0,
          child: TextField(
            onChanged: bloc.seCustAddressChanged,
            controller: _controller,
             enabled: isInEditMode,
            decoration: InputDecoration(labelText: '',fillColor: Colors.grey),) );});
  }

  seDateFld(Bloc bloc,bool isInEditMode)
  {
      TextEditingController _controller = new TextEditingController();

      
    final formats = { InputType.date: DateFormat('dd/MM/yyyy'),};
    InputType inputType = InputType.date;
    bool editable = true;
      return StreamBuilder<DateTime>( 
            stream: bloc.seSalesDate,
            builder:(context,snapshot){
            if(snapshot.hasData)
        {_controller.value = _controller.value.copyWith(text:  DateFormat("dd/MM/yyyy").format(snapshot.data));}
           return SizedBox(width:300,
            child: new DateTimePickerFormField(
              inputType: inputType,
              format: formats[inputType],
              editable: editable,
              enabled: (!isInEditMode),
              initialValue: DateTime.now(),
              decoration: const InputDecoration(
              labelText: 'Date',hasFloatingPlaceholder: true), 
              onChanged: bloc.effectivePromoChanged,
              controller: _controller,
            ), 
          );}
        );
  }
  seDelvDateFld(Bloc bloc,bool isInEditMode)
  {
    TextEditingController _controller = new TextEditingController();
    final formats = { InputType.date: DateFormat('dd/MM/yyyy'),};
    InputType inputType = InputType.date;
    bool editable = true;
    return StreamBuilder<DateTime>( 
          stream: bloc.seDelvDate,
          builder:(context,snapshot){
             if(snapshot.hasData)
        {_controller.value = _controller.value.copyWith(text:  DateFormat("dd/MM/yyyy").format(snapshot.data));}
           return  SizedBox(width:200,
            child: new DateTimePickerFormField(
              inputType: inputType,
              format: formats[inputType],
              enabled: (!isInEditMode),
              editable: editable,
              decoration: const InputDecoration(
              labelText: 'Delivery Date',hasFloatingPlaceholder: true
              ), 
              onChanged: bloc.seDelvDateChanged,
              controller: _controller,
            ), 
          );}
      );
  }

  seRemarkFld(Bloc bloc,bool isInEditMode)
  { TextEditingController _controller = new TextEditingController();
    return StreamBuilder<String>(
                stream: bloc.refNumStream,
                builder:(context,snapshot){
                  if(snapshot.hasData)
      {_controller.value = _controller.value.copyWith(text: snapshot.data.toString());}
               return SizedBox(width: 600.0,
                child: TextField(
                onChanged: bloc.refNumChanged,
                controller: _controller,
                enabled: isInEditMode,
                decoration: InputDecoration(labelText: 'Remark'),) );});
  }

// Add Items
  seProductCodeDD(Bloc bloc)
  {
      bloc.initiateProducts();
    // ProductApiProvider payApi = new ProductApiProvider();
      return StreamBuilder<String>(
        stream: bloc.seProdCode,
        builder: (context,snapshot)
        {
          return StreamBuilder(
          stream: bloc.initProducts,
          builder: (context,ssWLDD)
          { 
            if (ssWLDD.hasData)
            {
              return SizedBox(width: 300, child: InputDecorator(decoration: InputDecoration(labelText: 'Product'),
              child:DropdownButtonHideUnderline(
                child:  DropdownButton<String>(
                  isDense: true,
                  items: ssWLDD.data
                  .map<DropdownMenuItem<String>>((Product dropDownStringitem)
                  { return DropdownMenuItem<String>(
                    value: dropDownStringitem.productCode, 
                    child: Text(dropDownStringitem.description));},
                  ).toList(),
                value: snapshot.data,
                onChanged: bloc.seProdCodeChanged,
                isExpanded: true,
                elevation: 10,
                ) ) ) );
            } else { return CircularProgressIndicator(); }
        });
      });
  }

  seQtyFld(Bloc bloc)
  {
    TextEditingController _controller = new TextEditingController();
    return StreamBuilder<String>(
        stream: bloc.seQty,
        builder:(context,snapshot){
          if(snapshot.hasData)
      {_controller.value = _controller.value.copyWith(text: snapshot.data.toString());}
        return  SizedBox(width: 200.0,
            child: TextField(onChanged: bloc.seQtyChanged,
            controller: _controller,
              keyboardType: TextInputType.numberWithOptions(),
                    decoration: InputDecoration(labelText: 'Qty'),
            ) 
          );}
    );
  }

  seUOMDD(Bloc bloc)
  {
      bloc.initiateUOMs();
    // LookUpApiProvider payApi = new LookUpApiProvider();
      return StreamBuilder<String>(
        stream: bloc.seUOM,
        builder: (context,snapshot)
        {
          return StreamBuilder(
          stream: bloc.initUOM,
          builder: (context,ssWLDD)
          { 
            if (ssWLDD.hasData)
            {
              return SizedBox(width: 250, child: InputDecorator(decoration: InputDecoration(labelText: 'UOM'),
              child:DropdownButtonHideUnderline(
                child:  DropdownButton<String>(
                  isDense: true,
                  items: ssWLDD.data
                  .map<DropdownMenuItem<String>>((Lookup dropDownStringitem)
                  { return DropdownMenuItem<String>(
                    value: dropDownStringitem.lookupCode.toString(), 
                    child: Text(dropDownStringitem.description));},
                  ).toList(),
                value: snapshot.data,
                onChanged: bloc.seUOMChanged,
                isExpanded: true,
                elevation: 10,
                ) ) ) );
            } else { return CircularProgressIndicator(); }
        });
      });
  }

  seOKbtn(Bloc bloc, Users loginInfo,BuildContext context)
  {
    return FlatButton(color: Color(0xffd35400),
      child: Text('Add to cart',style: TextStyle(color: Colors.white),),
      onPressed: () { _showDialog(context,bloc, loginInfo);
      
        },);
  }

//  seGetProdDetails(Bloc bloc,Users loginInfo)
//   {
//     // ProductApiProvider payApi = new ProductApiProvider();
//       return StreamBuilder<String>(
//         stream: bloc.seProdCode,
//         builder: (context,snapshot)
//         {
//           if(snapshot.hasData)
//             {bloc.getSEDetails(loginInfo);}
//       });
//   }
  

  // POP UP Fields
  seDiscountType(Bloc bloc)
  {   
    return StreamBuilder(
    stream: bloc.seDiscountType,
    builder: (context,snapshot){
      //print('SnapShot' + snapshot.data == null ? "empty" : snapshot.data);
      return SizedBox(width: 300,
      child:InputDecorator(
        decoration: InputDecoration(
          labelText: 'Discount Type',
          errorText: snapshot.error),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isDense: true,
            items: ['NONE','PERCENTAGE','AMOUNT']
              .map<DropdownMenuItem<String>>(
              (String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
              }).toList(),
            value: snapshot.data,
            onChanged: bloc.seDiscountTypeChanged,
            // hint: Text('Select Discount Types'),
            isExpanded: true,elevation: 8,
            ),
          ),
        ),
      );
    }
    );
  }

  seDiscountAmt(Bloc bloc)
  {   
    TextEditingController _controller = new TextEditingController();
    return StreamBuilder<String>(
      stream: bloc.seDiscount,
      builder:(context,snapshot){
        if(snapshot.hasData)
        {_controller.value = _controller.value.copyWith(text: snapshot.data.toString());}
        return  SizedBox(width: 300.0,
          child: TextField(
            onChanged: bloc.seDiscountChanged,
            controller: _controller,
            keyboardType: TextInputType.numberWithOptions(),
            decoration: InputDecoration(
              labelText: 'Discount Amount',
              fillColor: Colors.grey),) );});

  }

  Widget listTile(Bloc bloc, Users loginInfo)
  {
    //ProductApiProvider pProductDtApi = new ProductApiProvider();
    return StreamBuilder(
      stream: bloc.seDetails,
      builder: (context, ssPOproDt) {
      List seData = ssPOproDt.hasData ? ssPOproDt.data : <SalesEntryDetails>[];
      //if (seData.) {                                                                    
        return ListView.builder(
            itemCount: seData.length,
            itemBuilder: (context, index) 
            { return Container(height: 112.0,padding: EdgeInsets.only(top:15.0),
                child: Card(
                  margin: EdgeInsets.only(right: 5.0, left: 5.0),
                  elevation: 5.0,
                  child: ListTile(
                    title: Text('Product : ' + seData[index].productDescription),
                    trailing:Column(children: <Widget>[
                      // IconButton(iconSize: 20.0, icon: Icon(Icons.edit), 
                      //   onPressed: () {bloc.display4EditSalesEntryDtls(seData[index].productCode.trim()); _showDialog(context, bloc, loginInfo);}),
                      //SizedBox(height: 50,),
                      
                      IconButton(
                        iconSize: 20.0,
                        icon:Icon(Icons.delete),
                        onPressed: () 
                        {bloc.deleteSEDetail(seData[index].productCode); StaticsVar.showAlert(context,"Product Deleted");}),
                                   ],),  //bloc.editGoodsReceiverItem(seData[index].productCode); StaticsVar.showAlert(context, "Product Deleted"); }),
                      subtitle: Container(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: 
                            Column(children: <Widget>[
                              Row(children: <Widget>[
                                // Expanded(flex:1, child: Container(height:20, child: 
                                //   FittedBox(child: Text('Sell Rate : ' + seData[index].sellRate.toString())),)),
                                // SizedBox(width:10.0),  
                                // Expanded(flex:1, child: Container(height:20, child: 
                                //   FittedBox(child: Text('Sell Rate : ' + seData[index].sellPrice.toString())),)),
                                    Text('Sell Rate : ' + seData[index].sellRate.toString()),
                                    SizedBox(width:10.0),
                                    Text('Selling Price : ' + seData[index].sellPrice.toString()),
                              ]),
                              Row(children: <Widget>[
                                    Text('Quantity : ' + seData[index].quantity.toString()),
                                    SizedBox(width:10.0),
                                    Text('Discount Type : ' + seData[index].discountType.toString()),
                              ]),
                              Row(children: <Widget>[
                                    Text('Discount : ' + seData[index].discountAmount.toString()),
                                    SizedBox(width:10.0),
                                    Text('Total Amount : ' + seData[index].sellPrice.toString()), //selling price is nothing but total amt
                              ]),
                              // Row( children: <Widget>[
                              //       Text('UOM : ' + seData[index].uom.toString()),
                              //       SizedBox(width:22.0),
                              //       Text('Pending Qty : ' + seData[index].pendingQuantity.toString()),
                              // ])
                            ],)
                        ), 
                      ),
                    )),
              ); 
            });
      //} else { return Center(child:CircularProgressIndicator());}
    });
  }

  _showDialog(BuildContext context, Bloc bloc, Users loginInfo) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return SimpleDialog(children: <Widget>[ 
          //showRadioBtn(context),
          showPopUpList(context, bloc, loginInfo),
          // new FlatButton(child: new Text("Close",style: txtRoboBoldHiLightColor(25, Colors.blueAccent)),
          //                onPressed: () {Navigator.of(context).pop();},
          //)
        ],);
      },
    );
  }

  Widget showPopUpList(BuildContext context, Bloc bloc, Users loginInfo) {
    return Container( width: 200, height: 400, 
        // decoration: BoxDecoration(border: Border.all(color: Colors.blueGrey), 
        //               shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(5.0)),
        padding: EdgeInsets.only(left:5.00, right:5.00),
        //elevation: 24,
        child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[ 
              //dispProductDetails(context, bloc, grItem.quantity.toString(), grItem.productCode),
              dispProductDetails(context, bloc, loginInfo),
            ]
          )
    );
  }  

  Widget saveProductCodeBtn(BuildContext context, Bloc bloc, Users loginInfo)
  {   
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
                bloc.clearDisplay4SE();
                bloc.addSEDetails(loginInfo);
              }, 
            ),
          ],
        ),
      );
  }

  //dispProductDetails(BuildContext context, Bloc bloc, String qnty, String prodCode)
  dispProductDetails(BuildContext context, Bloc bloc, Users loginInfo )
  {
    return  SingleChildScrollView(
      child: Container(margin: EdgeInsets.only(top: 2.0, left: 2.0, right: 2.0),
              child: Center( 
                        child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 20.0),
                        //Text("Quantity: " + qnty),
                        //SizedBox(height: 5.0),
                        Row(children: <Widget>[ 
                          Expanded(flex:5, child: seQtyFld(bloc)),
                          SizedBox(width: 10,),
                          Expanded(flex:5, child: seUOMDD(bloc)) ]),                         
                          seProductCodeDD(bloc),
                          seDiscountType(bloc),
                          seDiscountAmt(bloc),
                          //saveProductCodeBtn(context, bloc, prodCode)                                  
                          saveProductCodeBtn(context, bloc, loginInfo)                                  
                      ],
                    ),
          // )
                    ),
              ),
    );
  }  


  Widget summaryFields(BuildContext context, Bloc bloc, Users loginInfo,String orderNum)
  {
    double fldHeight = 15.0;
    return StreamBuilder(
      stream: bloc.seDetails,
      builder: (context, ssSEDtl) {
        bool gotData= ssSEDtl.hasData;
        return Container(padding: EdgeInsets.only(top:5.0),  color: Colors.blue,
          child: Column(
           children: <Widget>[
            Row(children: <Widget>[   
              Expanded(flex:5, child: Container(height:fldHeight, child: 
                        FittedBox(child: Text('Total Amt: ' + (gotData ? bloc.getAmt('TOTAL').toString() : ""),style: TextStyle(color: Colors.white),)))),
              SizedBox(width:10),
              Expanded(flex:5, child: Container(height:fldHeight, child: 
                        FittedBox(child: Text('Discount Amt: ' + (gotData ? bloc.getAmt('DISCOUNT').toString() : ""),style: TextStyle(color: Colors.white) )),)),              
            ]),
            Divider(color: Colors.green,),
            Row(children: <Widget>[
              Expanded(flex:3, child: Container(height:fldHeight, child: 
                        FittedBox(child: Text('Net Amount: ' + (gotData ?  bloc.getAmt('NET').toString() : ""),style: TextStyle(color: Colors.white) )))),
              SizedBox(width:10),
              Expanded(flex:3, child: Container(height:fldHeight, child: 
                        FittedBox(child: Text('Paid Amount: ' + (gotData ? bloc.getAmt('PAID').toString() : ""),style: TextStyle(color: Colors.white) )),)),
              SizedBox(width:10),
              Expanded(flex:3, child: Container(height:fldHeight, child: 
                        FittedBox(child: Text('Bal Amt: ' + (gotData ? bloc.getAmt('BALANCE').toString() : ""),style: TextStyle(color: Colors.white) )),)),                          
              Divider(color: Colors.green,),
            ],),
            payBtn(context, bloc, loginInfo,orderNum),
              ] ) );
    });
}

// Main button to save Sales Entry  
payBtn(BuildContext context, Bloc bloc, Users loginInfo,String orderNum )
{
  return  RaisedButton(
    child: Text('SAVE'),
    color: Color(0xffd35400),
    onPressed: ()async { 
          SalesEntryApi seAPI = new SalesEntryApi();
          await seAPI.saveSalesEntry(bloc.getSalesEntry(loginInfo,orderNum))
          .then((isSuccess) { if(isSuccess) 
            { StaticsVar.showAlert(context,'Sales Entry Saved'); 
              bloc.clearSalesEntry();
              Navigator.push(context, MaterialPageRoute(builder: (context) => SalesEntryList(loginInfo: loginInfo))); 
              }},
            onError: (e) {StaticsVar.showAlert(context, e.toString());} )
          .catchError((onError) {StaticsVar.showAlert(context, onError.toString());});    
        },
  );
}