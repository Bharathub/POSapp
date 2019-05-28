import 'package:flutter/material.dart';
import 'package:split/src/Models/loginmodel.dart';
import 'stockinquiry.dart'as stockinquiry;
import 'invoiceinquiry.dart'as invoiceinquiry;



class InquiryTab extends StatefulWidget {

    final Users loginInfo;
  InquiryTab({Key key, @required this.loginInfo}) :super(key: key);


  @override
  _InquiryTabState createState() => _InquiryTabState();
}

class _InquiryTabState extends State<InquiryTab>with SingleTickerProviderStateMixin {

  TabController controller;
  @override
  void initState(){
    super.initState();
    controller = new TabController(vsync:this, length: 2 );


  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inquiry'), backgroundColor: Color(0xffd35400),
    //backgroundColor: Colors.blue,

    bottom: new TabBar( 
      controller: controller,
      tabs: <Widget>[
      
       new Tab(icon: Icon(Icons.receipt),text: 'Stock',),
       new Tab(icon: Icon(Icons.table_chart),text: 'Invoice'),
       //new Tab(icon: Icon(Icons.payment),),

      ],

    ),
    ),
    
      

      body:  TabBarView(
        controller: controller,
        children: <Widget>[

          stockinquiry.StockInquiry(loginInfo: widget.loginInfo,),
          invoiceinquiry.InvoiceInquiry(loginInfo: widget.loginInfo,),
     


        ],

   

        
        
        ) ,

     
      
    );
  }
}