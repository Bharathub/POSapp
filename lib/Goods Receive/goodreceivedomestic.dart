import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:split/Bloc/Bloc.dart';
import 'package:split/Bloc/CommonVariables.dart';
import 'package:split/Bloc/provider.dart';
import 'package:split/Goods%20Receive/goodsReceiveList.dart';
import 'package:split/Transaction/transaction.dart';
import 'package:split/src/APIprovider/goodsReceiveApiProvider.dart';
import 'package:split/src/Models/goodsReceiveModel.dart';
import 'package:split/src/Models/loginmodel.dart';
import 'package:split/src/Models/suppliermodel.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';




class GoodsReceive extends StatefulWidget {
  
  final Users loginInfo;
  final String documentNo;
  GoodsReceive({Key key, @required this.loginInfo, this.documentNo}) :super(key: key);
  @override
  _GoodsReceive createState() => _GoodsReceive();
}

class _GoodsReceive extends State<GoodsReceive> 
{
  int intCount = 0;

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of(context);
    bool isInEditMode = (widget.documentNo != "");

      intCount = intCount+1; print('No Of Times Executed: ' + intCount.toString()); 
      if(intCount==1) {bloc.initiateSuppliers(true); bloc.fetchGoodsReceive(widget.documentNo);}
    
    return MaterialApp(
      theme: ThemeData(backgroundColor: Color(0xffd35400),
          brightness: Brightness.light,
          primaryColor: Colors.deepOrangeAccent,
          accentColor: Colors.deepPurple),
          home: Scaffold( 
             appBar: AppBar(
            backgroundColor: Color(0xffd35400),
            title: Text('Goods Receive'),
            leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context) => GoodsReceiveList(loginInfo: widget.loginInfo,)));},
            ),
          ),  
         body: SingleChildScrollView(
          // child: Center(
            child: Container(
              // padding: EdgeInsets.all(45.0),
              child:Card(margin: EdgeInsets.only(left: 10.0,right: 10.0),
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(children: <Widget>[
                      Expanded(flex: 8, child: Container(padding: EdgeInsets.only(right: 25.0,left: 25.0),child: poNotxtFld(bloc),),),
                      Expanded(flex: 2, child:IconButton(icon: Icon(Icons.search),
                              onPressed: (){bloc.getPODetilsforGoodsReceive();},),),
                       ],),
                    Row(children: <Widget>[ Expanded(flex: 8, child: Container(padding: EdgeInsets.only(right: 25.0,left: 25.0),child: goodsRecNOFld(bloc)))]),  
                    Row(children: <Widget>[ Expanded(flex: 8, child: Container(padding: EdgeInsets.only(right: 25.0,left: 25.0),child: grDateFld(bloc,isInEditMode)))]),  
                    Row(children: <Widget>[ Expanded(flex: 8, child: Container(padding: EdgeInsets.only(right: 25.0,left: 25.0),child: grSupplerDD(bloc)))]),  
                    Divider(color: Colors.red,height: 15.0,),
                    Container(height: 300, child: listTile(bloc)),
                  ],
                )
              ),
            ),
          // ),
        ),
        bottomNavigationBar:saveGRBtn(context,bloc,widget.loginInfo),
      ),
    );
  }
}

  poNotxtFld(Bloc bloc,)
  {    
    TextEditingController _controller = new TextEditingController();
     return StreamBuilder<String>(
            stream: bloc.gRPOno,
            builder: (context,snapshot){
               if(snapshot.hasData)
      {_controller.value = _controller.value.copyWith(text: snapshot.data.toString());}
           return SizedBox(width: 300.0,
              child: TextField(
                controller: _controller,
                onChanged: bloc.gRPOnoChanged,
                decoration: InputDecoration(labelText:'PO No.'),) );} );
               

  }

  goodsRecNOFld(Bloc bloc)
  {
    TextEditingController _controller = new TextEditingController();
    return StreamBuilder<String>(
                stream: bloc.gRProdRectNO,
                builder:(context,snapshot){
                   if(snapshot.hasData)
      {_controller.value = _controller.value.copyWith(text: snapshot.data.toString());}
               return SizedBox(width: 300.0,
                child: TextField(
                  controller: _controller,
                  onChanged: bloc.gRProdRectNOeChanged, 
                  enabled: false,
                  decoration: InputDecoration(labelText: 'Goods Receive No./Product recept number'),) );});
  }
  
  grDateFld(Bloc bloc,bool isEditable)
  {
    TextEditingController _controller = new TextEditingController();
    final formats = { InputType.date: DateFormat('dd/MM/yyyy'),};
    InputType inputType = InputType.date;
    // bool editable = true;
     return StreamBuilder<DateTime>( 
        stream: bloc.gRDate,
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
            // prefixIcon: const Icon(Icons.calendar_today, color: Colors.green), 
            labelText: 'Date',hasFloatingPlaceholder: true
            ), 
            controller: _controller,
            onChanged: bloc.effectivePromoChanged
          ), 
        );} 
    );
    
  }

  grSupplerDD(Bloc bloc)
  {
    bloc.initiateSuppliers(false);
    //SupplierApiProvider wlApi = new SupplierApiProvider();
    return StreamBuilder<String>(
    stream: bloc.gRVendor,
    builder: (context,snapshot)
    {
      return StreamBuilder(
        stream: bloc.initSuppliers,
        builder: (context,ssWLDD)
        { 
        if (ssWLDD.hasData)
        {
          return SizedBox(width: 300, child: InputDecorator(decoration: InputDecoration(labelText: 'Supplier'),
          child:DropdownButtonHideUnderline(
          child:  DropdownButton<String>(
          isDense: true,
          items: ssWLDD.data
            .map<DropdownMenuItem<String>>(
            (Supplier dropDownStringitem){ 
            return DropdownMenuItem<String>(
            value: dropDownStringitem.customerCode.trim(), 
            child: Text(dropDownStringitem.customerName));},
              ).toList(),
              value: snapshot.data,
              onChanged: bloc.gRVendorChanged,
              isExpanded: true,
              elevation: 10,
            ) ) ) );
        } else { return CircularProgressIndicator(); }
      });
    });

  }

  grReceivedQty(Bloc bloc)
  {
    return StreamBuilder<String>(
      stream: bloc.gRReceivedQty,
      builder:(context,snapshot)=>
      SizedBox(width: 150.0,
        child: TextField(onChanged: bloc.gRReceivedQtyChanged,
               keyboardType: TextInputType.numberWithOptions(),                     
              decoration: InputDecoration(labelText: 'Received Qty: '),) ),);
  }

  saveGRBtn(BuildContext context, Bloc bloc, Users loginInfo)
  {
    return ButtonTheme(
      minWidth: 250.0,
      child: RaisedButton(
        color: Color(0xffd35400),
        elevation: 5.0,
        child: Text('SAVE', style: TextStyle(color: Colors.white),),
        onPressed: () async { 
          GoodsReceiverApi grAPI = new GoodsReceiverApi();
          await grAPI.saveGoodsReceiver(bloc.getSaveGoodsReceiver(loginInfo))
          .then((isSuccess) { if(isSuccess) 
            { StaticsVar.showAlert(context,'Good Received Saved'); 
              Navigator.push(context, MaterialPageRoute(builder: (context) => Transaction(loginInfo: loginInfo))); 
              }},
            onError: (e) {StaticsVar.showAlert(context, e.toString());} )
          .catchError((onError) {StaticsVar.showAlert(context, onError.toString());});    
        },
      )
    );
  }

  Widget listTile(Bloc bloc)
  {
    //ProductApiProvider pProductDtApi = new ProductApiProvider();
    return StreamBuilder(
      stream: bloc.gRItems,
      builder: (context, ssPOproDt) {
      List grData = ssPOproDt.hasData ? ssPOproDt.data : <GoodsReceiveItems>[];
      //if (grData.) {
        return ListView.builder(
            itemCount: grData.length,
            itemBuilder: (context, index) 
            { 
              return grData[index].status ? Container(height: 115.0,padding: EdgeInsets.only(top:15.0),
                child: Card(
                  margin: EdgeInsets.only(right: 8.0, left: 8.0),
                  elevation: 10.0,
                  child: ListTile(
                    title: Text('Product : ' + grData[index].productDescription),
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                      IconButton( icon: Icon(Icons.edit), 
                                onPressed: () { 
                                  _showDialog(context, bloc, grData[index] );}),
                     IconButton( icon: Icon(Icons.delete), 
                                onPressed: () { bloc.deleteGrItems(grData[index].productCode);
                                StaticsVar.showAlert(context, "GoodsItem Deleted");
                                  }),             

                    ],),
                    subtitle: Container(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: 
                            Column(children: <Widget>[
                              Row(children: <Widget>[
                                  Expanded(flex: 4,child: Text('Qty:' )),
                                  Expanded(flex: 4,child:Text(grData[index].quantity.toString())),
                                  
                                    // SizedBox(width:40.0),
                                    //
                              ]),
                              Row(children: <Widget>[
                                Expanded(flex: 4,child: Text('Received Qty:')),
                                Expanded(flex: 4,child: Text(grData[index].receiveQuantity.toString())),
                              ],),
                               Row(children: <Widget>[
                                Expanded(flex: 4,child: Text('UOM:')),
                                Expanded(flex: 4,child: Text(grData[index].uom.toString())),
                              ],),
                              Row( children: <Widget>[
                                 Expanded(flex: 4,child: Text('Pending Qty:')),
                                 Expanded(flex: 4,child: Text(grData[index].pendingQuantity.toString())),
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

  _showDialog(BuildContext context, Bloc bloc, GoodsReceiveItems grItem) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return SimpleDialog(children: <Widget>[ 
          //showRadioBtn(context),
          showPopUpList(context, bloc, grItem),
          // new FlatButton(child: new Text("Close",style: txtRoboBoldHiLightColor(25, Colors.blueAccent)),
          //                onPressed: () {Navigator.of(context).pop();},
          //)
        ],);
      },
    );
  }

  Widget showPopUpList(BuildContext context, Bloc bloc, GoodsReceiveItems grItem) {
    return Container( width: 200, height: 180, 
        // decoration: BoxDecoration(border: Border.all(color: Colors.blueGrey), 
        //               shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(5.0)),
        padding: EdgeInsets.only(left:5.00, right:5.00),
        //elevation: 24,
        child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[ 
              dispProductDetails(context, bloc, grItem.quantity.toString(), grItem.productCode),
            ]
          )
    );
  }  

  Widget saveProductCodeBtn(BuildContext context, Bloc bloc, String prodCode)
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
                bloc.editGoodsReceiverItem(prodCode);
              }, 
            ),
          ],
        ),
      );
  }

  dispProductDetails(BuildContext context, Bloc bloc, String qnty, String prodCode)
  {
    return  SingleChildScrollView(
      child: Container(margin: EdgeInsets.only(top: 2.0, left: 2.0, right: 2.0),
              child: Center( 
                      // child: Card(
                              // elevation: 10,
                              child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 20.0),
                                  Text("Quantity: " + qnty),
                                  SizedBox(height: 5.0),
                                  grReceivedQty(bloc),
                                  saveProductCodeBtn(context, bloc, prodCode)                                  
                                ],
                              ),
                      )
                    // ),
              ),
    );

  }


