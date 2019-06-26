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


class StandardTariffQuotation extends StatefulWidget {
  
  final Users loginInfo;
  final String quotNo;
  StandardTariffQuotation({Key key, @required this.loginInfo, this.quotNo}) :super(key: key);
  @override
  _StandardTariffState createState() => _StandardTariffState();
}

class _StandardTariffState extends State<StandardTariffQuotation> 
{
  int intCount = 0;
  String quotNo;
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of(context);
    
    bool isInEditMode = (widget.quotNo != ""); // true : means Edit mode // false: means New Quotation

    // if(isInEditMode) 
    //   { 
        intCount = intCount+1; print('No Of Times Executed: ' + intCount.toString()); 
        if(intCount==1) {
          bloc.initiateProducts(true); 
          bloc.initiateCurrencys(true); 
          bloc.initiateCustomers(true); 
          bloc.validateProductDuplicate(context);
          bloc.fetchQuotation(widget.quotNo);}
        // }

    return MaterialApp(
      title: '',
      home: new Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xffd35400),
            title: Text('Standard Tariff'),
            leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context) => QuotationTab(loginInfo: widget.loginInfo, tabIndexno: 0)));},
            ),
          ),

        body:
        SingleChildScrollView(
          child:
          Container(
            // color: Color(0xffecf0f1),
            child: Column(
              children: <Widget>[
                qStdNotxtFld(bloc),
                cusEffecDate(bloc, !isInEditMode),
                // SizedBox(width: 300.0,child:Divider(color: Colors.red,height: 15.0,),),
                cusExpiryDate(bloc),
                Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text("Product List",style: TextStyle(fontSize: 24.0,)),
                  addBtn(context, bloc)
                ],),
                Divider(color: Colors.green),
               Container(height: 320.0,child: listTile(bloc),)
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
        bottomNavigationBar: saveBtn(context,bloc, widget.loginInfo,widget.quotNo),
     

      ),
    );}
  }

    Widget addBtn(BuildContext context,Bloc bloc,)
  {
    return FlatButton(
      color: Colors.red,
      child: Text('Add',style:TextStyle(color: Colors.white)),
      onPressed: () { bloc.clearDisplay4EditQuotItem(); _showDialog(context, bloc);},
    );
  }


  dispProductDetails(BuildContext context, Bloc bloc)
  {
    return  SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            children: <Widget>[
              productdownValue(bloc),
              stdQtnpopupCurrency(bloc),
              stdqtnSellRtPopUp(bloc),
              saveFlatbtn(context, bloc),
               ],
              ),
            ),
          ),
        );
  }


  productdownValue(Bloc bloc)
  {
    bloc.initiateProducts(false);                           
    return StreamBuilder<String>(
      stream: bloc.qCusProdCodePU,
      builder: (context,snapshot)
      {
      return StreamBuilder<List<Product>>(
        stream:bloc.initProducts,
        builder: (context,ssWLDD)
        { 
        if (ssWLDD.hasData)
            {
            //  bloc.initiateProductList(ssWLDD.data);   
            print('Product Length ' + ssWLDD.data.length.toString());             
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
        }else { return CircularProgressIndicator(); }
            });
            });
  }

  stdQtnpopupCurrency(Bloc bloc)
  {
     bloc.initiateCurrencys(false);
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

  void _showDialog(BuildContext context, Bloc bloc)
  {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(children: <Widget>[ 
            showPopUpList(context, bloc),
          ],);
        },
      );
    }

  Widget showPopUpList(BuildContext contxt, Bloc bloc) {
    return Container( width: 250, height: 275, 
        // decoration: BoxDecoration(border: Border.all(color: Colors.blueGrey), 
        //               shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(5.0)),
        padding: EdgeInsets.all(10.0),
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
    bloc.initiateSuppliers(false);
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


  qStdNotxtFld(Bloc bloc)
  {
    TextEditingController _controller = new TextEditingController();
    return StreamBuilder(
                stream: bloc.qCusNoCode,
                builder:(context,snapshot){
                if(snapshot.hasData)
                {_controller.value = _controller.value.copyWith(text: snapshot.data.toString());}
               return SizedBox(width: 300.0,
                child: TextField(
                  onChanged: bloc.qCusNoCodeChanged,
                  controller: _controller, 
                  enabled: false,
                  decoration: InputDecoration(labelText: 'Quotaion No.'),) );});

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
            {_controller.value = _controller.value.copyWith(text:DateFormat("dd/MM/yyyy").format(snapshot.data));}
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
    return StreamBuilder(
      stream: bloc.qCusExprDate,
      builder:(context,snapshot)
      {
        if(snapshot.hasData)
        {_controller.value = _controller.value.copyWith(text:  DateFormat("dd/MM/yyyy").format(snapshot.data));}
        return SizedBox(
          width:300,
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
    // minWidth: 250.0,
    child: RaisedButton(
        color: Color(0xffd35400),
        elevation: 5.0,
        child: Text('SAVE', style: TextStyle(color: Colors.white),),
        onPressed: () async { 
          QuotationApiProvider  poAPI = new QuotationApiProvider();
          await poAPI.saveCustQuotaion(bloc.getQuotationHD("CUSTOMER",quotNo))
          .then((isSuccess) { if(isSuccess) 
            { StaticsVar.showAlert(context,'Standard Quotation Saved'); 
              Navigator.push(context, MaterialPageRoute(builder: (context)=> QuotationTab(loginInfo: loginInfo,tabIndexno:0))); }},
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
      return ListView.builder(
          itemCount: poData.length,
          itemBuilder: (context, index) 
          { return poData[index].status ?  Container(height: 80.0,padding: EdgeInsets.only(top:15.0),
              child: Card(
                margin: EdgeInsets.only(right: 5.0, left: 5.0),
                elevation: 10.0,
                child: ListTile(
                  title: Row(children: <Widget>[
                    Expanded(flex: 4,child: Text('Product:' ),),
                    Expanded(flex: 6,child: Text(poData[index].productDescription),),
                  ],),
                  //  Text('Product : ' + poData[index].productCode),
                  onTap:()
                  {
                    //print('Product COde: ' + poData[index].productCode + '@');
                    bloc.display4EditQuotaionItem(poData[index].productCode.trim(),poData); _showDialog(context, bloc);
                  } ,
                  trailing:  Row( mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
            //  IconButton( icon: Icon(Icons.edit), onPressed:(){ print('Product COde: ' + poData[index].productCode + '@');
              //  bloc.display4EditQuotaionItem(poData[index].productCode.trim()); _showDialog(context, bloc);} ),
            // SizedBox(height: 5.0),
                      IconButton( icon: Icon(Icons.delete), onPressed:(){bloc.deleteQuotaionItem(poData[index].productCode.trim());
                        StaticsVar.showAlert(context, "Product Deleted"); })
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
                      ],
                  )
                ),
               )
              ),
             ) 
            ) : Container(); 
           });
    //} else { return Center(child:CircularProgressIndicator());}
    });
  }