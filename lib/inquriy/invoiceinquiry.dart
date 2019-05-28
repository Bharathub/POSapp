import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:split/Bloc/Bloc.dart';
import 'package:split/Bloc/provider.dart';
import 'package:split/src/APIprovider/currencyApiProvider.dart';
import 'package:split/src/APIprovider/customerApiProvider.dart';
import 'package:split/src/Models/currencyModel.dart';
import 'package:split/src/Models/customermodel.dart';
import 'package:split/src/Models/loginmodel.dart';

class InvoiceInquiry extends StatefulWidget {
  final Users loginInfo;
  InvoiceInquiry({Key key, @required this.loginInfo}) : super(key: key);
  @override
  _InvoiceInquiryState createState() => _InvoiceInquiryState();
}

class _InvoiceInquiryState extends State<InvoiceInquiry> {

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of(context);
    
    return MaterialApp(
      title: '',
      home: new Scaffold(
      body: SingleChildScrollView(
      child: Container(
      color: Color(0xffecf0f1),
      child: Column(
      children: <Widget>[
      //  Card(
      //   margin: EdgeInsets.all(7),
      //   elevation: 5.0,
        // child:
         Container(padding: EdgeInsets.all(25.0),
        child: new Column(
        children: <Widget>[
              inqInvCustomer(bloc),
              inqInvDateFld(bloc),
              inqInvDateToFld(bloc),
              inqInvCurrencyType(bloc),
              inqInvsearchbtn(context, bloc, widget.loginInfo)
            ],
          ),
        ),
      // ),

                //** TextFields Ends Here */
                new Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10.0,
                    ),
                    listIcons(
                      Text('Invoice No.'),
                      Icon(
                        Icons.person,
                        size: 30.0,
                        color: Colors.blue,
                      ),
                      Text('No Data Available in Table'),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    listIcons(
                      Text('Invoice Date'),
                      Icon(
                        Icons.home,
                        size: 30.0,
                        color: Colors.blue,
                      ),
                      Text(''),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    listIcons(
                      Text('Customer'),
                      Icon(
                        Icons.receipt,
                        size: 30.0,
                        color: Colors.blue,
                      ),
                      Text(''),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    listIcons(
                      Text('Invoice Amount'),
                      Icon(
                        Icons.shop,
                        size: 30.0,
                        color: Colors.blue,
                      ),
                      Text(''),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    listIcons(
                      Text('Print'),
                      Icon(
                        Icons.print,
                        size: 30.0,
                        color: Colors.blue,
                      ),
                      Text(''),
                    ),
                  ],
                ),
                SizedBox(
                  height: 180.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget listIcons(
  title,
  leading,
  subtitle,
) {
  return SizedBox(
      height: 90.0,
      child: Card(
        margin: EdgeInsets.only(right: 10.0, left: 10.0),
        elevation: 10.0,
        child: ListTile(
          title: title,
          subtitle: subtitle,
          leading: leading,
        ),
      ));
}

inqInvCustomer(Bloc bloc) {
  CustomerApiProvider wlApi = new CustomerApiProvider();
  return StreamBuilder<String>(
      stream: bloc.suplNameStream,
      builder: (context, snapshot) {
        return FutureBuilder(
            future: wlApi.customerList(),
            builder: (context, ssWLDD) {
              if (ssWLDD.hasData) {
                return SizedBox(
                    width: 300,
                    child: InputDecorator(
                        decoration: InputDecoration(labelText: 'Customer'),
                        child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                          isDense: true,
                          items: ssWLDD.data.map<DropdownMenuItem<String>>(
                            (Customer dropDownStringitem) {
                              return DropdownMenuItem<String>(
                                value:
                                    dropDownStringitem.customerName.toString(),
                                child: Text(
                                  dropDownStringitem.customerName,
                                ),
                              );
                            },
                          ).toList(),
                          value: snapshot.data,
                          onChanged: bloc.suppNameChanged,
                          isExpanded: true,
                          elevation: 10,
                        ))));
              } else {
                return CircularProgressIndicator();
              }
            });
      });
}

inqInvDateFld(Bloc bloc) {
  final formats = {
    InputType.date: DateFormat('dd/MM/yyyy'),
  };
  InputType inputType = InputType.date;
  bool editable = true;

  return StreamBuilder<DateTime>(
      stream: bloc.datePurStream,
      builder: (context, snapshot) => SizedBox(
            width: 300,
            child: new DateTimePickerFormField(
                inputType: inputType,
                format: formats[inputType],
                editable: editable,
                decoration: const InputDecoration(
                    labelText: 'DATE FORM', hasFloatingPlaceholder: true),
                onChanged: bloc.datePurChanged),
          ));
}

inqInvDateToFld(Bloc bloc) {
  final formats = {
    InputType.date: DateFormat('dd/MM/yyyy'),
  };
  InputType inputType = InputType.date;
  bool editable = true;

  return StreamBuilder<DateTime>(
      stream: bloc.datePurStream,
      builder: (context, snapshot) => SizedBox(
            width: 300,
            child: new DateTimePickerFormField(
                inputType: inputType,
                format: formats[inputType],
                editable: editable,
                decoration: const InputDecoration(
                    labelText: 'DATE TO', hasFloatingPlaceholder: true),
                onChanged: bloc.datePurChanged),
          ));
}

inqInvCurrencyType(Bloc bloc) {
  CurrencyApiProvider payApi = new CurrencyApiProvider();
  return StreamBuilder<String>(
      stream: bloc.qCusPaymentPU,
      builder: (context, snapshot) {
        return FutureBuilder(
            future: payApi.currencyList(),
            builder: (context, ssWLDD) {
              if (ssWLDD.hasData) {
                return SizedBox(
                    width: 300,
                    child: InputDecorator(
                        decoration: InputDecoration(labelText: 'Payment Type'),
                        child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                          isDense: true,
                          items: ssWLDD.data.map<DropdownMenuItem<String>>(
                            (Currency dropDownStringitem) {
                              return DropdownMenuItem<String>(
                                  value:
                                      dropDownStringitem.description.toString(),
                                  child: Text(dropDownStringitem.description));
                            },
                          ).toList(),
                          value: snapshot.data,
                          onChanged: bloc.qCusPaymentPUChanged,
                          isExpanded: true,
                          elevation: 10,
                        ))));
              } else {
                return CircularProgressIndicator();
              }
            });
      });
}

Widget inqInvsearchbtn(BuildContext context, Bloc bloc, Users loginInfo) {
  // InquiryApi inqApi = InquiryApi();
  return Center(
    child: RaisedButton(
      color: Colors.red,
      child: Text(
        'Search',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () async {
        // InquiryModel inqmod = InquiryModel();
        // inqmod=bloc.saveInqdtls();
        // await inqApi.inquiryList(inqmod).then((onValue){
        // if(onValue.isEmpty){
        //   Navigator.push(context, MaterialPageRoute(builder: (context)=> StockInquiry(loginInfo:loginInfo,) ));
        //  }else {return  Exception('Failed to Show Inquiry');} });
      },
    ),
  );
}

// Widget listTile(Bloc bloc, )
// {
//   //ProductApiProvider pProductDtApi = new ProductApiProvider();
//   return StreamBuilder(
//     stream: bloc.poDetails,
//     builder: (context, ssPOproDt) {
//     List poData = ssPOproDt.hasData ? ssPOproDt.data : <PurchaseOrderDetails>[];
//     //if (poData.) {
//       return ListView.builder(
//           itemCount: poData.length,
//           itemBuilder: (context, index)
//           { return Container(height: 150.0,padding: EdgeInsets.only(top:15.0),
//               child: Card(
//                 margin: EdgeInsets.only(right: 5.0, left: 5.0),
//                 elevation: 10.0,
//                 child: ListTile(
//                   title: Text('Code:   ' + poData[index].productCode),
//                   trailing: IconButton( icon: Icon(Icons.delete), onPressed: () { bloc.deletePODetail(poData[index].productCode); StaticsVar.showAlert(context, "Product Deleted"); }),
//                   subtitle: Container(
//                     child: Align(
//                     alignment: Alignment.centerLeft,
//                       child: Column(
//                       children: <Widget>[
//                         //Text('Description:' + poData[index].description),
//                         Text('Qty:    ' + poData[index].quantity.toString()),
//                         Text('Unit Price:    ' + poData[index].unitPrice.toString()),
//                         Text('UOM:    ' + poData[index].uom),

//                       ],
//                     )),
//                   )),
//               ));
//         });
//     //} else { return Center(child:CircularProgressIndicator());}
//   });
// }
