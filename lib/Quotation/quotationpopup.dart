import 'package:flutter/material.dart';
import 'package:split/Bloc/Bloc.dart';
import 'package:split/Bloc/provider.dart';
import 'package:split/src/APIprovider/masterProductApiProvider.dart';
import 'package:split/src/APIprovider/paymentApiProvider.dart';
import 'package:split/src/Models/paymentModel.dart';
import 'package:split/src/Models/productModel.dart';

class Quotationpopup extends StatefulWidget {
  @override
  _QuotationpopupState createState() => _QuotationpopupState();
}

class _QuotationpopupState extends State<Quotationpopup> {

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of(context);
    
    return MaterialApp(
      //theme: new ThemeData(primaryColor: Color.fromRGBO(58, 66, 86, 1.0)),
      home: Scaffold(
       // backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        //backgroundColor: Colors.orange,
        appBar: AppBar(
          title: Text('Standard Tariff'),
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
                   stdqtnProdCodPopUp(bloc),
                   stdQtnpopupPaymentTerm(bloc),
                   stdqtnSellRtPopUp(bloc),
                   saveFlatbtn(context, bloc),
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

stdqtnProdCodPopUp(Bloc bloc)
{
  ProductApiProvider wlApi = new ProductApiProvider();
    //LookUpApiProvider proApi = LookUpApiProvider();
                        
    return StreamBuilder<String>(
      stream: bloc.qSuppDropDwnPU,
      builder: (context,snapshot)
      {
      return FutureBuilder(
        future: wlApi.productList(),
        builder: (context,ssWLDD)
        { 
        if (ssWLDD.hasData)
            {
            return SizedBox(width: 300, child: InputDecorator(decoration: InputDecoration(labelText:'Product Code'),
              child:DropdownButtonHideUnderline(
                child:  DropdownButton<String>(
                isDense: true,
                items: ssWLDD.data
                .map<DropdownMenuItem<String>>(
                (Product dropDownStringitem){ 
                  return DropdownMenuItem<String>(
                    value: dropDownStringitem.productCode.toString(), 
                    child: Text(dropDownStringitem.description),);},).toList(),
                    value: snapshot.data,
                    onChanged: bloc.qSuppDropDwnPUChanged,
                    isExpanded: true,
                    elevation: 10,
                  ) ) ) );
        } else { return CircularProgressIndicator(); }
            });
            });

}


stdQtnpopupPaymentTerm(Bloc bloc)
{
   PaymentApiProvider payApi = new PaymentApiProvider();
    return StreamBuilder<String>(
      stream: bloc.payTypeStream,
      builder: (context,snapshot)
      {
        return FutureBuilder(
        future: payApi.paymentList(),
        builder: (context,ssWLDD)
        { 
          if (ssWLDD.hasData)
          {
            return SizedBox(width: 300, child: InputDecorator(decoration: InputDecoration(labelText: 'Payment Term'),
            child:DropdownButtonHideUnderline(
              child:  DropdownButton<String>(
                isDense: true,
                items: ssWLDD.data
                .map<DropdownMenuItem<String>>((PaymentTypes dropDownStringitem)
                { return DropdownMenuItem<String>(
                  value: dropDownStringitem.lookupCode.toString(), 
                  child: Text(dropDownStringitem.description));},
                ).toList(),
              value: snapshot.data,
              onChanged: bloc.payTypeChanged,
              isExpanded: true,
              elevation: 10,
              ) ) ) );
          } else { return CircularProgressIndicator(); }
       });
    });
}

stdqtnSellRtPopUp(Bloc bloc)
{
  return StreamBuilder<String>(
            stream: bloc.qSQuotation,
            builder:(context,snapshot)=>
            SizedBox(width: 300.0,child: TextField(onChanged: bloc.qSQuotationChanged,
             decoration: InputDecoration(labelText: 'SellRate'),) ),); 

}



Widget saveFlatbtn(BuildContext context, Bloc bloc)
{   
  //  QuotationApiProvider uomApi = QuotationApiProvider();
      return Container(
            child:  Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
            FlatButton(child: Text('CANCEL',style: TextStyle(color: Colors.blue),),
            onPressed: () {},),
            FlatButton( child: Text( 'SAVE', style: TextStyle(color: Colors.blue),),
            onPressed: (){}
         ),
            ],
          ),
        );
   
}
