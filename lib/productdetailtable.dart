// import 'package:flutter/material.dart';
// import 'package:split/Bloc/Bloc.dart';
// import 'package:split/Bloc/provider.dart';
// import 'package:split/src/APIprovider/masterProductApiProvider.dart';
// import 'package:split/src/Models/loginmodel.dart';
// // import 'package:split/Bloc/providers.dart';

// // void main() => runApp(new ProductTable()); //one-line function

// class ProductTable extends StatefulWidget {

//   final Users loginInfo;
//   ProductTable({Key key, @required this.loginInfo}) :super(key: key);
//   @override
//   _ListCardsState createState() => _ListCardsState();
// }

// class _ListCardsState extends State<ProductTable> {
//   @override
//   Widget build(BuildContext context) {

//     var bloc = Provider.of(context);

//     return Scaffold(
//       body: 
//       // Container(
//       //   child: Column(children: <Widget>[
//           Container(child: listTile(bloc,),),

        
  

//           floatingActionButton: FloatingActionButton(backgroundColor:Color(0xffd35400),  child: Icon(Icons.add),  onPressed: (){
//           Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetails(loginInfo: widget.loginInfo,)));


//         },  ),

//     ); 
// }

// Widget listTile(Bloc bloc, )
//  {
//   ProductApiProvider pProductDtApi = new ProductApiProvider();

//   return FutureBuilder(
//       future: pProductDtApi.productList(),
//       builder: (context, ssPOproDt) {
//         if (ssPOproDt.hasData) {
//           return ListView.builder(
//               itemCount: ssPOproDt.data.length,
//               itemBuilder: (context, index) {
//                 return Container(height: 100.0,padding: EdgeInsets.only(top:15.0),child:  Card(
                  
//                   margin: EdgeInsets.only(right: 5.0, left: 5.0),
//                   elevation: 10.0,
//                   child: ListTile(
//                       title: Text('Code:   '     +
//                           ssPOproDt.data[index].productCode),
//                       trailing: IconButton(
//                         icon: Icon(Icons.delete),
//                         onPressed: () {},
//                       ),
//                       subtitle: Container(
//                         child: Align(
//                             alignment: Alignment.centerLeft,
//                             child: Column(
//                               children: <Widget>[
//                                 //  Align( alignment: Alignment(0.0,55.0),),

//                                 Text('Description:   ' +
//                                     ssPOproDt.data[index].description),
                            
//                                 Text('Barcode:         ' +
//                                     ssPOproDt.data[index].barCode),
//                               ],
//                             )),
//                       )),
//                ) );
              
//               }
//               );
//         } else {
//           return CircularProgressIndicator();
//         }
//       });
// }



// }



// // import 'package:flutter/material.dart';
// // import 'package:split/productdetailspopup.dart';
// // import 'package:split/purchasepopup.dart';
// // //import 'package:split/purchasepopup.dart';
// // //import 'package:split/appdrawer.dart';
// // //import 'package:split/productmaster.dart';
// // //import 'package:split/productmaster.dart';

// // void main() => runApp(new ProductTable()); //one-line function

// // class ProductTable extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return new MaterialApp(
// //       title: "",
// //       home: new Scaffold(
// //         body: SingleChildScrollView(
// //           child: Container(
// //             color: Color(0xffecf0f1),
// //             // child: Column(
// //             //   crossAxisAlignment: CrossAxisAlignment.stretch,
// //             //   children: <Widget>[
// //             child: new Column(
// //               children: <Widget>[
// //                 SizedBox(
// //                   height: 10.0,
// //                 ),
// //                 listTile(Text('Pen\nPencil\nBook'), Text('Product')),
// //                 SizedBox(
// //                   height: 15.0,
// //                 ),
// //                 listTile(Text('33\n22\n55'), Text('Quentity')),
// //                 SizedBox(
// //                   height: 15.0,
// //                 ),
// //                 listTile(Text('UNIT\nUNIT\nUNIT'), Text('UOM')),
// //                 SizedBox(
// //                   height: 15.0,
// //                 ),
// //                 listTile(Text('THB\nTHB\nTHB'), Text('Currency')),
// //                 SizedBox(
// //                   height: 15.0,
// //                 ),
// //                 listTile(Text('25.00\n50.00\n55.00'), Text('Unit Price')),
// //                 SizedBox(
// //                   height: 15.0,
// //                 ),

// //                 Divider(
// //                   color: Colors.red,
// //                   height: 25.0,
// //                 ),


// //                 RaisedButton(    color:  Color(0xffd35400),
// //                           elevation: 5.0,
// //                   child: Text('CONFIRM',style:TextStyle(color:Colors.white)), onPressed: (){
// //                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Purchasepopup()));
                    

// //                   },)

          
// //               ],
// //             ),
// //             //   ],
// //             // ),
// //           ),
// //         ),
// //           floatingActionButton: FloatingActionButton(backgroundColor:Color(0xffd35400),  child: Icon(Icons.add),  onPressed: (){
// //           Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetails()));


// //         },  ),

// //       ),
// //     );
// //   }
// // }

// // Widget listTile(subtitle, title) {
// //   return SizedBox(
// //       height: 90,
// //       child: Card(
// //         margin: EdgeInsets.only(right: 10.0, left: 10.0),
// //         elevation: 10.0,
// //         child: ListTile(
// //           title: title,
// //           trailing: IconButton(
// //             icon: Icon(Icons.delete),
// //             onPressed: () {},
// //           ),
// //           subtitle: subtitle,
// //         ),
// //       ));
// // }



            
