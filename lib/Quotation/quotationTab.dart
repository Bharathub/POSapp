import 'package:flutter/material.dart';
//import 'package:split/Bloc/Bloc.dart';
import 'package:split/Quotation/customerQuotationList.dart' as customerQuotationList ;
import 'package:split/Quotation/supplierQuotationLIst.dart' as supplierQuotationLIst;
import 'package:split/appdrawer.dart';
import 'package:split/src/Models/loginmodel.dart';
//import 'standardquotation2.dart' as standardquotation2;
import 'standardquotationList.dart'as standardquotation2 ;
// import 'customoertariff.dart'as customertariff;
// import 'suppliertariff.dart' as suppliertariff;
//import 'package:split/standardquotation.dart'as standardquotation;

class QuotationTab extends StatefulWidget {

  final Users loginInfo;
  final int tabIndexno;
  QuotationTab({Key key, @required this.loginInfo,this.tabIndexno}) :super(key: key);

  @override
  _QuotationTabState createState() => _QuotationTabState();
}

class _QuotationTabState extends State<QuotationTab>with SingleTickerProviderStateMixin {

  TabController controller;
  
  @override
  void initState(){
    super.initState();
    controller = new TabController(vsync:this, length:3, initialIndex: widget.tabIndexno);
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    //final bloc = new Bloc();

    // initbloc.initCustomerList();
    // initbloc.initProductList();
    // CustomerApiProvider custAPI = new CustomerApiProvider();
    // //List<Customer> customers = 
    // custAPI.customerList().then((onValue){return onValue;});

    return Scaffold(
      appBar: AppBar(title: Text('Quotation'), backgroundColor: Color(0xffd35400),
    //backgroundColor: Colors.blue,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        color: Colors.white,
        onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context) => AppDrawer(loginInfo: widget.loginInfo)));},
      ),

      bottom: new TabBar( 
          controller: controller,
          tabs: <Widget>[
          new Tab(icon: Icon(Icons.receipt,size: 20.0,),text: 'Standard',),
          new Tab(icon: Icon(Icons.receipt,size: 20.0,),text: 'Customer',),
          new Tab(icon: Icon(Icons.table_chart,size: 20.0,),text: 'Supplier',),
          ],
        ),
      ),
      
      body:  TabBarView(
        controller: controller,
        children: <Widget>[
          standardquotation2.Standardquotation2(loginInfo: widget.loginInfo,),
          customerQuotationList.CustomerQuotationList(loginInfo: widget.loginInfo), 
                                                      // customers: ( new List<Customer>.from(bloc.initCustomerList())),
                                                      // products: ( new List<Product>.from(bloc.initProductList()))),
          supplierQuotationLIst.SupplierQuotationList(loginInfo: widget.loginInfo,),
          // customertariff.CustomerList(),
          // suppliertariff.SupplierCards(),

        ],
      ) ,
    );
  }
}