import 'package:flutter/material.dart';

class DiscountPopup extends StatefulWidget {
  @override
  _DiscountPopupState createState() => _DiscountPopupState();
}

class _DiscountPopupState extends State<DiscountPopup> {


  //  onSwitchValueChanged(bool newVal) {
  //         {
  //           //val = newVal;
  //         }

  //         // setState((){val =newVal;});
  //       }
  // var _items = [
  //   'Currency',
  //   '%',
  // ];
  // String _itemSelected;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //theme: new ThemeData(primaryColor: Color.fromRGBO(58, 66, 86, 1.0)),
      home: Scaffold(
       // backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        //backgroundColor: Colors.orange,
        appBar: AppBar(
          title: Text('Discount'),
          backgroundColor: Color(0xffd35400),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 220.0, left: 5.0, right: 5.0),
            child: Card(
              //  margin: EdgeInsets.only(left: 10.0,right: 10.0),

              elevation: 10,

              child: Column(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,

                

                children: <Widget>[
                  //  SizedBox(height: 25.0,),
                  // SizedBox(
                  //   width: 300.0,
                  //   child: TextField(
                  //     decoration: InputDecoration(hintText: 'Product Code'),
                  //   ),
                  // ),

                 // SizedBox(height: 25.0,),
                  // SizedBox(width:300.0,child: TextField(decoration: InputDecoration( hintText: 'Description'),),),
                            Text('Add Discount',style: TextStyle(fontStyle: FontStyle.normal,fontSize: 25.0),),
                            SizedBox(height: 25.0,),
                            Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      
                      
                        // SizedBox(width:50.0,child: Switch(
                        //   value: null,
                        //   onChanged: (newVal) {
                        //   //  onSwitchValueChanged(newVal);
                        //   },
                        //  ), ),
                      

                      SizedBox(
                        width: 20.0,
                      ),
                      SizedBox(
                        width: 80.0,
                        child: TextField(
                          decoration: InputDecoration(labelText: 'Percentage%'),
                        ),
                      ),

                      //   SizedBox(height: 50.0,),
                      // Text('This discount will be applied to all items',style: TextStyle(fontSize: 15.0),),
                    ],
                  ),
                  SizedBox(height: 25.0,),
                  Text('This discount will be applied to all items',style: TextStyle(fontSize: 15.0),),
                  // SizedBox(height: 25.0,),

                     Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      FlatButton(
                        //color: Colors.black,
                        child: Text(
                          'CANCEL',
                          style: TextStyle(color: Colors.blue),
                        ),
                        onPressed: () {},
                      ),

                      //  SizedBox(width: 100.0,),

                      FlatButton(
                     //   padding: EdgeInsets.only(left: 150.0),
                        // color: Colors.blue,
                        child: Text(
                          'SAVE',
                          style: TextStyle(color: Colors.blue),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  )
                ],

                //  TextField(decoration: InputDecoration( hintText: 'Category Code'),),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
