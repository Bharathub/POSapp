import 'package:flutter/material.dart';
import 'package:split/Masterdata/category.dart';
import 'package:split/Masterdata/currencylist.dart';
import 'package:split/Masterdata/incoterms.dart';
import 'package:split/Masterdata/location.dart';
import 'package:split/Masterdata/paymenttype.dart';
import 'package:split/Masterdata/products.dart';
import 'package:split/Masterdata/promotion.dart';
import 'package:split/Masterdata/uom.dart';
import 'package:split/Masterdata/customoertariff.dart';
import 'package:split/Masterdata/suppliertariff.dart';
import 'package:split/appdrawer.dart';
import 'package:split/src/Models/loginmodel.dart';

class MasterDataTab extends StatefulWidget {
  final Users loginInfo;
  MasterDataTab({Key key, @required this.loginInfo}) : super(key: key);

  @override
  _MasterDataTabState createState() => _MasterDataTabState();
}

class _MasterDataTabState extends State<MasterDataTab>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Master Data'),
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
      body:SingleChildScrollView(child: Container(
          // margin: EdgeInsets.all(25.0),
          // height: 250.0,
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  iconBtn(
                      Icon(
                        Icons.ac_unit,
                      ), () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UomList(
                                  loginInfo: widget.loginInfo,
                                )));
                  }),
                  Text('UOM'),
                ],
              ),
              SizedBox(
                height: 15.0,
                width: 50.0,
              ),
              Column(
                children: <Widget>[
                  iconBtn(Icon(Icons.monetization_on), () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CurrencyList(
                                  loginInfo: widget.loginInfo,
                                )));
                  }),
                  Text('Currency'),
                ],
              ),
              SizedBox(
                height: 150.0,
                width: 50.0,
              ),
              Column(
                children: <Widget>[
                  iconBtn(Icon(Icons.receipt), () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => IncoTerms(
                                  loginInfo: widget.loginInfo,
                                )));
                  }),
                  Text('Inco Terms'),
                ],
              ),
            ],
          ),
          //    SizedBox(width: 20.0,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  iconBtn(Icon(Icons.category), () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoryPage(
                                  loginInfo: widget.loginInfo,
                                )));
                  }),
                  Text('Product\nCategory'),
                ],
              ),
              SizedBox(
                height: 15.0,
                width: 50.0,
              ),
              Column(
                children: <Widget>[
                  iconBtn(Icon(Icons.location_on), () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WareHouseLocation(
                                  loginInfo: widget.loginInfo,
                                )));
                  }),
                  Text('Location'),
                ],
              ),
              SizedBox(
                height: 150.0,
                width: 50.0,
              ),
              Column(
                children: <Widget>[
                  iconBtn(Icon(Icons.payment), () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentType(
                                  loginInfo: widget.loginInfo,
                                )));
                  }),
                  Text('Payment Type'),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 15.0,
            width: 50.0,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  iconBtn(Icon(Icons.format_align_center), () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductPage(
                                  loginInfo: widget.loginInfo,
                                )));
                  }),
                  Text('Products'),
                ],
              ),
              SizedBox(
                height: 15.0,
                width: 50.0,
              ),
              Column(
                children: <Widget>[
                  iconBtn(Icon(Icons.format_align_left), () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SupplierCards(
                                  loginInfo: widget.loginInfo,
                                )));
                  }),
                  Text('Suppliers'),
                ],
              ),
              SizedBox(
                height: 150.0,
                width: 50.0,
              ),
              Column(
                children: <Widget>[
                  iconBtn(Icon(Icons.person), () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CustomerList(
                                  loginInfo: widget.loginInfo,
                                )));
                  }),
                  Text('Customer'),
                ],
              ),
            ],
          ),

          SizedBox(
              width: 300.0,
              child: Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      iconBtn(Icon(Icons.present_to_all), () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PromotionList(
                                      loginInfo: widget.loginInfo,
                                    )));
                      }),
                      Text('Promotions'),
                    ],
                  ),
                ],
              )),
        ],
      ) )),
    );
  }
}

Widget iconBtn(
  icon,
  onPressed,
) {
  return IconButton(
    color: Colors.blue,
    iconSize: 50.0,
    icon: icon,
    onPressed: onPressed,
  );
}
