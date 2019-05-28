import 'package:flutter/material.dart';
import 'package:split/appdrawer.dart';
import 'package:split/src/Models/loginmodel.dart';

//import 'package:split/productmaster.dart';

class CustomerProfile extends StatefulWidget {

  final Users loginInfo;
  CustomerProfile({Key key, @required this.loginInfo}) :super(key: key);



  @override
  _CustomerProfileState createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
           backgroundColor: Color(0xffd35400),
            title: Text('Customer Profile'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
             color: Colors.white,

              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AppDrawer(loginInfo: widget.loginInfo,)));
              },
            ),
          ),

      
 
        body: Container(
          
          child: SingleChildScrollView(
              child: Center(
            child: Container(
              padding: EdgeInsets.all(25.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    textFields(InputDecoration(labelText: 'Customor Name*'),
                        TextInputType.text),
                    SizedBox(
                      height: 20.0,
                    ),
                    textFields(
                        InputDecoration(labelText: 'Registration Number*'),
                        TextInputType.text),
                    SizedBox(
                      height: 20.0,
                    ),
                    textFields(InputDecoration(labelText: 'Credit Term*'),
                        TextInputType.text),
                    SizedBox(
                      height: 20.0,
                    ),
                    textFields(InputDecoration(labelText: 'Address1 Name*'),
                        TextInputType.text),
                    SizedBox(
                      height: 20.0,
                    ),
                    textFields(InputDecoration(labelText: 'Address2 Name*'),
                        TextInputType.text),
                    SizedBox(
                      height: 20.0,
                    ),
                    textFields(
                        InputDecoration(labelText: 'City'), TextInputType.text),
                    SizedBox(
                      height: 20.0,
                    ),
                    textFields(
                      InputDecoration(labelText: 'State'),
                      TextInputType.text,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    textFields(InputDecoration(labelText: 'ZIP Code'),
                        TextInputType.number),
                    SizedBox(
                      height: 20.0,
                    ),
                    textFields(InputDecoration(labelText: 'Country'),
                        TextInputType.text),
                    SizedBox(
                      height: 20.0,
                    ),
                    textFields(InputDecoration(labelText: 'Contact No'),
                        TextInputType.number),
                    SizedBox(
                      height: 20.0,
                    ),
                    textFields(InputDecoration(labelText: 'Email ID'),
                        TextInputType.text),
                    SizedBox(
                      height: 20.0,
                    ),
                    ButtonTheme(
                        minWidth: 500.0,
                        child: RaisedButton(
                          color: Color(0xffd35400),
                          elevation: 5.0,
                          // padding: EdgeInsets.fromLTRB(50.0, 0.0, 0.0, 50.0),
                          child: Text(
                            'ADD CUSTOMER',
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
        ));
  }
}

Widget textFields(decoration, keyboardType) {
  return TextField(
    decoration: decoration,
    onChanged: (value) {},
    keyboardType: keyboardType,
  );
}
