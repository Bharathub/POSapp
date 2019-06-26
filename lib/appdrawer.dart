import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:split/Bloc/Bloc.dart';
import 'package:split/Bloc/provider.dart';
import 'package:split/src/APIprovider/dashBoardApiProvider.dart';
import 'package:split/src/Billing/billingnew.dart';
import 'package:split/Masterdata/masterdatatab.dart';
import 'package:split/Quotation/quotationTab.dart';
import 'package:split/Transaction/transaction.dart';
import 'package:split/src/Models/dashBoardModel.dart';
// import 'package:split/src/Models/dashBoardModel.dart';
import 'package:split/src/inquriy/inquiryTab.dart';
import 'package:split/main.dart';
import 'package:split/src/Models/loginmodel.dart';
// import 'package:split/src/speed_dial.dart';
// import 'package:split/src/speed_dial_child.dart';
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
  // bool _dialVisible = true;
  DashBoardApi dashBoardApi = new DashBoardApi();
  // final bloc = Bloc();

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

  // _renderSpeedDial() {
  //   return SpeedDial(
  //     backgroundColor: Color(0xffd35400),
  //     animatedIcon: AnimatedIcons.menu_close,
  //     animatedIconTheme: IconThemeData(size: 22.0),
  //     // child: Icon(Icons.add),
  //     // onOpen: () => print('OPENING DIAL'),
  //     // onClose: () => print('DIAL CLOSED'),
  //     visible: _dialVisible,
  //     curve: Curves.bounceIn,
  //     children: [
  //       SpeedDialChild(
  //         child: Icon(Icons.shopping_basket, color: Colors.white),
  //         backgroundColor: Colors.deepOrange,
  //          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>Transaction(loginInfo: widget.loginInfo) )),
  //         label: 'Transaction',
  //         labelStyle: TextStyle(fontWeight: FontWeight.w500),
  //         labelBackgroundColor: Colors.deepOrangeAccent,
  //       ),
  //       // SpeedDialChild(
  //       //   child: Icon(Icons.present_to_all, color: Colors.white),
  //       //   backgroundColor: Colors.green,
  //       //   // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>Email() )),
  //       //   label: 'Products',
  //       //   labelStyle: TextStyle(fontWeight: FontWeight.w500),
  //       //   labelBackgroundColor: Colors.greenAccent,
  //       //   onTap: () => Navigator.push(context,
  //       //       MaterialPageRoute(builder: (context) => ProductMaster())),
  //       // ),
  //       SpeedDialChild(
  //         child: Icon(Icons.receipt, color: Colors.white),
  //         backgroundColor: Colors.green,
  //          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>BillingNew(loginInfo: null,))),
  //         label: 'Billing',
  //         labelStyle: TextStyle(fontWeight: FontWeight.w500),
  //         labelBackgroundColor: Colors.greenAccent,
  //       ),
  //     ],
  //   );
  // }
  int _bottomNavBarIndex = 0;

  @override
  Widget build(BuildContext context) {    
    var bloc = Provider.of(context);
    if(_bottomNavBarIndex == 0) { bloc.fetchDashBoardDetails(1);}

    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Dashboard'),
          backgroundColor: Color(0xffd35400),
          elevation:
              defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _bottomNavBarIndex,
          onTap: (int index){
            // print('index'+ (index + 1).toString());
             setState(() {
             _bottomNavBarIndex = index; 
             bloc.fetchDashBoardDetails((index + 1));
              // currentIndex: index;             
            //  bloc.fetchDashBoardDetails(2);
            //  bloc.fetchDashBoardDetails(3);
             });
          },
          
            // type: BottomNavigationBarType.fixed,
          //  backgroundColor: Colors.t,
          // iconSize: 10.0,
          selectedItemColor: Colors.amber,
          unselectedItemColor: Colors.black,
          // selectedFontSize: 25.0,
          items: <BottomNavigationBarItem> [          
            BottomNavigationBarItem(
                title: Text('Day'),
                icon: Icon(Icons.calendar_today,)
                // icon: IconButton(icon: Icon(Icons.calendar_today,),onPressed: (){bloc.fetchDashBoardDetails(1);})
                ),
            BottomNavigationBarItem(
                title: Text('Week'),
                icon: Icon(Icons.calendar_today,)
                // icon: IconButton(icon: Icon(Icons.calendar_today), onPressed: (){bloc.fetchDashBoardDetails(2);})
                ),
            BottomNavigationBarItem(
                title: Text('Month'),
                icon: Icon(Icons.calendar_today,)
                // icon: IconButton(icon: Icon(Icons.calendar_today), onPressed: (){bloc.fetchDashBoardDetails(3);})
                ),
                
          ],         
         
        ),
        // floatingActionButton: _renderSpeedDial(),
        drawer: mainDrawer(bloc, widget.loginInfo),
        body: SingleChildScrollView(
          child: new Container(
            child: new Column(
              children: <Widget>[
                listTile(bloc),
                SizedBox(
                  height: 100.0,
                ),
              ],
            ),
          ),
        ));
  }

  /* *********** Widget for the Drawer START **************/

  Widget mainDrawer(Bloc bloc, Users loginInfo) {
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
                  MaterialPageRoute(builder: (context) => Inquirys(loginInfo: widget.loginInfo)));
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
             _showDialog(context,bloc);
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (context) => MyHomePage()));
            },
          ),
        ],
      ),
    ]));
  }

  Widget logoutFlatbtn(BuildContext context, Bloc bloc)
  {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          FlatButton(child: Text('CANCEL',style: TextStyle(color: Colors.blue),),
            onPressed: () {Navigator.of(context).pop();},),
          FlatButton( child: Text( 'YES', style: TextStyle(color: Colors.blue),),
            onPressed: (){   Navigator.push(
                   context, MaterialPageRoute(builder: (context) => MyHomePage()));}
          ),
        ],
      ),
    );
  }
  
  void _showDialog(BuildContext context, Bloc bloc) 
  {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(children: <Widget>[ 
          showPopUpList(context, bloc),        
        ],);
      },
    );
  }

  Widget showPopUpList(BuildContext contxt, Bloc bloc) 
  {
    return Container( 
      width: 150, height: 100, 
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            dispProductDetails(contxt, bloc),
          ],
      )
    );
  }

  dispProductDetails(BuildContext contxt,Bloc bloc)
  {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
        Text('Are You Sure You Want To Logout ?',textAlign: TextAlign.right),
        SizedBox(height: 20.0,),
        logoutFlatbtn(contxt,bloc),
      ],
      ),
    );
  }

  listTile(Bloc bloc)
  {
    
    DashBoards dbMod;
    String totInvs ="0.0";
    String totPurs = "0.0";
    String totGR = '0.0';

    return StreamBuilder(
      stream: bloc.dashBoard,
      builder: (context, ssDashBoard) 
      {
        if(ssDashBoard.hasData)
        { 
          dbMod = ssDashBoard.data; 
          totInvs = dbMod.totalInvoice.toString(); 
          totPurs = dbMod.totalPurchases.toString();
          totGR = dbMod.totalGr.toString();
        }
          return Container(
            height: 750.0,padding: EdgeInsets.only(top:15.0),
            child: Column( children: <Widget>[
              SizedBox(
                height: 220.0,
                width: 500.0,
                child: Card(
                  elevation: 10.0,
                  child: new CircularPercentIndicator(
                  animation: true,
                  animationDuration: 1000,
                  header: Text('Total Purchases',
                  style: TextStyle(
                    color: Colors.black,
                    fontStyle: FontStyle.normal,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
                  footer: Text('Total Purchases generated'),
                  radius: 150.0,
                  percent: double.parse(totPurs.substring(0,1)).round()/10,
                  backgroundColor: Colors.white,
                  progressColor: Colors.yellowAccent,
                  center:  Text(totPurs),
                  lineWidth: 20.0,
                  circularStrokeCap: CircularStrokeCap.round,
                  ),
                  color:  Colors.blue[300],
                ),                                  
              ),
              SizedBox(
                height: 220.0,
                width: 500.0,
                child: Card(
                  elevation: 10.0,
                  child: new CircularPercentIndicator(
                  animation: true,
                  animationDuration: 1000,
                  header: Text('Total Invoice',style: TextStyle(
                          color: Colors.black,
                          fontStyle: FontStyle.normal,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  footer: Text('Total amount of all the Invoices'),
                  radius: 150.0,
                  percent: double.parse(totInvs.substring(0,1)).round()/10,
                  backgroundColor: Color(0xffecf0f1),
                  progressColor: Color(0xff2c3e50),
                  center:  Text(totInvs),
                  lineWidth: 20.0,
                  circularStrokeCap: CircularStrokeCap.round,
                  ),
                  color: Color(0xff7f8c8d),
                ),                                  
              ),   
               SizedBox(
                height: 220.0,
                width: 500.0,
                child: Card(
                  elevation: 10.0,
                  child: new CircularPercentIndicator(
                  animation: true,
                  animationDuration: 1000,
                  header: Text('Total Goods Receive',style: TextStyle(
                          color: Colors.black,
                          fontStyle: FontStyle.normal,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  footer: Text('Total Goods Receive'),
                  radius: 150.0,
                  percent: double.parse(totGR.substring(0,1)).round()/10,
                  backgroundColor: Colors.black,
                  progressColor: Colors.lightGreenAccent,
                  center:  Text(totGR),
                  lineWidth: 20.0,
                  circularStrokeCap: CircularStrokeCap.round,
                  ),
                  color: Colors.blueGrey,
                ),                                  
              )  
          ])
      );
      // }
    });
  }

}