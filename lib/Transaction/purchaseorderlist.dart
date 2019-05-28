import 'package:flutter/material.dart';
import 'package:split/Bloc/Bloc.dart';
import 'package:split/Bloc/provider.dart';
import 'package:split/Transaction/transaction.dart';
import 'package:split/purchaseorder.dart';
import 'package:split/src/APIprovider/purchaseOrderApiProvider.dart';
import 'package:split/src/Models/loginmodel.dart';
import 'package:intl/intl.dart';


class PurchaseOrderList extends StatefulWidget
{
  final  Users loginInfo;
  PurchaseOrderList({Key key, @required this.loginInfo}) :super(key: key);
  @override
  _ListCardsState createState() => _ListCardsState();
}

class _ListCardsState extends State<PurchaseOrderList>
 {
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of(context);
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffd35400),
        title: Text('Purchase Order'),
        leading: IconButton(
        icon: Icon(Icons.arrow_back),
        color: Colors.white,
        onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context) => Transaction(loginInfo: widget.loginInfo,)));},
          ),
        ),
        body: Container( height: 600.0,child: listTile(bloc),),
        floatingActionButton: FloatingActionButton(heroTag: 'btn1',
        backgroundColor:Color(0xffd35400),  child: Icon(Icons.add),  onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> PurchaseOrder(loginInfo: widget.loginInfo,)));},
        ),
      ); 
}

  Widget listTile(Bloc bloc) 
  {
    PurchaseOrederApi poApi = new PurchaseOrederApi();
    return FutureBuilder(
      future: poApi.pOList(),
       builder: (context, sspo)
       {
         if (sspo.hasData) {
         return ListView.builder(
          itemCount: sspo.data.length,
          itemBuilder: (context, index)
         {
          return Container(height: 100.0,padding: EdgeInsets.only(top:15.0),
          child: Card( 
          margin: EdgeInsets.only(right: 5.0, left: 5.0),
          elevation: 10.0,
          child: ListTile(
            title:Row(children: <Widget>[
              Expanded(flex: 5,child: Text('PO No.:')),
              Expanded(flex: 5,child: Text( sspo.data[index].poNo.trim()),)
              ],),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => 
                    PurchaseOrder(loginInfo: widget.loginInfo,poNum: sspo.data[index].poNo.trim())));
                  },
                  trailing:
                  //  Column(
                  //   children: <Widget>[
                      Text(sspo.data[index].isCancel ? "DELETED" : 'ACTIVE',style: TextStyle(color: Colors.red),),
                      // SizedBox.shrink(child: IconButton(
                      //   icon:  Icon(Icons.delete),
                      //   onPressed: () 
                      //   async {
                      //     PurchaseOrederApi poApi = new PurchaseOrederApi();
                      //     await (poApi.delPoList(sspo.data[index].branchId,sspo.data[index].poNo,widget.loginInfo.userID)).then((onValue)
                      //     {
                      //       if(onValue == true){
                      //       Navigator.push(context, MaterialPageRoute(builder: (context)=> PurchaseOrderList(loginInfo: widget.loginInfo,)));
                      //       }else {return  Exception('Loading Failed');}
                      //     }
                      //   );
                      // },) ),
                  //   ],
                  // ),
                  subtitle: Container(
                  child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(flex: 5,child: Text('PO Date.:')),
                        // SizedBox(width: 10.0,),
                        Expanded(flex: 5,child: Text(DateFormat('dd/MM/yyyy').format(sspo.data[index].poDate).toString(),),)
                    ],),
                    Row(children: <Widget>[
                      Expanded(flex: 5,child: Text('Customer Name:')),
                      Expanded(flex: 5,child: Text(sspo.data[index].supplierName),),
                      Expanded(flex: 1,child:  IconButton(
                        icon:  Icon(Icons.delete),
                        onPressed: () 
                        async {
                          print('DELETED PO ACTIVATED....');
                          PurchaseOrederApi poApi = new PurchaseOrederApi();
                          await (poApi.delPoList(sspo.data[index].branchId,sspo.data[index].poNo,widget.loginInfo.userID)).then((onValue)
                          {
                            if(onValue == true){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> PurchaseOrderList(loginInfo: widget.loginInfo,)));
                            }else {return  Exception('Loading Failed');}
                          }
                        );
                      },
                      ) ),
                      ],
                    ),
                    ],
                  )
                ),
              )
            ),
          )
          );
        }
                        );
          } else {return Center(child: CircularProgressIndicator(),);}
        });
    }

  }