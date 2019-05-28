import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:split/Bloc/Bloc.dart';
import 'package:split/Bloc/CommonVariables.dart';
import 'package:split/Bloc/provider.dart';
import 'package:split/Quotation/quotationTab.dart';
import 'package:split/src/APIprovider/quotationApiProvider.dart';
import 'package:split/src/Models/currencyModel.dart';
import 'package:split/src/Models/customermodel.dart';
import 'package:split/src/Models/loginmodel.dart';
import 'package:split/src/Models/productModel.dart';
import 'package:split/src/Models/quotationModel.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

class CustomertariffQuotation extends StatefulWidget
{
  
  final Users loginInfo;
  final String quotNo;
  final List<Customer> customers;
  final List<Product> products;
  //CustomerQuotationList({Key key, @required this.loginInfo, this.customers, this.products}) :super(key: key);

  CustomertariffQuotation({Key key, @required this.loginInfo,this.quotNo, this.customers, this.products}) :super(key: key);
  @override
  _CustomertariffState createState() => _CustomertariffState();
}

class _CustomertariffState extends State<CustomertariffQuotation> 
{

  int intCount = 0;
  List<Product> products;
  
  @override
  Widget build(BuildContext context)
  { 
    var bloc = Provider.of(context);
    
    bool isInEditMode = (widget.quotNo != ""); // true : means Edit mode // false: means New Quotation

    // if(isInEditMode) 
    //  { 
    intCount = intCount+1; print('No Of Times Executed: ' + intCount.toString()); 
      if(intCount==1) 
      { bloc.initiateProducts(); 
        bloc.initiateCurrencys(); 
        bloc.initiateCustomers();
        bloc.fetchQuotation(widget.quotNo);}
      //  }
    return MaterialApp(
      home: new Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xffd35400),
            title: Text('Customer Tariff'),
            leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context) => QuotationTab(loginInfo: widget.loginInfo, tabIndexno: 1)));},
            ),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 50.0),
                customerDD(bloc, !isInEditMode, widget.customers), //, widget.quotNo, key, customers),
                cusEffecDate(bloc,isInEditMode),
                cusExpiryDate(bloc),
                SizedBox(height: 5.0,),
                Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                   Text("Product List",style: TextStyle(fontSize: 24.0),),
                   addBtn(context, bloc)
                ],),
                Container( height: 380.0,child: listTile(bloc),),
                // saveBtn(context,bloc, widget.loginInfo, widget.quotNo),
              ],
            ),
      ),
    ),
      //  floatingActionButton: FloatingActionButton(
      //     heroTag: 'btn3',
      //     backgroundColor: Color(0xffd35400),
      //     child: Icon(Icons.add),
      //     onPressed: () {
      //      _showDialog(context, bloc, widget.products);
      //     },
      //   ),
        bottomNavigationBar:saveBtn(context,bloc, widget.loginInfo, widget.quotNo),
      ),
    );}
  }

    Widget addBtn(BuildContext context,Bloc bloc)
  {
    return FlatButton(
      color: Colors.red,
      child: Text('Add',style:TextStyle(color: Colors.white)),
      onPressed: () {_showDialog(context, bloc);},
    );
  }

  // autoCompletFldCustomer(Bloc bloc, List<Customer> customers) async
  // {
  //   AutoCompleteTextField searchTextField;
  //   //CustomerApiProvider custAPI = new CustomerApiProvider();
  //   GlobalKey<AutoCompleteTextFieldState<Customer>> key = new GlobalKey();

  //   //List<Customer> custs = await custAPI.customerList();
  //   //bool loading = custs.length>0;

  //   return StreamBuilder<String>(
  //     stream: bloc.qCusCCode,
  //     builder: (context,snapshot)
  //     {
  //      return SizedBox(width: 300,child:
  //       //Column(
  //       // mainAxisAlignment: MainAxisAlignment.start,
  //       // children: <Widget>[
  //         //loading ? CircularProgressIndicator(): searchTextField = AutoCompleteTextField<Customer>(
  //         //searchTextField = 
  //         new AutoCompleteTextField<Customer>(
  //           key: key,
  //           clearOnSubmit: false,
  //           suggestions: customers,
  //           style: TextStyle(color: Colors.black, fontSize: 16.0),
  //           decoration: InputDecoration(
  //             contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
  //             hintText: "Search Name",
  //             hintStyle: TextStyle(color: Colors.black),
  //           ),
  //           itemFilter: (item, query) {
  //             return item.customerName
  //                 .toLowerCase()
  //                 .startsWith(query.toLowerCase());
  //           },
  //           itemSorter: (a, b) {
  //             return a.customerName.compareTo(b.customerName);
  //           },
  //           itemSubmitted: (item) {
  //             //setState(() {
  //               searchTextField.textField.controller.text = item.customerName;
  //             //);
  //           },
  //           itemBuilder: (context, item) {
  //             return row(item);
  //           },
  //           textChanged: bloc.qCusCCodeChanged,
  //         ),
  //      // ],
  //     //)
  //     );
  //   });

  // }

  dispProductDetails(BuildContext context, Bloc bloc,)
  {
    return  SingleChildScrollView(
      child: Container(margin: EdgeInsets.only(top: 120.0, left: 10.0, right: 10.0),
              child: Center(
                child: Column(
                children: <Widget>[
                  productdownValue(bloc),
                  stdQtnpopupPaymentTerm(bloc),
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
     //ProductApiProvider wlApi = new ProductApiProvider();
     bloc.initiateProducts(); 
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
            // bloc.initiateProductList(ssWLDD.data);
            return SizedBox(width: 300, child: InputDecorator(decoration: InputDecoration(labelText: 'Product Code'),
              child:DropdownButtonHideUnderline(
                child:  DropdownButton<String>(
                isDense: true,
                items: ssWLDD.data // products  
                .map<DropdownMenuItem<String>>(
                (Product dropDownStringitem){ 
                  return DropdownMenuItem<String>(
                    value: dropDownStringitem.productCode.toString(), 
                    child: Text(dropDownStringitem.description),);},).toList(),
                    value: snapshot.data,
                    onChanged: bloc.qCusProdCodePUChanged,
                    isExpanded: true,
                    elevation: 10,
                  ) ) ) );
          } else { return CircularProgressIndicator(); }
        });
      //});
  });
}

