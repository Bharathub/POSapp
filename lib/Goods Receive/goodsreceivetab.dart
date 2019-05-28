import 'package:flutter/material.dart';
import 'package:split/src/Models/loginmodel.dart';


import 'adddetails.dart' as adddetails;
import 'goodreceivedomestic.dart' as goodreceivedomestic ;



class GoodsTab extends StatefulWidget {
  
  final Users loginInfo;
  GoodsTab({Key key, @required this.loginInfo}) :super(key: key);
  @override
  _GoodsTabState createState() => _GoodsTabState();
}

class _GoodsTabState extends State<GoodsTab>with SingleTickerProviderStateMixin {

  TabController controller;
  @override
  void initState(){
    super.initState();
    controller = new TabController(vsync:this, length: 2 );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Goods Receive'), backgroundColor: Color(0xffd35400),
                bottom: new TabBar( 
                  controller: controller,
                  tabs: <Widget>[
                    new Tab(icon: Icon(Icons.receipt),text: 'Goods Receive',),
                    new Tab(icon: Icon(Icons.table_chart),text: 'Add Details',),
                  //new Tab(icon: Icon(Icons.payment),),
                  ],
                ),
              ),
      body: TabBarView(
            controller: controller,
            children: <Widget>[
              goodreceivedomestic.GoodsReceive(loginInfo: widget.loginInfo,),
              adddetails.AddDetails(),
            ],
        ) ,
    );
  }

}