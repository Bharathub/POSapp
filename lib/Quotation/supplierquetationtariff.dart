import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:split/Bloc/Bloc.dart';
import 'package:split/Bloc/CommonVariables.dart';
import 'package:split/Bloc/provider.dart';
import 'package:split/Quotation/quotationTab.dart';
import 'package:split/src/APIprovider/quotationApiProvider.dart';
import 'package:split/src/Models/currencyModel.dart';
import 'package:split/src/Models/loginmodel.dart';
import 'package:split/src/Models/productModel.dart';
import 'package:split/src/Models/quotationModel.dart';
import 'package:split/src/Models/suppliermodel.dart';


class SuppliertariffQuotation extends StatefulWidget {
  
  final Users loginInfo;
  final String quotNo;

  SuppliertariffQuotation({Key key, @required this.loginInfo, this.quotNo}) :super(key: key);
  @override
  _SuppliertariffState createState() => _SuppliertariffState();
}

class _SuppliertariffState extends State<SuppliertariffQuotation> 
{

  int intCount = 0;

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of(context);
    bool isInEditMode = (widget.quotNo != ""); // true : means Edit mode // false: means New Quotation

    // if(isInEditMode) 
    //   { 
        intCount = intCount+1; print('No Of Times Executed: ' + intCount.toString()); 
        if(intCount==1) 
        { bloc.initiateProducts(); 
          bloc.initiateCurrencys(); 
          bloc.initiateSuppliers(); 
          bloc.fetchQuotation(widget.quotNo);}
          // }

    return MaterialApp(
      title: '',
      home: new Scaffold(

           appBar: AppBar(
            backgroundColor: Color(0xffd35400),
            title: Text('Supplier Tariff'),
            leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context) => QuotationTab(loginInfo: widget.loginInfo, tabIndexno: 2)));},
            ),
          ),

        body: 
        SingleChildScrollView(
          child: 
          Center(
            // color: Color(0xffecf0f1),
            child: Column(
              children: <Widget>[
                SizedBox(height: 50.0),
                supplierDD(bloc),
                cusEffecDate(bloc, !isInEditMode),
                cusExpiryDate(bloc),
                Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                Text("Product List",style: TextStyle(fontSize: 24.0,)),
                addBtn(context, bloc),
                  ],
                ),
               
                Container( height: 350.0,child: listTile(bloc),),
                // saveBtn(context,bloc, widget.loginInfo,widget.quotNo),
              ],
            ),
      ),
    ),
      //  floatingActionButton: FloatingActionButton(
      //     heroTag: 'btn3',
      //     backgroundColor: Color(0xffd35400),
      //     child: Icon(Icons.add),
      //     onPressed: () {
      //      _showDialog(context, bloc);
      //       //dialogBox(context);
      //     },
      //   ),
        bottomNavigationBar:saveBtn(context,bloc, widget.loginInfo,widget.quotNo),
      ),
    );}
  }

  Widget addBtn(BuildContext context,Bloc bloc,)
  {
    return FlatButton(
      color: Colors.red,
      child: Text('Add',style:TextStyle(color: Colors.white)),
      onPressed: () {
           _showDialog(context, bloc);
            // dalogBox(context);
          },
    );
  }


  dispProductDetails(BuildContext context, Bloc bloc)
  {
    return  SingleChildScrollView(
      child: Container(margin: EdgeInsets.only(top: 120.0, left: 10.0, right: 10.0),
              child: Center( 
                      // child: Card(
                      //         elevation: 10,
                              child: Column(
                                children: <Widget>[
                                  productdownValue(bloc),
                                  stdQtnpopupCurrency(bloc),
                                  stdqtnSellRtPopUp(bloc),
                                  saveFlatbtn(context, bloc),
                                ],
                              ),
                      // )
                    ),
              ),
    );

  }


  productdownValue(Bloc bloc)
  {  
    bloc.initiateProducts();
    //ProductApiProvider wlApi = new ProductApiProvider();
    //LookUpApiProvider proApi = LookUpApiProvider();
                        
    return StreamBuilder<String>(
      stream: bloc.qCusProdCodePU,
      builder: (context,snapshot)
      {
      return StreamBuilder(
        stream: bloc.initProducts,
        builder: (context,ssWLDD)
        { 
        if (ssWLDD.hasData)
            {
              //  bloc.initiateProductList(ssWLDD.data);
            return SizedBox(width: 300, child: InputDecorator(decoration: InputDecoration(labelText: 'Product Code'),
              child:DropdownButtonHideUnderline(
                child:  DropdownButton<String>(
                isDense: true,
                items: ssWLDD.data
                .map<DropdownMenuItem<String>>(
                (Product dropDownStringitem){ 
                  return DropdownMenuItem<String>(
                    value: dropDownStringitem.productCode.trim(), 
                    child: Text(dropDownStringitem.description),);},).toList(),
                    value: snapshot.data,
                    onChanged: bloc.qCusProdCodePUChanged,
                    isExpanded: true,
                    elevation: 10,
                  ) ) ) );
        } else { return CircularProgressIndicator(); }
            });
            });
}

