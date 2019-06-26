import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/painting.dart';
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
  final double fldHeight = 50.0;
  int intCount = 0;

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of(context);
    bool isInEditMode = (widget.orderNum != ""); // true : means Edit mode // false: means New Quotation
    
    // if(isInEditMode) 
    // { 
      intCount = intCount+1; //print('No Of Times Executed: ' + intCount.toString()); 
      if(intCount==1) 
      { bloc.initiatePaymentType(true); 
        bloc.initiateCustomers(true);
        bloc.initiateProducts(true);
        bloc.initiateUOMs(true);
        bloc.vatchecked();
        bloc.fetchSalesEntry(widget.orderNum);}
    // }
    
    bloc.listenProdCode();

    return MaterialApp(
      theme: ThemeData(
        buttonColor: Color(0xffd35400),
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffd35400),
          title: Text('Sales Entry'),
          leading: IconButton(
          icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context) => 
                          SalesEntryList(loginInfo: widget.loginInfo,)));},
          ),
        ),
        body:SingleChildScrollView(
          child:
            Container(
            // padding: EdgeInsets.all(10.0),
            child: Column(
             children: <Widget>[
              Divider(),
              Card(
                elevation: 10.0,
                margin: EdgeInsets.only(left: 10.0,right: 10.0),
                child: Column(
                  children: <Widget>[
                    qSeNoFld(bloc),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,                      
                      children: <Widget>[
                      //Container(height:50, child: FittedBox(child: seCustomerDD(bloc)),)
                      //Expanded(flex:5, child: Container(height:fldHeight, child: FittedBox(child: sEntryCustomerDD(bloc,isInEditMode)),)),
                     seCustomerDD(bloc,isInEditMode),
                      SizedBox(width:5.0),
                     sePaymentTerm(bloc,isInEditMode),
                    ],),
                     seAddressFld(bloc,isInEditMode),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,                      
                      children: <Widget>[
                      seDateFld(bloc,!isInEditMode),                      
                      SizedBox(width:10),
                       seDelvDateFld(bloc,isInEditMode),                 
                    ],),
                     seRemarkFld(bloc,isInEditMode),
                    seOKbtn(bloc,widget.loginInfo,context,!isInEditMode),
                    Container(height: 295, child: listTile(bloc, widget.loginInfo)),
                  ],
                ),
              ),
              Divider(color: Colors.red,height: 5.0,),
            ],),         
          ),
        ),
        bottomNavigationBar:Container(color: Colors.red,  height: 50.0,child: summaryBtn(context, bloc, widget.loginInfo, widget.orderNum))
      ),
    );
  }

  summaryBtn(BuildContext context, Bloc bloc, Users loginInfo, String orderNum)
  {
    return RaisedButton(        
        child: Text('SUMMARY',style: TextStyle(color: Colors.white),),
        onPressed:(){ _showDialog(context, bloc, loginInfo, "SUMMARYDETAILS", orderNum); },
      );
  }
}

  qSeNoFld(Bloc bloc)
  {
    TextEditingController _controller = new TextEditingController();
    return StreamBuilder(
      stream: bloc.seCustNo,
      builder:(context,snapshot){
        if(snapshot.hasData)
        {_controller.value = _controller.value.copyWith(text: snapshot.data.toString());}
        return SizedBox(width: 345.0,
          child: TextField(
            onChanged: bloc.seCustNoChanged,
            controller: _controller, 
            enabled: false,
            decoration: InputDecoration(labelText: 'S.E.No.:'),
          )
        );
      });
  }

 

  seCustomerDD(Bloc bloc,bool isInEditMode)
  {
    bloc.initiateCustomers(false);
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
          width: 150,
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
    bloc.initiatePaymentType(false);
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
                width: 150,
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
       return SizedBox(width: 345.0,
          child: TextField(
            onChanged: bloc.seCustAddressChanged,
            controller: _controller,
             enabled: isInEditMode,
            decoration: InputDecoration(labelText: 'Address',fillColor: Colors.grey),) );});
  }

  seDateFld(Bloc bloc,bool isInEditMode)
  {
    TextEditingController _controller = new TextEditingController();      
    final formats = { InputType.date: DateFormat('dd/MM/yyyy'),};
    InputType inputType = InputType.date;
    // bloc.initSalEntyDate(isInEditMode);
    bool editable = true;
      return StreamBuilder<DateTime>( 
            stream: bloc.seSalesDate,
            builder:(context,snapshot){
            if(snapshot.hasData)
        {_controller.value = _controller.value.copyWith(text:  DateFormat("dd/MM/yyyy").format(snapshot.data));}
           return SizedBox(width:150,
            child: new DateTimePickerFormField(
              inputType: inputType,
              format: formats[inputType],
              editable: editable,
              enabled: isInEditMode,
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
           return  SizedBox(width:150,
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
                stream: bloc.seRemarks,
                builder:(context,snapshot){
                  if(snapshot.hasData)
                  {_controller.value = _controller.value.copyWith(text: snapshot.data.toString());}
               return SizedBox(width: 345.0,
                child: TextField(
                onChanged: bloc.seRemarksChanged,
                controller: _controller,
                enabled: true,
                decoration: InputDecoration(labelText: 'Remark'),) );});
  }

// Add Items
  seProductCodeDD(Bloc bloc)
  {
      bloc.initiateProducts(false);
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
              return SizedBox(width: 300, child: InputDecorator(decoration: InputDecoration(labelText: 'Product',labelStyle: TextStyle(fontSize: 20.0)),
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
        return  SizedBox(width: 300.0,
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
      bloc.initiateUOMs(false);
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
              return SizedBox(width: 150, child: InputDecorator(decoration: InputDecoration(labelText: 'UOM'),
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

  seOKbtn(Bloc bloc, Users loginInfo,BuildContext context, bool isAddNew)
  {
    return FlatButton(color: isAddNew ? Color(0xffd35400) : Colors.grey,
      child: Text('Add to cart',style: TextStyle(color: Colors.white),),
      onPressed: () 
      { if(isAddNew){
         bloc.clearDisplay4SE();
        _showDialog(context,bloc, loginInfo,"ADDTOCART","");
        } else {StaticsVar.showAlert(context, 'No Details can Add to Cart');}
      },);
  }

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
          labelText: 'Discount Type',labelStyle: TextStyle(fontSize: 20.0),),
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

  
  seSellingRate(Bloc bloc)
  {   
    TextEditingController _controller = new TextEditingController();
    return StreamBuilder<String>(
      stream: bloc.seSellRate,
      builder:(context,snapshot){
        if(snapshot.hasData)
        {_controller.value = _controller.value.copyWith(text: snapshot.data.toString());}
        return  SizedBox(width: 150.0,
          child: TextField(
            onChanged: bloc.seSellRateChanged,
            controller: _controller,
            // keyboardType: TextInputType.numberWithOptions(),
            decoration: InputDecoration(
              labelText: 'Sell Rate',
              fillColor: Colors.grey),
          )
        );
      }
    );

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
            { 
              return seData[index].status ? Container(height: 140.0,padding: EdgeInsets.all(5.0),
                child: Card(
                  margin: EdgeInsets.only(right: 5.0, left: 5.0),
                  elevation: 5.0,
                  child: ListTile(
                    title: Row(children: <Widget>[
                      Expanded(flex: 5,child:Text('Product:'),),
                      Expanded(flex: 5,child:Text(seData[index].productDescription),)
                    ],),
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
                                Expanded(flex: 5,child: Text('Sell Rate:')),
                                Expanded(flex: 5,child: Text(seData[index].sellRate.toString())),
                              ]),
                              Row(children: <Widget>[
                                Expanded(flex: 5,child: Text('Selling Price:')),
                                Expanded(flex: 5,child: Text(seData[index].sellPrice.toString())),
                              ]),
                              Row(children: <Widget>[
                                Expanded(flex: 5,child: Text('Quantity:')),
                                Expanded(flex: 5,child: Text(seData[index].quantity.toString())),
                              ],),
                              Row( children: <Widget>[
                                Expanded(flex: 5,child: Text('Discount Type:')),
                                Expanded(flex: 5,child: Text(seData[index].discountType.toString())),
                              ]),
                              Row( children: <Widget>[
                                Expanded(flex: 5,child: Text('Discount:' )),
                                Expanded(flex: 5,child: Text(seData[index].discountAmount.toString())),
                              ]),
                              Row(children: <Widget>[
                                Expanded(flex: 5,child: Text('Total Amount:')),
                                Expanded(flex: 5,child: Text(seData[index].partialPayment.toString())), //selling price is nothing but total amt
                              ]),
                            ],)
                        ), 
                      ),
                    )),
              ) : Container(); 
            });
      //} else { return Center(child:CircularProgressIndicator());}
    });
  }

  _showDialog(BuildContext context, Bloc bloc, Users loginInfo, String showScreen,String orderNum) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return SimpleDialog(children: <Widget>[ 
          //showRadioBtn(context),
          showPopUpList(context, bloc, loginInfo, showScreen, orderNum),
          // new FlatButton(child: new Text("Close",style: txtRoboBoldHiLightColor(25, Colors.blueAccent)),
          //                onPressed: () {Navigator.of(context).pop();},
          //)
        ],);
      },
    );
  }


  Widget showPopUpList(BuildContext context, Bloc bloc, Users loginInfo, String showScreen, String orderNum) {
    double hgt = showScreen == 'ADDTOCART' ? 400 : 420;
    double wdt = showScreen == 'ADDTOCART' ? 300 : 360;

    return Container( width: wdt, height: hgt, 
        // decoration: BoxDecoration(border: Border.all(color: Colors.blueGrey), 
        //               shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(5.0)),
        padding: EdgeInsets.only(left:5.00, right:5.00),
        //elevation: 24,
        child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[ 
              //dispProductDetails(context, bloc, grItem.quantity.toString(), grItem.productCode),
              showScreen == 'ADDTOCART' ? dispProductDetails(context, bloc, loginInfo) : dispSummaryDetails(context, bloc, loginInfo, orderNum),
            ]
          )
    );
  }  

  Widget saveProductCodeBtn(BuildContext context, Bloc bloc, Users loginInfo)
  {   
    return Container( child: 
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            FlatButton(child: Text('CANCEL',style: TextStyle(color: Colors.blue),),
              onPressed: () { Navigator.of(context).pop();},),
            FlatButton( child: Text( 'SAVE', style: TextStyle(color: Colors.blue),),
            onPressed: ()
              {
                Navigator.of(context).pop();               
                bloc.addSEDetails(loginInfo);
                // bloc.clearDisplay4SE();
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
                        seQtyFld(bloc),                    
                        seProductCodeDD(bloc),
                        Row( children: <Widget>[ 
                          Expanded(flex:5, child:seSellingRate(bloc)),
                          SizedBox(width: 8.0),
                          Expanded(flex:5, child: seUOMDD(bloc)),
                          SizedBox(width: 15.0,)
                        ]),                          
                          seDiscountType(bloc),
                          seDiscountAmt(bloc),
                          //saveProductCodeBtn(context, bloc, prodCode)                                  
                          saveProductCodeBtn(context, bloc, loginInfo)                                  
                      ],
                    ),        
                    ),
              ),
    );
  }  

  dispSummaryDetails(BuildContext context, Bloc bloc, Users loginInfo,String orderNum)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 5.0),
        summaryFields(context, bloc, loginInfo, orderNum) 
      ],
    );        
  }  


  Widget summaryFields(BuildContext context, Bloc bloc, Users loginInfo, String orderNum)
  {
    double fldHeight = 16.0;
    bool isPaidAmtCanEdit = (orderNum == "");

    return StreamBuilder(
      stream: bloc.seDetails,
      builder: (context, ssSEDtl) {
        bool gotData = ssSEDtl.hasData;
        return Container(height: 370, width: 350, padding: EdgeInsets.only(top:5.0),
          child:ListTile(
            title: Column(children: <Widget>[
              SizedBox(height: 5.0),
              Row(children: <Widget>[   
                Expanded(flex:5, child: Text('Total Amt:',style: TextStyle(color: Colors.black, fontSize: fldHeight),)),
                Expanded(flex:5, child: Text((gotData ?  bloc.getAmt('TOTAL', isPaidAmtCanEdit).toString() : ""),style: TextStyle(color: Colors.black, fontSize: fldHeight) )),
              ]),
              SizedBox(height: 5.0),
              Row(children: <Widget>[
                Expanded(flex:5, child: Text('Discount Amt:' ,style: TextStyle(color: Colors.black,fontSize: fldHeight),)),
                Expanded(flex:5, child: Text( (gotData ?  bloc.getAmt('DISCOUNT', isPaidAmtCanEdit).toString() : ""),style: TextStyle(color: Colors.black,fontSize: fldHeight) )),
              ]),
              Row(children: <Widget>[   
                Expanded(flex:4, child: Text('Vat 7%:',style: TextStyle(color: Colors.black,fontSize: fldHeight),)),
                Expanded(flex:2, child: seVatchkBox(bloc)),
                Expanded(flex:4, child: Text( (gotData ? bloc.getAmt('VAT', isPaidAmtCanEdit).toString() : ""),style: TextStyle(color: Colors.black,fontSize: fldHeight),)),                        
              ]),
              Row(children: <Widget>[
                Expanded(flex:4, child: Text('WH Tax %:',style: TextStyle(color: Colors.black,fontSize: fldHeight),)),
                Expanded(flex:2, child: seWHVatChkBox(bloc)),
                Expanded(flex:4, child: Text( (gotData ? bloc.getAmt('WHTAX', isPaidAmtCanEdit).toString() : ""),style: TextStyle(color: Colors.black,fontSize: fldHeight),)),                        
              ]),              
              Row(children: <Widget>[   
                Expanded(flex:5, child: Text('Net Amt:',style: TextStyle(color: Colors.black,fontSize: fldHeight),)),
                Expanded(flex:5, child: Text((gotData ?  bloc.getAmt('NET', isPaidAmtCanEdit).toString() : ""),style: TextStyle(color: Colors.black,fontSize: fldHeight) )),
              ]),
              Row(children: <Widget>[   
                Expanded(flex:5, child: Text('Paid Amt:' ,style: TextStyle(color: Colors.black,fontSize: fldHeight),)),
                Expanded(flex:5, child: sePaidAmtTxtFld(bloc, isPaidAmtCanEdit)),
              ]),
              SizedBox(height: 5.0),
              Row(children: <Widget>[   
                Expanded(flex:5, child: Text('Balance Amt:' ,style: TextStyle(color: Colors.black,fontSize: fldHeight),)),
                Expanded(flex:5, child: Text( (gotData ?  bloc.getAmt('BALANCE', isPaidAmtCanEdit).toString() : ""),style: TextStyle(color: Colors.black,fontSize: fldHeight) )),
              ]),  
              SizedBox(height: 10.0),      
              Row(children: <Widget>[   
                Expanded(flex:4, child: backBtn(context)),               
                Expanded(flex:2, child: Text("")),
                Expanded(flex:4, child: payBtn(context, bloc, loginInfo, orderNum)),                
              ]),                        
            ])
            
          ));
        }
      );
  }

