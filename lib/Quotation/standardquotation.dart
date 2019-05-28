// import 'package:flutter/material.dart';
// // import 'package:autocomplete_textfield/autocomplete_textfield.dart';
// // import 'package:http/http.dart' as http;
// // import 'dart:convert';
// import 'package:intl/intl.dart';
// import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
// import 'package:split/Bloc/Bloc.dart';
// //import 'package:quotationpopup.dart';
// import 'package:split/appdrawer.dart';
// import 'package:split/src/APIprovider/currencyApiProvider.dart';
// import 'package:split/src/APIprovider/masterProductApiProvider.dart';
// import 'package:split/src/Models/currencyModel.dart';
// import 'package:split/src/Models/loginmodel.dart';
// import 'package:split/src/Models/productModel.dart';

// class StandarQuotation extends StatefulWidget {

//   final Users loginInfo;
//   StandarQuotation({Key key, @required this.loginInfo}) :super(key: key);

//   @override
//   _StandarQuotationState createState() => _StandarQuotationState();
// }

// class _StandarQuotationState extends State<StandarQuotation> {
//   final bloc = Bloc();
//   var items;
//   final formats = { InputType.date: DateFormat('dd/MM/yyyy'),};
//   InputType inputType = InputType.date;
//   bool editable = true;
//   DateTime date;
//   @override
//   Widget build(BuildContext context) {
//     return  new Scaffold(
//         appBar: new AppBar(
          
