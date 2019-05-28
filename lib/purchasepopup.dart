import 'package:flutter/material.dart';

class Purchasepopup extends StatefulWidget {
  @override
  _PurchasepopupState createState() => _PurchasepopupState();
}

class _PurchasepopupState extends State<Purchasepopup> {


  @override
  Widget build(BuildContext context) {
    return Container(
      //theme: new ThemeData(primaryColor: Color.fromRGBO(58, 66, 86, 1.0)),
      child: Scaffold(
       // backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        //backgroundColor: Colors.orange,
        appBar: AppBar(
          title: Text('Purchase Order'),
          backgroundColor: Color(0xffd35400),
        ),
        body: SingleChildScrollView(
          child: Column(
          //  margin: EdgeInsets.only(top: 220.0, left: 5.0, right: 5.0),
            
                children: <Widget>[ 
                  Container(height: 200.0, child:
                 SizedBox(height: 80.0,child: Card(     margin: EdgeInsets.only(top: 50.0, left: 10.0,right: 10.0),  elevation: 10,
                    child: Column(
                      children: <Widget>[

                         Text('INFO',style: TextStyle(fontStyle: FontStyle.normal,fontSize: 25.0),),
                            //SizedBox(height: 5.0,),
                            Divider(),
                        
                         SizedBox(
                        width: 300.0,
                        child: Text(
                        
                          'Supplier',style: TextStyle(fontWeight: FontWeight.normal,fontSize: 20.0),
                        ),
                      ),
                          Divider(),
                          
                         SizedBox(
                        width: 300.0,
                        child: Text(
                         // decoration: InputDecoration(hintText: 
                          'Contact Person',style: TextStyle(fontWeight: FontWeight.normal,fontSize: 20.0),
                        ),
                      ),
                          Divider(),
                          
                         SizedBox(
                        width: 300.0,
                        child: Text(
                         // decoration: InputDecoration(hintText: 
                          'Reference No',style: TextStyle(fontWeight: FontWeight.normal,fontSize: 20.0),
                        ),
                      ),
           

                      ],

                    ),
                   ) ) ),
                  SizedBox(height: 80.0,),
      
                  Card(
                    elevation: 10.0,
                margin: EdgeInsets.only(left: 10.0,right: 10.0),

              

              child: Column(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,

                

                children: <Widget>[
        
                            Text('Summary',style: TextStyle(fontStyle: FontStyle.normal,fontSize: 25.0),),
                            SizedBox(height: 25.0,),
                            Divider(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      SizedBox(
                        width: 20.0,
                      ),

                      
                        

                      //    SizedBox(
                      //   width: 350.0,
                      //   child: Text(
                      //    // decoration: InputDecoration(hintText: 
                      //     'Reference No',style: TextStyle(fontWeight: FontWeight.normal,fontSize: 20.0),
                      //   ),
                      // ),
                          Divider(),

                      SizedBox(
                        width: 300.0,
                        child: Text(
                         // decoration: InputDecoration(hintText: 
                          'Total Amount                 35120.00',style: TextStyle(fontWeight: FontWeight.normal,fontSize: 20.0),
                        ),
                      ),
                       Divider(),
                        SizedBox(
                        width: 300.0,
                        child: Text(
                         // decoration: InputDecoration(hintText:
                           'Other Charges',style: TextStyle(fontWeight: FontWeight.normal,fontSize: 20.0),
                        ),
                       
                      ),
                       Divider(),
                        SizedBox(
                        width: 300.0,
                        child: Text(  'VAT 7%',style: TextStyle(fontWeight: FontWeight.normal,fontSize: 20.0),),
                        ),
                         // decoration: InputDecoration(hintT
                         
                      
                       Divider(),
                        SizedBox(
                        width: 300.0,
                        child: Text( 'Net Amt                          35130.00',style: TextStyle(fontWeight: FontWeight.normal,fontSize: 20.0),
                        ),
                      ),
                         // decoration: InputDecoration(hintText:
                          // 'Net Amt                          35130.00',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),
                      // ),
               // ),
                   

                    ],
                  ),
                 
             

                     Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      FlatButton(
                        child: Text(
                          'BACK',
                          style: TextStyle(color: Colors.blue),
                        ),
                        onPressed: () {},
                      ),

                       SizedBox(width: 15.0,),

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

             
              ),
            ),],
          ),
        ),
      ),
    );
  }
}