stdQtnpopupCurrency(Bloc bloc)
{
  bloc.initiateCurrencys();
    //CurrencyApiProvider payApi = new CurrencyApiProvider();
    return StreamBuilder<String>(
      stream: bloc.qCusPaymentPU,
      builder: (context,snapshot)
      {
        return StreamBuilder(
        stream: bloc.initCurrency,
        builder: (context,ssWLDD)
        { 
          if (ssWLDD.hasData)
          {
            return SizedBox(width: 300, child: InputDecorator(decoration: InputDecoration(labelText: 'Currency'),
            child:DropdownButtonHideUnderline(
              child:  DropdownButton<String>(
                isDense: true,
                items: ssWLDD.data
                .map<DropdownMenuItem<String>>((Currency dropDownStringitem)
                { return DropdownMenuItem<String>(
                  value: dropDownStringitem.currencyCode.trim(), 
                  child: Text(dropDownStringitem.description));},
                ).toList(),
              value: snapshot.data,
              onChanged: bloc.qCusPaymentPUChanged,
              isExpanded: true,
              elevation: 10,
              ) ) ) );
          } else { return CircularProgressIndicator(); }
       });
    });
}

stdqtnSellRtPopUp(Bloc bloc)
{
  TextEditingController _controller = new TextEditingController();
  return StreamBuilder(
    stream: bloc.qCusSellratePU,
    builder:(context,snapshot)
    {
      if(snapshot.hasData)
      {_controller.value = _controller.value.copyWith(text: snapshot.data.toString());}

      return SizedBox(width: 300.0,child: TextField(
        controller: _controller,
        onChanged: bloc.qCusSellratePUChanged,
        keyboardType: TextInputType.numberWithOptions(),
        decoration: InputDecoration(labelText: 'SellRate'),) );
    }); 
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
            onPressed: () {Navigator.of(context).pop();},),
            FlatButton( child: Text( 'SAVE', style: TextStyle(color: Colors.blue),),
            onPressed: (){Navigator.of(context).pop(); bloc.addQuotationItems(); bloc.clearDisplay4EditQuotItem();}
         ),
            ],
          ),
        );
}

