import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:split/src/Billing/billingnew.dart';
import 'package:split/Masterdata/masterdatatab.dart';
import 'package:split/Quotation/quotationTab.dart';
import 'package:split/Transaction/transaction.dart';
import 'package:split/inquriy/inquirymaintab.dart';
import 'package:split/main.dart';
import 'package:split/src/Models/loginmodel.dart';
import 'package:split/src/speed_dial.dart';
import 'package:split/src/speed_dial_child.dart';
import 'package:percent_indicator/percent_indicator.dart';

class AppDrawer extends StatefulWidget {

  final Users loginInfo;
  AppDrawer({Key key, @required this.loginInfo}) :super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> with TickerProviderStateMixin {

  String name;
  // DateTime now = DateTime.now();

  //ScrollController _scrollController;
  bool _dialVisible = true;

  // initState() {
  //   super.initState();

  //   _scrollController = ScrollController()
  //     ..addListener(() {
  //       _setDialVisible(_scrollController.position.userScrollDirection ==
  //           ScrollDirection.forward);
  //     });
  // }

  // _setDialVisible(bool value) {
  //   setState(() {
  //     _dialVisible = value;
  //   });
  // }

  _renderSpeedDial() {
    return SpeedDial(
      backgroundColor: Color(0xffd35400),
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      // child: Icon(Icons.add),
      // onOpen: () => print('OPENING DIAL'),
      // onClose: () => print('DIAL CLOSED'),
      visible: _dialVisible,
      curve: Curves.bounceIn,
      children: [
        SpeedDialChild(
          child: Icon(Icons.shopping_basket, color: Colors.white),
          backgroundColor: Colors.deepOrange,
           onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>Transaction(loginInfo: widget.loginInfo) )),
          label: 'Transaction',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.deepOrangeAccent,
        ),
        // SpeedDialChild(
        //   child: Icon(Icons.present_to_all, color: Colors.white),
        //   backgroundColor: Colors.green,
        //   // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>Email() )),
        //   label: 'Products',
        //   labelStyle: TextStyle(fontWeight: FontWeight.w500),
        //   labelBackgroundColor: Colors.greenAccent,
        //   onTap: () => Navigator.push(context,
        //       MaterialPageRoute(builder: (context) => ProductMaster())),
        // ),
        SpeedDialChild(
          child: Icon(Icons.receipt, color: Colors.white),
          backgroundColor: Colors.green,
           onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>BillingNew(loginInfo: null,))),
          label: 'Billing',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.greenAccent,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Dashboard'),
          backgroundColor: Color(0xffd35400),
          elevation:
              defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today), title: Text('Day')),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today), title: Text('Week')),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today), title: Text('Month')),
          ],
        ),
        floatingActionButton: _renderSpeedDial(),
        drawer: mainDrawer(widget.loginInfo),
        body: SingleChildScrollView(
          child: new Container(
            child: new Column(
              children: <Widget>[
                progressBar(
                    Colors.white,
                    Colors.yellowAccent,
                    Colors.blue[300],
                    EdgeInsets.only(
                      left: 200.0,
                    ),
                    Text('32,000'),
                    'Revenue',
                    'Total revenue generated.'),
                SizedBox(
                  height: 15.0,
                ),
                progressBar(
                    Color(0xffecf0f1),
                    Color(0xff2c3e50),
                    Color(0xff7f8c8d),
                    EdgeInsets.only(
                      right: 200.0,
                    ),
                    Text('58'),
                    'Products',
                    'total stock of all the products'),
                SizedBox(
                  height: 100.0,
                ),
              ],
            ),
          ),
        ));
  }

  /* *********** Widget for the Drawer START **************/

  Widget mainDrawer(Users loginInfo) {
    return Drawer(
        //Useing drawer menu
      child: new ListView(children: <Widget>[
      Column(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: new Text(
              'Logicon Global',
            ),
            accountEmail: new Text('logiconglobal@gmail.com'),
            currentAccountPicture: new CircleAvatar(
              child: Text('VirgoLeo'),
              // backgroundImage: new NetworkImage(
              //     'http://logiconglobal.com/images/icon-10.png'),
              // child: Text('L'
              // ),
            ),
            decoration: new BoxDecoration(
              color: Color(0xff009432),
              // image: new DecorationImage(
              //     image: new NetworkImage(
              //         'http://logiconglobal.com/images/slider1.jpg'
              //         //"https://img00.deviantart.net/35f0/i/2015/018/2/6/low_poly_landscape__the_river_cut_by_bv_designs-d8eib00.jpg"
              //         ),
              // fit: BoxFit.fill),
              // ),
            ),
          ),
          new ListTile(
            title: new Text('DashBoard'),
            subtitle: Text('Master Data, Dashboard.'),
            leading: new Icon(Icons.home), //Creating icons here
            onTap: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => AppDrawer()));
            },
          ),
          new ListTile(
            title: new Text('Master Data'),
            subtitle: Text('Look-ups Maintenance.'),
            leading: new Icon(Icons.settings),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MasterDataTab(loginInfo: widget.loginInfo)));
            },
          ),
          new ListTile(
            title: new Text('Quotation'),
            subtitle: Text('Quotations Maintenance.'),
            leading: new Icon(Icons.settings),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => QuotationTab(loginInfo: widget.loginInfo,tabIndexno:0)));
            },
          ),
          new ListTile(
            title: new Text('Transaction'),
            subtitle: Text('purchase order/receive goods'),
            leading: new Icon(Icons.settings),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Transaction(loginInfo: widget.loginInfo)));
            },
          ),

          new ListTile(
            title: new Text('Billing'),
            subtitle: Text('invoices/invoice approval'),
            leading: new Icon(Icons.settings),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BillingNew(loginInfo: widget.loginInfo)));
            },
          ),
          new ListTile(
            title: new Text('Inquiry'),
            subtitle: Text('inquiry orders/invoices'),
            leading: new Icon(Icons.receipt),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => InquiryTab(loginInfo: widget.loginInfo)));
            },
          ),
          new ListTile(
            title: new Text('Reports'),
            subtitle: Text('Browse through sales & stock report.'),
            leading: new Icon(Icons.format_list_bulleted),
            // onTap: () => Navigator.of(context).pop(),
          ),
          new ListTile(
            title: new Text('Setup'),
            subtitle: Text('Cofigure your register,VAT info.'),
            leading: new Icon(Icons.settings),
            onTap: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => FetchBranchList(loginInfo: widget.loginInfo,)));
            },
          ),
          new Divider(
            color: Colors.black,
          ),
          new ListTile(
            title: Text('Logout'),
            leading: new Icon(Icons.arrow_back),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyHomePage()));
            },
          ),
        ],
      ),
    ]));
  }

  /* *********** Widget for the Drawer END   **************/

  /* *********** Widget for PROGRESSBAR STARTS  **************/
  Widget progressBar( backgroundColor, progressColor, color, padding, center, progressheader, progressfooter)
  {
    return SizedBox(
        height: 220.0,
        width: 500.0,
        child: Card(
          elevation: 10.0,
          // height: 230.0,
          // width: 500.0,
          // padding: padding,

          child: new CircularPercentIndicator(
            animation: true,
            animationDuration: 1000,
            header: Text(progressheader,
                style: TextStyle(
                    color: Colors.black,
                    fontStyle: FontStyle.normal,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            footer: Text(progressfooter),
            radius: 150.0,
            percent: 0.7,
            backgroundColor: backgroundColor,
            progressColor: progressColor,
            center: center,
            lineWidth: 20.0,
            circularStrokeCap: CircularStrokeCap.round,

            //For animation
          ),
          color: color,
        ));
  }
  /* *********** Widget for PROGRESSBAR ENDS  **************/
}
