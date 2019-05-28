import 'package:flutter/material.dart';
import 'package:split/appdrawer.dart';
import 'package:split/src/Models/loginmodel.dart';

//import 'package:split/productmaster.dart';

class Supplierprofile extends StatefulWidget {

  
  final Users loginInfo;
  Supplierprofile({Key key, @required this.loginInfo}) :super(key: key);


  @override
  _SupplierprofileState createState() => _SupplierprofileState();
}

class _SupplierprofileState extends State<Supplierprofile> {
  @override
  Widget build(BuildContext context) {
    return
    //  MaterialApp(
    //     theme: ThemeData(
    //         brightness: Brightness.light,
    //         primaryColor: Colors.deepOrangeAccent,
    //         accentColor: Colors.deepPurple),
    //     home: 
        Scaffold(
          appBar: AppBar(
           backgroundColor: Color(0xffd35400),
            title: Text('Supplier Profile'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
             color: Colors.white,

              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AppDrawer(loginInfo: widget.loginInfo,)));
              },
            ),
          ),
          body: SingleChildScrollView(
              child: Center(
            child: Container(
              padding: EdgeInsets.all(25.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    textFields(InputDecoration(labelText: 'Supplier Name*'),TextInputType.text,),
                    SizedBox(
                      height: 20.0,
                    ),
                    textFields(InputDecoration(labelText: 'Company Name*'),TextInputType.text,),
                    SizedBox(
                      height: 20.0,
                    ),
                    textFields(
                        InputDecoration(labelText: 'Registration Number*'),TextInputType.number,),
                    SizedBox(
                      height: 20.0,
                    ),

                   textFields(
                        InputDecoration(labelText: 'Supplier Type'),TextInputType.text,),
                    SizedBox(
                      height: 20.0,
                    ),


                    textFields(
                        InputDecoration(labelText: 'Contact Person'),TextInputType.text,),
                    SizedBox(
                      height: 20.0,
                    ),


                    textFields(InputDecoration(labelText: 'Address1 Name*'),TextInputType.text,),
                    SizedBox(
                      height: 20.0,
                    ),
                    textFields(InputDecoration(labelText: 'Address2 Name*'),TextInputType.text,),
                    SizedBox(
                      height: 20.0,
                    ),
                    textFields(InputDecoration(labelText: 'City'),TextInputType.text,),
                    SizedBox(
                      height: 20.0,
                    ),


                      textFields(InputDecoration(labelText: 'State'),TextInputType.text,),
                    SizedBox(
                      height: 20.0,
                    ),
                    textFields(InputDecoration(labelText: 'ZIP Code'),TextInputType.number,),
                    SizedBox(
                      height: 20.0,
                    ),
                    textFields(InputDecoration(labelText: 'Country'),TextInputType.text,),
                    SizedBox(
                      height: 20.0,
                    ),
                    textFields(InputDecoration(labelText: 'Contact No'),TextInputType.number,),
                    SizedBox(
                      height: 20.0,
                    ),
                    textFields(
                      InputDecoration(labelText: 'Email ID'),TextInputType.text,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ButtonTheme(
                        minWidth: 500.0,
                        child: RaisedButton(
                          color:  Color(0xffd35400),
                          elevation: 5.0,
                          // padding: EdgeInsets.fromLTRB(50.0, 0.0, 0.0, 50.0),
                          child: Text(
                            'ADD SUPPLIER',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => ListViewExample()));
                          },
                        )),
                  ]),
            ),
          )),
        );
  }
}

Widget textFields(
  decoration,keyboardType
) {
  return TextField(decoration: decoration, onChanged: (value) {},keyboardType:keyboardType);
}
