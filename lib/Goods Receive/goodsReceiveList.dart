import 'package:flutter/material.dart';
import 'package:split/Bloc/Bloc.dart';
import 'package:split/Bloc/provider.dart';
import 'package:split/Transaction/transaction.dart';
import 'package:split/src/APIprovider/goodsReceiveApiProvider.dart';
import 'package:split/src/Models/loginmodel.dart';
import 'package:intl/intl.dart';

import 'goodreceivedomestic.dart';


class GoodsReceiveList extends StatefulWidget
{
  final  Users loginInfo;
  GoodsReceiveList({Key key, @required this.loginInfo}) :super(key: key);
  @override
  _ListCardsState createState() => _ListCardsState();
}

class _ListCardsState extends State<GoodsReceiveList>
 {
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of(context);
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffd35400),
        title: Text('Goods Receive'),
        leading: IconButton(
        icon: Icon(Icons.arrow_back),
        color: Colors.white,
        onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context) => Transaction(loginInfo: widget.loginInfo,)));},
          ),
        ),
        body: Container( height: 600.0,child: listTile(bloc),),
        floatingActionButton: FloatingActionButton(heroTag: 'btn1',
        backgroundColor:Color(0xffd35400),  child: Icon(Icons.add),  onPressed: (){
        bloc.clearGoodsReceivr();
        Navigator.push(context, MaterialPageRoute(builder: (context)=> GoodsReceive(loginInfo: widget.loginInfo,)));},
        ),
      ); 
}

  Widget listTile(Bloc bloc) 
  {
    GoodsReceiverApi grApi = new GoodsReceiverApi();
    return FutureBuilder(
      future: grApi.goodsReceiveList(),
      builder: (context, ssGR)
       {
         if (ssGR.hasData) {
         return ListView.builder(
          itemCount: ssGR.data.length,
          itemBuilder: (context, index) {
          return Container(height: 100.0,padding: EdgeInsets.only(top:15.0),
          child: Card( 
          margin: EdgeInsets.only(right: 5.0, left: 5.0),
          elevation: 10.0,
          child: ListTile(
          title:Row(children: <Widget>[
            Expanded(flex: 5,child: Text('Document No.:')),
            Expanded(flex: 5,child: Text( ssGR.data[index].documentNo.trim()),)
          ],),
          // onTap: (){
          //   Navigator.push(context, MaterialPageRoute(builder: (context) => 
          //   GoodsReceive(loginInfo: widget.loginInfo,poNum: ssGR.data[index].documentNo.trim())));
          // },
          // trailing: Column(
          //   children: <Widget>[
          //     // Text(ssGR.data[index].poStatus ? "ACTIVE" : 'DELETED',style: TextStyle(color: Colors.red),),
          //     SizedBox.shrink(child: IconButton(
          //       icon:  Icon(Icons.delete),
          //       onPressed: () 
          //       async {
          //         PurchaseOrederApi poApi = new PurchaseOrederApi();
          //         await (poApi.delPoList(ssGR.data[index].branchId,ssGR.data[index].poNo,widget.loginInfo.userID)).then((onValue)
          //         {
          //           if(onValue == true){
          //           Navigator.push(context, MaterialPageRoute(builder: (context)=> GoodsReceiveList(loginInfo: widget.loginInfo,)));
          //           }else {return  Exception('Loading Failed');}
          //         }
          //       );
          //     },) ),
          //   ],
          // ),
          subtitle: Container(
          child: Align(
          alignment: Alignment.topLeft,
          child: Column(
          children: <Widget>[
             Row(children: <Widget>[
              Expanded(flex: 5,child: Text('SupplierName:')),
              Expanded(flex: 5,child: Text(ssGR.data[index].supplierName),),
      ],),
            Row(
              children: <Widget>[
                Expanded(flex: 5,child: Text('Recv. Date:')),
                // SizedBox(width: 10.0,),
                Expanded(flex: 5,child: Text(DateFormat('dd/MM/yyyy').format(ssGR.data[index].documentDate).toString(),),)
            ],),
      //       Row(children: <Widget>[
      //         Expanded(flex: 5,child: Text('Customer Name:')),
      //         Expanded(flex: 5,child: Text(ssGR.data[index].supplierName),),
      // ],),
       ],)),)),));}
                );
          } else {return Center(child: CircularProgressIndicator(),);}
        });
    }

  }