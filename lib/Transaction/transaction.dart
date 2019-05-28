import 'package:flutter/material.dart';
import 'package:split/Goods%20Receive/goodsReceiveList.dart';
import 'package:split/Transaction/purchaseorderlist.dart';
import 'package:split/Transaction/salesEntryList.dart';
import 'package:split/appdrawer.dart';
import 'package:split/src/Models/loginmodel.dart';

class Transaction extends StatefulWidget {

  final Users loginInfo;
  Transaction({Key key, @required this.loginInfo}) :super(key: key);

  State<StatefulWidget> createState() { return _TransactionState();}
}

class _TransactionState extends State<Transaction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Transaction"),
        backgroundColor: Color(0xffd35400),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AppDrawer(loginInfo: widget.loginInfo)));
          },
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            listIcons( new FlatButton(
                  onPressed: () { Navigator.push(context,MaterialPageRoute(builder: (context) => PurchaseOrderList(loginInfo: widget.loginInfo)));},
                  child: Text('Purchase Order',style: TextStyle(fontSize: 25.0),),
            )),
            Divider(),
            listIcons( new FlatButton(
                  onPressed: () { Navigator.push(context,
                        MaterialPageRoute(builder: (context) => GoodsReceiveList(loginInfo: widget.loginInfo)));},
                  child: Text('Goods Receiver',style: TextStyle(fontSize: 25.0),),
            )),
            Divider(),
            listIcons( new FlatButton(
                onPressed:(){ Navigator.push(context,MaterialPageRoute(builder: (context) => SalesEntryList(loginInfo: widget.loginInfo)));},
                child: Text('Sales Entry',style: TextStyle(fontSize: 25.0),),                
            )),
        ],
        ),
      ),
    );
  }
}

//Widget listIcons(Widget title, Widget leading, Widget subtitle)
Widget listIcons(Widget leading)
{
  return SizedBox(
      height: 90.0, 
      child: Card(
        margin: EdgeInsets.only(right: 10.0, left: 10.0),
        elevation: 10.0,
        child: ListTile(
          // title: title,
          // subtitle: subtitle,
          leading: leading,
        ),
      ));
}
