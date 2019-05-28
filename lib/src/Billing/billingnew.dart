import 'package:flutter/material.dart';
import 'package:split/src/Billing/invoice.dart';
import 'package:split/src/Billing/invoiceapproval.dart';
import 'package:split/src/Billing/unbilledinvoices.dart';
import 'package:split/appdrawer.dart';
import 'package:split/src/Models/loginmodel.dart';

class BillingNew extends StatefulWidget {
  final Users loginInfo;
  BillingNew({Key key, @required this.loginInfo}) : super(key: key);
  @override
  _BillingNewState createState() => _BillingNewState();
}

class _BillingNewState extends State<BillingNew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Billing"),
        backgroundColor: Color(0xffd35400),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AppDrawer(
                          loginInfo: widget.loginInfo,
                        )));
          },
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            listIcons(
              // Text(''),
              // SizedBox(
                // height: 150.0,
                // width: 450.0,
                // child: 
                FlatButton(
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Invoice(
                                  loginInfo: widget.loginInfo,
                                )));
                  },
                  child: Text(
                    'Invoice',
                    style: TextStyle(fontSize: 25.0),
                  ),
                ),
              // ),
              // Text(''),
            ),
            Divider(),
            listIcons(
              // Text(''),
              // SizedBox(
              //   height: 150.0,
              //   width: 450.0,
              //   child: 
                FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InvoiceApproval(
                                  loginInfo: widget.loginInfo,
                                )));
                  },
                  child: Text(
                    'Invoice Approval',
                    style: TextStyle(fontSize: 25.0),
                  ),
                ),
              // ),
              // Text(''),
            ),
            Divider(),
            listIcons(
              // Text(''),
              // SizedBox(
              //   height: 150.0,
              //   width: 450.0,
              //   child:
                 FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UnbilledInvoices(
                                  loginInfo: widget.loginInfo,
                                )));
                  },
                  child: Text(
                    'Unbilled Invoices',
                    style: TextStyle(fontSize: 25.0),
                  ),
                ),
              // ),
              // Text(''),
            ),
          ],
        ),
      ),
    );
  }
}

Widget listIcons(
  // title,
  leading,
  // subtitle,
) {
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