void _showDialog(BuildContext context, Bloc bloc) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return SimpleDialog(children: <Widget>[ 
          //showRadioBtn(context),
          showPopUpList(context, bloc),
          // new FlatButton(child: new Text("Close",style: txtRoboBoldHiLightColor(25, Colors.blueAccent)),
          //                onPressed: () {Navigator.of(context).pop();},
          //)
        ],);
      },
    );
  }

  Widget showPopUpList(BuildContext contxt, Bloc bloc) {
    return Container( width: 250, height: 400, 
        // decoration: BoxDecoration(border: Border.all(color: Colors.blueGrey), 
        //               shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(5.0)),
        padding: EdgeInsets.only(left:10.00, right:5.00),
        //elevation: 24,
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
           dispProductDetails(contxt, bloc),
          ],
      )
    );
  }

  supplierDD(Bloc bloc)
  {
    // SupplierApiProvider payApi = new SupplierApiProvider();
      return StreamBuilder<String>(
        stream: bloc.qCusCCode,
        builder: (context,snapshot)
        {
          return StreamBuilder(
          stream: bloc.initSuppliers,
          builder: (context,ssWLDD)
          { 
            if (ssWLDD.hasData)
            {
              return SizedBox(width: 300, child: InputDecorator(decoration: InputDecoration(labelText: 'Supplier'),
              child:DropdownButtonHideUnderline(
                child:  DropdownButton<String>(
                  isDense: true,
                  items: ssWLDD.data
                  .map<DropdownMenuItem<String>>((Supplier dropDownStringitem)
                  { return DropdownMenuItem<String>(
                    value: dropDownStringitem.customerCode.trim(),
                    child: Text(dropDownStringitem.customerName));},
                  ).toList(),
                value: snapshot.data,
                onChanged: bloc.qCusCCodeChanged,
                isExpanded: true,
                elevation: 10,
                ) ) ) );
            } else { return CircularProgressIndicator(); }
        });
      });
  }

  cusEffecDate(Bloc bloc, bool isInEditMode)
  {
    TextEditingController _controller = new TextEditingController();

    final formats = { InputType.date: DateFormat('dd/MM/yyyy'),};
    InputType inputType = InputType.date;
    bloc.initDateCust(isInEditMode);
    return StreamBuilder( 
          stream: bloc.qCusEffecDate,
          builder:(context,snapshot)
          {       
          if(snapshot.hasData)
            {_controller.value = _controller.value.copyWith(text:  DateFormat("dd/MM/yyyy").format(snapshot.data));}
            return SizedBox(width:300,
              child: new DateTimePickerFormField(
              controller: _controller, 
              inputType: inputType,
              format: formats[inputType],
              editable: !isInEditMode,
              //initialDate: DateTime.now(),
              //initialValue: DateTime.now(),
              decoration: const InputDecoration(
                labelText: 'Effective Date',
                hasFloatingPlaceholder: true
              ), 
              onChanged: bloc.qCusEffecDateChanged
              ), 
            ); 
        }  
      );
  }

  cusExpiryDate(Bloc bloc)
  {
    TextEditingController _controller = new TextEditingController();

    final formats = { InputType.date: DateFormat('dd/MM/yyyy'),};
    InputType inputType = InputType.date;
    //bool editable = true;
  
    return StreamBuilder( 
        stream: bloc.qCusExprDate,
        builder:(context,snapshot)
        { 
          if(snapshot.hasData)
          {_controller.value = _controller.value.copyWith(text:  DateFormat("dd/MM/yyyy").format(snapshot.data));}
      
          return SizedBox(width:300,
          child: new DateTimePickerFormField(
            controller: _controller,
            inputType: inputType,
            format: formats[inputType],
            //editable: !isInEditMode,
            decoration: const InputDecoration(
            // prefixIcon: const Icon(Icons.calendar_today, color: Colors.green), 
            labelText: 'Expiry Date',hasFloatingPlaceholder: true
            ), 
            onChanged: bloc.qCusExprDateChanged
          ), 
        ); 
        }
    ); 
  }

  saveBtn(BuildContext context, Bloc bloc, Users loginInfo, String quotNo)
  {
  return ButtonTheme(
    minWidth: 250.0,
    child: RaisedButton(
        color: Color(0xffd35400),
        elevation: 5.0,
        child: Text('Save', style: TextStyle(color: Colors.white),),
        onPressed: () async { 
          QuotationApiProvider  poAPI = new QuotationApiProvider();
          await poAPI.saveCustQuotaion(bloc.getQuotationHD("SUPPLIER",quotNo))
          .then((isSuccess) { if(isSuccess) 
            { StaticsVar.showAlert(context,'Supplier Quotation Saved'); 
              bloc.clearQuotationHD();
              Navigator.push(context, MaterialPageRoute(builder: (context)=> QuotationTab(loginInfo: loginInfo,tabIndexno:2))); }},
            onError: (e) {StaticsVar.showAlert(context, e.toString());} )
          .catchError((onError) {StaticsVar.showAlert(context, onError.toString());});    
        },
      )
    );
  }

  Widget listTile(Bloc bloc)
  {
  return StreamBuilder(
    stream: bloc.quotationItems,
    builder: (context, ssPOproDt) {
    List poData = ssPOproDt.hasData ? ssPOproDt.data : <QuotationItems>[];
    //if (poData.) {
      return ListView.builder(
          itemCount: poData.length,
          itemBuilder: (context, index) 
          { return Container(height: 80.0,padding: EdgeInsets.only(top:15.0),
              child: Card(
                margin: EdgeInsets.only(right: 5.0, left: 5.0),
                elevation: 10.0,
                child: ListTile(
                  title:Row(children: <Widget>[
                    Expanded(flex: 4,child: Text('Product:' ),),
                    Expanded(flex: 6,child: Text(poData[index].productDescription),),
                    // Expanded(flex: 5,child: Text(poData[index].productCode),),
                  ],),
                  trailing:Row(mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton( icon: Icon(Icons.edit), onPressed:(){ bloc.display4EditQuotaionItem(poData[index].productCode.trim()); _showDialog(context, bloc);}),
                    IconButton( icon: Icon(Icons.delete), onPressed:(){ bloc.deleteQuotaionItem(poData[index].productCode.trim());
                        StaticsVar.showAlert(context, "Product Deleted"); }),
                    ],
                  ),

                  //trailing: IconButton( icon: Icon(Icons.delete), onPressed: () { bloc.deleteQuotaionItem(poData[index].productCode); StaticsVar.showAlert(context, "Product Deleted"); }),
                  subtitle: Container(
                    child: Align(
                    alignment: Alignment.centerLeft,
                      child: Column(
                      children: <Widget>[
                         Row(children: <Widget>[
                    Expanded(flex: 4,child: Text('Sell Rate:' ),),
                    Expanded(flex: 6,child: Text(poData[index].sellRate.toString()),),
                  ],),
                  Row(children: <Widget>[
                    Expanded(flex: 4,child: Text('Currency Code:' ),),
                    Expanded(flex: 6,child: Text(poData[index].currencyCode),),
                  ],),
                        // SizedBox(width: 250,child: Text('Sell Rate:    ' + poData[index].sellRate.toString())),
                        // SizedBox(width: 250,child:Text('Currency Code:    ' + poData[index].currencyCode)),
                      ],
                    )),
                  )),
              )); 
        });
    //} else { return Center(child:CircularProgressIndicator());}
    });
  }
