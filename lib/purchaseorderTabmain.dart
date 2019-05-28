// import 'package:flutter/material.dart';
// import 'package:split/src/Models/loginmodel.dart';
// //import './paymentpage1.dart' as paymentpage1;
// //import './bookinghistory.dart'as bookinghistory;
// //import 'driverrating.dart'as driverrating;
// import 'purchaseorder.dart' as purchaseorder;
// import 'productdetailtable.dart' as productdetailtable;

// class Purchasemain extends StatefulWidget {

  
//   final Users loginInfo;
//   Purchasemain({Key key, @required this.loginInfo}) :super(key: key);
//   @override
//   _PurchasemainState createState() => _PurchasemainState();
// }

// class _PurchasemainState extends State<Purchasemain>with SingleTickerProviderStateMixin {

//    TabController controller;
//   @override
//   void initState(){
//     super.initState();
//     controller = new TabController(vsync:this, length: 2 );


//   }
//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();

//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Purchase Orders'), backgroundColor: Color(0xffd35400),
//     //backgroundColor: Colors.blue,

//     bottom: new TabBar( 
//       controller: controller,
//       tabs: <Widget>[
      
//        new Tab(icon: Icon(Icons.receipt),text: 'Purchase Order',),
//        new Tab(icon: Icon(Icons.table_chart),text: 'Product List',),
//        //new Tab(icon: Icon(Icons.payment),),

//       ],

//     ),
//     ),
    
      

//       body:  TabBarView(
//         controller: controller,
//         children: <Widget>[

//           purchaseorder.PurchaseOrder(loginInfo: widget.loginInfo,),
//           productdetailtable.ProductTable(loginInfo: widget.loginInfo,),


//         //  paymentpage1.PaymentPage1(),
//         //    bookinghistory.BookingHistory(),
//         //    driverrating.DriverRating()


//         ],

   

        
        
//         ) ,

     
      
//     );
//   }
// }