stdQtnpopupPaymentTerm(Bloc bloc)
{
   bloc.initiateCurrencys(); 
  return StreamBuilder<String>(
    stream: bloc.qCusPaymentPU,
    builder: (context,snapshot)
    {
      //_controller.value = _controller.value.copyWith(text: snapshot.data);
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
                value: dropDownStringitem.currencyCode, 
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
  return StreamBuilder<String>(
    stream: bloc.qCusSellratePU,
    builder:(context,snapshot){
      if(snapshot.hasData)
      {_controller.value = _controller.value.copyWith(text: snapshot.data.toString());}

      return SizedBox(width: 300.0,child: TextField( 
        controller: _controller,
        onChanged: bloc.qCusSellratePUChanged,
        keyboardType: TextInputType.numberWithOptions(),
        decoration: InputDecoration(labelText: 'SellRate'),) );
    }); 
}


custNameTxt(Bloc bloc)
{
  return StreamBuilder<String>(
    stream: bloc.seCustAddress,
    builder:(context,snapshot)
    { return
      SizedBox(width: 300.0,child: TextField(onChanged: bloc.seCustAddressChanged,
      //keyboardType: TextInputType.text,
      decoration: InputDecoration(labelText: 'SellRate'),) );
    }); 
}


Widget saveFlatbtn(BuildContext context, Bloc bloc)
{
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        FlatButton(child: Text('CANCEL',style: TextStyle(color: Colors.blue),),
          onPressed: () {Navigator.of(context).pop();},),
        FlatButton( child: Text( 'SAVE', style: TextStyle(color: Colors.blue),),
          onPressed: (){bloc.addQuotationItems();
          bloc.clearDisplay4EditQuotItem(); 
           Navigator.of(context).pop();}
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

  Widget row(Customer customer) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          customer.customerName,
          style: TextStyle(fontSize: 16.0),
        ),
        SizedBox(
          width: 10.0,
        ),
        // Text(
        //   user.email,
        // ),
      ],
    );
  }

  autoSearchTxtFld(Key key, List<Customer> customers )
  {
    return AutoCompleteTextField<Customer>(
      key: key,
      clearOnSubmit: false,
      suggestions: customers,
      style: TextStyle(color: Colors.black, fontSize: 16.0),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
        hintText: "Search Name",
        hintStyle: TextStyle(color: Colors.black),),
        itemFilter: (item, query) 
        {
          return item.customerName.toLowerCase().startsWith(query.toLowerCase());
        },
        itemSorter: (a, b) {
          return a.customerName.compareTo(b.customerName);
        },
        itemSubmitted: (item)
        {print('Selected name is ' + item.customerName);},
        itemBuilder: (context, item)
        {
          return row(item);
        },
      );
  }


  customerDD(Bloc bloc,bool isInEditMode, List<Customer> customers) //, String quotNo, Key key, List<Customer> customers)
  {
    //CustomerApiProvider payApi = new CustomerApiProvider();
    return StreamBuilder<String>(
      stream: bloc.qCusCCode,
      builder: (context,snapshot)
      {
        return StreamBuilder(
          stream: bloc.initCustomers,
          builder: (context,ssWLDD)
          { 
            if (ssWLDD.hasData)
            {
              // bloc.initiateCustomerList(ssWLDD.data);
              //bloc.fetchQuotation(quotNo);
              //_controller.value = _controller.value.copyWith(text: snapshot.data);
              //print(snapshot.data.toString());
              return SizedBox(width: 300,
              child: InputDecorator(
                decoration: InputDecoration(labelText: 'Customer'),
                child:DropdownButtonHideUnderline(
                  child:  DropdownButton<String>(
                    isDense: true,
                    items: ssWLDD.data //customers
                    .map<DropdownMenuItem<String>>((Customer dropDownStringitem)
                    { return DropdownMenuItem<String>(
                      value: dropDownStringitem.customerCode.trim(), 
                      child: Text(dropDownStringitem.customerName));},
                      //child: autoSearchTxtFld(key, ssWLDD.data));},
                      //child: Text(dropDownStringitem.customerName));},
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

  cusEffecDateTxtFld(Bloc bloc,bool isInEditMode)
  {
    TextEditingController _controller = new TextEditingController();
    bloc.initDateCust(isInEditMode);
    print('is Edit' + isInEditMode.toString());
    return StreamBuilder( 
          stream: bloc.qCustEffDate,
          builder:(context,snapshot)
          {
          _controller.value = _controller.value.copyWith(text: DateFormat("dd/MM/yyyy").format(DateTime.parse(snapshot.data)));
          print('HERE is the EFF date:' + snapshot.data.toString());
          return     
          SizedBox(width:300,
            child:new TextField(
              decoration: const InputDecoration(
                hintText: 'Enter your Effective Date',
                labelText: 'Effctive Date:',
                    ),
                    onChanged: bloc.qCustEffDateChanged,
                    controller: _controller,
                    keyboardType: TextInputType.datetime,
                  ),
                ); 
              } 
            ); 
  }


  cusEffecDate(Bloc bloc,bool isInEditMode)
  {
    TextEditingController _controller = new TextEditingController();
    final formats = { InputType.date: DateFormat('dd/MM/yyyy'),};
    InputType inputType = InputType.date;
    bloc.initDateCust(isInEditMode);
    return StreamBuilder<DateTime>( 
      stream: bloc.qCusEffecDate,
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
            editable: isInEditMode,        
            decoration: const InputDecoration(
              labelText: 'Effective Date',
              ), 
              onChanged: bloc.qCusEffecDateChanged,
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
    return StreamBuilder<DateTime>( 
        stream: bloc.qCusExprDate,
        builder:(context,snapshot)
        { if(snapshot.hasData)
          {_controller.value = _controller.value.copyWith(text:  DateFormat("dd/MM/yyyy").format(snapshot.data));}
          return SizedBox(width:300,
          child: new DateTimePickerFormField(
            controller: _controller,
            inputType: inputType,
            format: formats[inputType],
            //editable: editable,
            // initialValue: DateTime.now(),
            decoration: const InputDecoration(
            // prefixIcon: const Icon(Icons.calendar_today, color: Colors.green), 
            labelText: 'Expiry Date',
            //hasFloatingPlaceholder: true
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
        await poAPI.saveCustQuotaion(bloc.getQuotationHD("CUSTOMER", quotNo))
        .then((isSuccess) { if(isSuccess) 
          { StaticsVar.showAlert(context,'Customer Quotation Saved'); 
            bloc.clearQuotationHD();
            Navigator.push(context, MaterialPageRoute(builder: (context)=> QuotationTab(loginInfo: loginInfo,tabIndexno:1))); }},
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
    print('Items Length: ' + poData.length.toString());
      return ListView.builder(
          itemCount: poData.length,
          itemBuilder: (context, index) 
          { return Container(height: 80.0,padding: EdgeInsets.only(top:15.0),
              child: Card(
                margin: EdgeInsets.only(right: 5.0, left: 5.0),
                elevation: 10.0,
                child: ListTile(
                  title: Row(children: <Widget>[
                    Expanded(flex: 4,child: Text('Product:'),),
                    // Expanded(flex: 3,child: Text(poData[index].productCode),),
                    Expanded(flex: 6,child: Text(poData[index].productDescription),),
                  ],),
                  //  Text('Product:   ' + poData[index].productCode),
                  trailing: Row(mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton( icon: Icon(Icons.edit),
                      onPressed:(){bloc.display4EditQuotaionItem(poData[index].productCode);
                       _showDialog(context, bloc);}),
                    IconButton( icon: Icon(Icons.delete), onPressed:(){ bloc.deleteQuotaionItem(poData[index].productCode);
                      StaticsVar.showAlert(context, "Product Deleted"); } ),

                    ],
                  ),
                  //  IconButton( icon: Icon(Icons.delete), onPressed:(){ bloc.deleteQuotaionItem(poData[index].productCode);
                  //  StaticsVar.showAlert(context, "Product Deleted"); }),
                  subtitle: Container(
                    child: Align(
                    alignment: Alignment.centerLeft,
                      child: Column(
                      children: <Widget>[
                        //Text('Description:' + poData[index].description),
                        //Text('Qty:    ' + poData[index]..toString()),
                         Row(children: <Widget>[
                    Expanded(flex: 4,child: Text('Sell Rate:' ),),
                    Expanded(flex: 6,child: Text(poData[index].sellRate.toString()),),
                  ],),
                  Row(children: <Widget>[
                    Expanded(flex: 4,child: Text('Currency Code:' ),),
                    Expanded(flex: 6,child: Text(poData[index].currencyCode),),
                  ],),
                        // SizedBox(width: 250,child: Text('Sell Rate:    ' + poData[index].sellRate.toString())),
                        // SizedBox(width: 250,child: Text('Currency Code:    ' + poData[index].currencyCode)),
                      ],
                    )),
                  )),
              )); 
        });
    //} else { return Center(child:CircularProgressIndicator());}
  });
}

// getProdDtls(String description)
// {
//    List<ProductModel>  ProductModel= [];

//    ProductApiProvider prodApi = new ProductApiProvider();
//    prodApi.productList();


//    return 


// }