//           title: new Text("Standards Tariff"),
//           backgroundColor: Color(0xffd35400),         
//           leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           color: Colors.white,
//           onPressed: () {
//               Navigator.push(context,
//               MaterialPageRoute(builder: (context) => AppDrawer(loginInfo: widget.loginInfo,)));
//             },
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Center(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
               
//                stdQtnFld(bloc),
//                stdEffecDate(bloc),
//                stdExpiryDate(bloc)
              
//               ],
//             ),

            
//           ),
          
//         ),
        

//           floatingActionButton: FloatingActionButton(
//           backgroundColor:  Color(0xffd35400),
//           child: Icon(Icons.add),
//           onPressed: () 
//           {
//             _showDialog(context, bloc);
//           },
//         ),


//       );
      
    
//   }
// }

  


//   dispProductDetails(BuildContext context, Bloc bloc)
//   {
//     return  SingleChildScrollView(
//       child: Container(margin: EdgeInsets.only(top: 120.0, left: 10.0, right: 10.0),
//               child: Center( 
//                       // child: Card(
//                       //         elevation: 10,
//                               child: Column(
//                                 children: <Widget>[
//                                   stdqtnProdCodPopUp(bloc),
//                                   stdQtnpopupPaymentTerm(bloc),
//                                   stdqtnSellRtPopUp(bloc),
//                                   saveFlatbtn(context, bloc),
//                                 ],
//                               ),
//                       // )
//                     ),
//               ),
//     );

//   }


  

//   stdqtnProdCodPopUp(Bloc bloc)
//   {  
//     ProductApiProvider wlApi = new ProductApiProvider();
//     //LookUpApiProvider proApi = LookUpApiProvider();
                        
//     return StreamBuilder<String>(
//       stream: bloc.qSProdCode,
//       builder: (context,snapshot)
//       {
//       return FutureBuilder(
//         future: wlApi.productList(),
//         builder: (context,ssWLDD)
//         { 
//         if (ssWLDD.hasData)
//             {
//             return SizedBox(width: 300, child: InputDecorator(decoration: InputDecoration(labelText: 'Product Code'),
//               child:DropdownButtonHideUnderline(
//                 child:  DropdownButton<String>(
//                 isDense: true,
//                 items: ssWLDD.data
//                 .map<DropdownMenuItem<String>>(
//                 (Product dropDownStringitem){ 
//                   return DropdownMenuItem<String>(
//                     value: dropDownStringitem.productCode.toString(), 
//                     child: Text(dropDownStringitem.description),);},).toList(),
//                     value: snapshot.data,
//                     onChanged: bloc.qSProdCodeChanged,
//                     isExpanded: true,
//                     elevation: 10,
//                   ) ) ) );
//         } else { return CircularProgressIndicator(); }
//             });
//             });
//   }



// stdQtnpopupPaymentTerm(Bloc bloc)
// {
//     CurrencyApiProvider payApi = new CurrencyApiProvider();
//     return StreamBuilder<String>(
//       stream: bloc.qSPayment,
//       builder: (context,snapshot)
//       {
//         return FutureBuilder(
//         future: payApi.currencyList(),
//         builder: (context,ssWLDD)
//         { 
//           if (ssWLDD.hasData)
//           {
//             return SizedBox(width: 300, child: InputDecorator(decoration: InputDecoration(labelText: 'Payment Type'),
//             child:DropdownButtonHideUnderline(
//               child:  DropdownButton<String>(
//                 isDense: true,
//                 items: ssWLDD.data
//                 .map<DropdownMenuItem<String>>((Currency dropDownStringitem)
//                 { return DropdownMenuItem<String>(
//                   value: dropDownStringitem.description.toString(), 
//                   child: Text(dropDownStringitem.description));},
//                 ).toList(),
//               value: snapshot.data,
//               onChanged: bloc.qSPaymentChanged,
//               isExpanded: true,
//               elevation: 10,
//               ) ) ) );
//           } else { return CircularProgressIndicator(); }
//        });
//     });
// }

// stdqtnSellRtPopUp(Bloc bloc)
// {
//   return StreamBuilder<String>(
//             stream: bloc.qSQuotation,
//             builder:(context,snapshot)=>
//             SizedBox(width: 300.0,child: TextField(onChanged: bloc.qSQuotationChanged,
//             keyboardType: TextInputType.numberWithOptions(),
//             decoration: InputDecoration(labelText: 'SellRate'),) ),); 

// }



// Widget saveFlatbtn(BuildContext context, Bloc bloc)
// {   
//   //  QuotationApiProvider uomApi = QuotationApiProvider();
//       return Container(
//             child:  Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: <Widget>[
//             FlatButton(child: Text('CANCEL',style: TextStyle(color: Colors.blue),),
//             onPressed: () {Navigator.pop(context);},),
//             FlatButton( child: Text( 'SAVE', style: TextStyle(color: Colors.blue),),
//             onPressed: (){}
//         //     async{Lookup uomSavDtls = new Lookup();  
//         //           uomSavDtls=bloc.saveLookUpDtls("UOM");
//         //           await uomApi.saveLookUptList(uomSavDtls).then((onValue){
//         //           if(onValue == true){
//         //             Navigator.push(context, MaterialPageRoute(builder: (context)=> UomList(loginInfo:loginInfo,) ));
//         //             }else {return  Exception('Failed to Save UOM');} }
//         //             );
//         // },
//          ),
//             ],
//           ),
//         );
   
// }

// void _showDialog(BuildContext context, Bloc bloc) {
//     // flutter defined function
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         // return object of type Dialog
//         return SimpleDialog(children: <Widget>[ 
//           //showRadioBtn(context),
//           showPopUpList(context, bloc),
//           // new FlatButton(child: new Text("Close",style: txtRoboBoldHiLightColor(25, Colors.blueAccent)),
//           //                onPressed: () {Navigator.of(context).pop();},
//           //)
//         ],);
//       },
//     );
//   }

//   Widget showPopUpList(BuildContext contxt, Bloc bloc) {
//     return Container( width: 250, height: 400, 
//         // decoration: BoxDecoration(border: Border.all(color: Colors.blueGrey), 
//         //               shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(5.0)),
//         padding: EdgeInsets.only(left:10.00, right:5.00),
//         //elevation: 24,
//         child:
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//            dispProductDetails(contxt, bloc),
//           ],
//       )
//     );
//   }

//  stdQtnFld(Bloc bloc)
//  {
//     return StreamBuilder<String>(
//             stream: bloc.qSQuotation,
//             builder:(context,snapshot)=>
//             SizedBox(width: 300.0,child: TextField(onChanged: bloc.qSQuotationChanged,
//              decoration: InputDecoration(labelText: 'Quotation No.'),) ),); 

//  }

//  stdEffecDate(Bloc bloc)
//  {
//    final formats = { InputType.date: DateFormat('dd/MM/yyyy'),};
//   InputType inputType = InputType.date;
//   // bool editable = true;
  
//   return StreamBuilder<DateTime>( 
//         stream: bloc.qSEffecDate,
//         builder:(context,snapshot)=>       
//        SizedBox(width:300,
//           child: new DateTimePickerFormField(
//             inputType: inputType,
//             format: formats[inputType],
//             // editable: editable,
//             initialDate: DateTime.now(),
//             initialValue: DateTime.now(),
//             decoration: const InputDecoration(
//             // prefixIcon: const Icon(Icons.calendar_today, color: Colors.green), 
//             labelText: 'Effective Date',hasFloatingPlaceholder: true
//             ), 
//             onChanged: bloc.qSExprDateChanged
//           ), 
//         ) 
//     );
//  }

//  stdExpiryDate(Bloc bloc)
//  {
//    final formats = { InputType.date: DateFormat('dd/MM/yyyy'),
//   };
//   InputType inputType = InputType.date;
//   bool editable = true;
//   return StreamBuilder<DateTime>( 
//         stream: bloc.qSExprDate,
//         builder:(context,snapshot)=>       
//         SizedBox(width:300,
//           child: new DateTimePickerFormField(
//           inputType: inputType,
//           format: formats[inputType],
//           editable: editable,
//           decoration: const InputDecoration(
//           // prefixIcon: const Icon(Icons.calendar_today, color: Colors.green), 
//           labelText: 'Expiry Date',hasFloatingPlaceholder: true
//             ), 
//             onChanged: bloc.qSExprDateChanged
//           ), 
//         ) 
//     ); 
//  }


 
// // Widget listTile(Bloc bloc, )
// // {
// //   //ProductApiProvider pProductDtApi = new ProductApiProvider();
// //   return StreamBuilder(
// //     stream: bloc.poDetails,
// //     builder: (context, ssPOproDt) {
// //     List poData = ssPOproDt.hasData ? ssPOproDt.data : <PurchaseOrderDetails>[];
// //     //if (poData.) {
// //       return ListView.builder(
// //           itemCount: poData.length,
// //           itemBuilder: (context, index) 
// //           { return Container(height: 150.0,padding: EdgeInsets.only(top:15.0),
// //               child: Card(
// //                 margin: EdgeInsets.only(right: 5.0, left: 5.0),
// //                 elevation: 10.0,
// //                 child: ListTile(
// //                   title: Text('Code:   ' + poData[index].productCode),
// //                   trailing: IconButton( icon: Icon(Icons.delete), onPressed: () { bloc.deletePODetail(poData[index].productCode); StaticsVar.showAlert(context, "Product Deleted"); }),
// //                   subtitle: Container(
// //                     child: Align(
// //                     alignment: Alignment.centerLeft,
// //                       child: Column(
// //                       children: <Widget>[
// //                         //Text('Description:' + poData[index].description),
// //                         Text('Qty:    ' + poData[index].quantity.toString()),
// //                         Text('Unit Price:    ' + poData[index].unitPrice.toString()),
// //                         Text('UOM:    ' + poData[index].uom),

// //                       ],
// //                     )),
// //                   )),
// //               )); 
// //         });
// //     //} else { return Center(child:CircularProgressIndicator());}
// //   });
// // }
