import 'package:flutter/material.dart';
import 'package:split/Bloc/Bloc.dart';
import 'package:split/Bloc/provider.dart';
import 'package:split/Quotation/supplierquetationtariff.dart';
import 'package:split/src/APIprovider/quotationApiProvider.dart';
import 'package:split/src/Models/loginmodel.dart';
import 'package:split/Bloc/CommonVariables.dart';
import 'package:intl/intl.dart';

class SupplierQuotationList extends StatefulWidget {

  final Users loginInfo;
  SupplierQuotationList({Key key, @required this.loginInfo}) :super(key: key);

  @override
  _CustomerQuotationListState createState() => _CustomerQuotationListState();
}

class _CustomerQuotationListState extends State<SupplierQuotationList>
{

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of(context);
    
    return Scaffold(
      body: Container(height: 550.0, child: listTile(bloc, widget.loginInfo),),
      floatingActionButton: FloatingActionButton( heroTag: 'Supplier',
      backgroundColor:  Color(0xffd35400),
      child: Icon(Icons.add),
      onPressed:(){Navigator.push(context, MaterialPageRoute(builder: (context)=>
        SuppliertariffQuotation(loginInfo:widget.loginInfo, quotNo: "",)));
        },
      ),
      );
  }
}

Widget listTile(Bloc bloc, Users loginInfo) 
{
  QuotationApiProvider qtApi = new QuotationApiProvider();
  return FutureBuilder(
          future: qtApi.quotationSupplierList(StaticsVar.branchID),
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
          title: Row(
            children: <Widget>[
                Expanded(flex: 5,child:Text('QuotationNo:' ),),
                Expanded(flex: 5,child:Text(ssQut.data[index].quotationNo),)
                 ],
            ),
          onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => 
                    SuppliertariffQuotation(loginInfo: loginInfo, quotNo: ssQut.data[index].quotationNo)));},
          trailing: Column(
            children: <Widget>[
            Text(ssQut.data[index].status ? "ACTIVE" : 'DELETED',style: ssQut.data[index].status ? TextStyle(color: Colors.red) : TextStyle(color: Colors.green)),
        ],), 
          subtitle: Container(
          child: Align(
          alignment: Alignment.topLeft,
          child: Column(
             children: <Widget>[
               Row(
                 children: <Widget>[
                  Expanded(flex: 5,child: Text('Supplier Name:')),
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
                  // SizedBox(width: 10.0,),
                  Expanded(flex: 5,child: Text(DateFormat('dd/MM/yyyy').format(ssQut.data[index].expiryDate).toString()),),
                  Expanded(flex:0,
                  child:  IconButton(               
                  icon: ssQut.data[index].status ? Icon(Icons.delete) : Container(),
                  onPressed: ()async
                  {
                    QuotationApiProvider quotApi = new QuotationApiProvider();
                    await (quotApi.delQuotList(loginInfo.userID,ssQut.data[index].branchId,ssQut.data[index].quotationNo)).then((onValue)
                          {
                            if(onValue == true){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> SupplierQuotationList(loginInfo: loginInfo,)));
                            }else {return  Exception('Loading Failed');}
                          }
                        );
                  } 
            ),)
               ],),
                            ],)),)),));}
              );
        } else {
          return Center(child: CircularProgressIndicator(),);}
      });
}