// Main button to save Sales Entry  
  payBtn(BuildContext context, Bloc bloc, Users loginInfo,String orderNum)
  {
    bool isAddNew = (orderNum == "");

    return  RaisedButton(      
      child: Text('SAVE',style: TextStyle(color: Colors.white,fontSize: 18.0),),
      color: isAddNew ? Color(0xffd35400) : Colors.grey,
      onPressed: ()async { 
          if(isAddNew) {
            SalesEntryApi seAPI = new SalesEntryApi();
            await seAPI.saveSalesEntry(bloc.getSalesEntry(loginInfo,orderNum))
            .then((isSuccess) { if(isSuccess) 
              { StaticsVar.showAlert(context,'Sales Entry Saved'); 
                bloc.clearSalesEntry();
                Navigator.push(context, MaterialPageRoute(builder: (context) => SalesEntryList(loginInfo: loginInfo))); 
                }},
              onError: (e) {StaticsVar.showAlert(context, e.toString());} )
            .catchError((onError) {StaticsVar.showAlert(context, onError.toString());});    
          } else {StaticsVar.showAlert(context, "$orderNum is in View mode, Cannot Save!");}
          },
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

  seVatchkBox(Bloc bloc)
  {   
    return StreamBuilder<bool>(
      stream: bloc.seVat,
      builder:(context,snapshot){
        return Checkbox(
            checkColor: Colors.black,
            activeColor: Colors.grey,
            onChanged: bloc.seVatChanged,
            value: (snapshot.data == null) ? false : snapshot.data,
        );
      });

  }

  seWHVatChkBox(Bloc bloc)
  {   
    return StreamBuilder(
      stream: bloc.seWitHld,
      builder:(context,snapshot){
        return SizedBox(
          height: 80.0,
          child:Checkbox(
            checkColor: Colors.black,
            activeColor: Colors.grey,
            value:(snapshot.data == null) ? false : snapshot.data,
            onChanged: bloc.seWitHldChanged,
            //unInvData[index].isChecked,
          )
        );
      });
  }

  
  sePaidAmtTxtFld(Bloc bloc, bool isPaidAmtCanEdit)
  { 
    TextEditingController _controller = new TextEditingController();
    return StreamBuilder<String>(
      stream: bloc.sePaidAmnt,
      builder:(context,snapshot){
         if(snapshot.hasData)
         {_controller.value = _controller.value.copyWith(text: snapshot.data.toString(), 
                                selection: new TextSelection.collapsed(offset: snapshot.data.length)); }        
        return TextField(
          enabled: isPaidAmtCanEdit,
          style: TextStyle(fontSize: 20.0),
          keyboardType: TextInputType.numberWithOptions(),
          textDirection: prefix0.TextDirection.ltr,
          // textDirection: prefix0.TextDirection.ltr,
          // decoration: InputDecoration(labelText: 'Paid Amount:'),
           controller: _controller,
          onChanged: bloc.sePaindAmntChanged,
        );
      });
  }