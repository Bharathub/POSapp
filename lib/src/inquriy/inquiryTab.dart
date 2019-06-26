import 'package:flutter/material.dart';
import 'package:split/appdrawer.dart';
import 'package:split/src/Models/loginmodel.dart';
import 'package:split/src/inquriy/stockinquiry.dart';

import 'invoiceinquiry.dart';

class Inquirys extends StatefulWidget {

  final Users loginInfo;
  Inquirys({Key key, @required this.loginInfo}) :super(key: key);

  State<StatefulWidget> createState() { return _InquirysState();}
}

class _InquirysState extends State<Inquirys> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Inquiry"),
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
                  onPressed: () { Navigator.push(context,MaterialPageRoute(builder: (context) => StockInquiry(loginInfo: widget.loginInfo)));},
                  child: Text('Stock Inquiry',style: TextStyle(fontSize: 25.0),),
            )),
            Divider(),
            listIcons( new FlatButton(
                  onPressed: () { Navigator.push(context,
                        MaterialPageRoute(builder: (context) => InvoiceInquiry(loginInfo: widget.loginInfo)));},
                  child: Text('Invoice Inquiry',style: TextStyle(fontSize: 25.0),),
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
