import 'package:flutter/material.dart';
import 'package:split/Bloc/Bloc.dart';
import 'package:split/Bloc/provider.dart';
import 'package:split/Quotation/customerquotationtariff.dart';
import 'package:split/src/APIprovider/quotationApiProvider.dart';
import 'package:split/src/Models/customermodel.dart';
import 'package:split/src/Models/loginmodel.dart';
import 'package:split/Bloc/CommonVariables.dart';
import 'package:intl/intl.dart';
import 'package:split/src/Models/productModel.dart';

class CustomerQuotationList extends StatefulWidget {

  final Users loginInfo;
  final List<Customer> customers;
  final List<Product> products;
  CustomerQuotationList({Key key, @required this.loginInfo, this.customers, this.products}) :super(key: key);

  @override
  _CustomerQuotationListState createState() => _CustomerQuotationListState();
}

class _CustomerQuotationListState extends State<CustomerQuotationList>
{
  
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of(context);
    
    return Scaffold(
      body: Container(height: 550.0, child: listTile(bloc,widget.loginInfo, widget.customers, widget.products),),   
      floatingActionButton: FloatingActionButton(
      backgroundColor:  Color(0xffd35400),
      child: Icon(Icons.add),
      onPressed:(){
        Navigator.push(context, MaterialPageRoute(builder: (context) => 
          CustomertariffQuotation( loginInfo:widget.loginInfo, 
                                    quotNo: "", 
                                    customers: widget.customers, 
                                    products: widget.products)
        )
        );
      }
    ),
    );
  }
}

Widget listTile(Bloc bloc,Users loginInfo, List<Customer> customers, List<Product> products)
{
  QuotationApiProvider qtApi = new QuotationApiProvider();
  return FutureBuilder(
          future: qtApi.quotationCustomerList(StaticsVar.branchID),
          builder: (context, ssQut) {
          if (ssQut.hasData) {
          return ListView.builder(
          itemCount: ssQut.data.length,
          itemBuilder: (context, index) {
          return Container(height: 110.0,padding: EdgeInsets.only(top:15.0),
          child: Card( 
          margin: EdgeInsets.only(right: 5.0, left: 5.0),
          elevation: 10.0,
          child: ListTile(
          title:Row(
            children: <Widget>[
              Expanded(flex: 5,child:Text('Quotation No. :' ),),
              Expanded(flex: 5,child:Text(ssQut.data[index].quotationNo.trim()),)
                ],
            ),
            onTap:(){
              Navigator.push(context, MaterialPageRoute(builder: (context) =>
              CustomertariffQuotation(loginInfo: loginInfo, quotNo: ssQut.data[index].quotationNo, customers: customers, products: products,)));
             },     
          trailing:Column(children: <Widget>[
           Text(ssQut.data[index].status ? "ACTIVE" : 'DELETED',style: TextStyle(color: Colors.red),),
          SizedBox.shrink(child:  IconButton(
            icon: Icon(Icons.delete),
            onPressed: ()async
            {
              QuotationApiProvider quotApi = new QuotationApiProvider();
              await (quotApi.delQuotList(loginInfo.userID,ssQut.data[index].branchId,ssQut.data[index].quotationNo)).then((onValue)
                  {
                    if(onValue == true){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> CustomerQuotationList(loginInfo: loginInfo,)));
                    }else {return  Exception('Loading Failed');}
                  }
                  );
            },
           ) ),
            
          ],),
          subtitle: Container(
          child: Align(
          alignment: Alignment.topLeft,
          child: Column(
             children: <Widget>[
               Row(
                 children: <Widget>[
                  Expanded(flex: 5,child: Text('Customer Name:')),
                  // SizedBox(width: 10.0,),
                  Expanded(flex: 5,child: Text(ssQut.data[index].customerName)),
               ],),
               Row(
                 children: <Widget>[
                  Expanded(flex: 5,child: Text('Effective Date:')),
                  // SizedBox(width: 10.0,),
                  Expanded(flex: 5,child: Text(DateFormat('dd/MM/yyyy').format(ssQut.data[index].effectiveDate).toString()),),
               ],),
               Row(
                 children: <Widget>[
                  Expanded(flex: 5,child: Text('Expiry Date:')),
                  //  SizedBox(width: 10.0,),
                  Expanded(flex: 5,child: Text(DateFormat('dd/MM/yyyy').format(ssQut.data[index].expiryDate).toString()),),
                  ],),   
              ],)),)),));}
            );
        } else {
          return Center(child: CircularProgressIndicator(),);}
      });
}

