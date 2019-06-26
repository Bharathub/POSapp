import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:split/Bloc/Bloc.dart';
import 'package:split/Bloc/provider.dart';
import 'package:split/Masterdata/promotion.dart';
import 'package:split/src/APIprovider/promotionApiProvider.dart';
import 'package:split/src/Models/loginmodel.dart';
import 'package:split/src/Models/productModel.dart';
import 'package:split/src/Models/promotionModel.dart';

class Prmotionpopup extends StatefulWidget {
  
  final  Users loginInfo;
  final String promoID;
  // final DateTime effecDate;
  // final DateTime exprDate;
  Prmotionpopup({Key key, @required this.loginInfo,this.promoID}) :super(key: key);

  @override
  _PrmotionpopupState createState() => _PrmotionpopupState();
}

class _PrmotionpopupState extends State<Prmotionpopup> 
{
 
  int intCount = 0;
  @override
  Widget build(BuildContext context) 
  {
    var bloc = Provider.of(context);
    
    bool isInEditMode = (widget.promoID != ""); // true : means Edit mode // false: means New Quotation

    // if(isInEditMode) 
    // { 
      intCount = intCount+1; print('No Of Times Executed: ' + intCount.toString()); 
      if(intCount==1) {bloc.initiateProducts(true); bloc.fetchPromotion(widget.promoID);}
    // }

    // bloc.setPromotionDtls(widget.effecDate,widget.exprDate);
    // isEditable = (widget.prodDD == "");
    return MaterialApp(
      home: Scaffold(
      appBar: AppBar(
      title: Text('Add/Edit Promotions'),
      backgroundColor: Color(0xffd35400),
      leading: IconButton(
      icon: Icon(Icons.arrow_back),
      color: Colors.white,
      onPressed: (){Navigator.push(context,MaterialPageRoute(builder: (context) => PromotionList(loginInfo: widget.loginInfo,)));},
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: 500.0,
            margin: EdgeInsets.only(top: 100.0, left: 5.0, right: 5.0,),
            child: Card(
            elevation: 10,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
            productdownValue(bloc, isInEditMode),
            effectiveDate(bloc,isInEditMode),
            expiringDate(bloc),
            promotionTypeDD(bloc, !isInEditMode),
            Wrap(
              direction: Axis.horizontal,
              spacing: 10.0,
              children: <Widget>[            
              //discountTxtFld(bloc),
              dispDDbox(bloc,isInEditMode),
              disptxtFields(bloc,isInEditMode),
              // amountTxtFld(bloc), 
              // //productsdownValue(bloc),           
              // qntyTxtFld(bloc),
              ]
            ),
            saveFlatbtn(context, bloc, widget.loginInfo, widget.promoID),
                  ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


  productdownValue(Bloc bloc,bool isInEditMode)
  {
    // ProductApiProvider wlApi = new ProductApiProvider();
    return StreamBuilder<String>(
      stream: bloc.promoCodedd,
      builder: (context,snapshot)
      {
        return StreamBuilder(
        stream: bloc.initProducts,
        builder: (context,ssWLDD)
        {
          if (ssWLDD.hasData)
          {
            //var proditems = ssWLDD.hasData ? ssWLDD.data : bloc.initProducts;
            //bloc.initiateProductList(ssWLDD.data);
            return SizedBox(width: 300, child: InputDecorator(
              decoration: InputDecoration(labelText: 'Product Code'),
              child: new IgnorePointer(
              ignoring: isInEditMode,
                child:   DropdownButtonHideUnderline(
                  child:  DropdownButton<String>(
                  isDense: true,
                  items: ssWLDD.data
                  .map<DropdownMenuItem<String>>(
                    (Product dropDownStringitem){
                      return DropdownMenuItem<String>(
                        value: dropDownStringitem.productCode.toString(),
                        child: Text(dropDownStringitem.description),);},).toList(),
                        value: snapshot.data,
                        onChanged: bloc.promoCodeddChanged,
                        isExpanded: true,
                        elevation: 10,
                       
                  ) ) ) ));
        } else { return CircularProgressIndicator(); }
        });
    });
}


effectiveDate(Bloc bloc,bool isInEditMode)
{
  TextEditingController _controller = new TextEditingController();
  final formats = { InputType.date: DateFormat('dd/MM/yyyy'),};
  InputType inputType = InputType.date;
  bloc.initDatePromotion(isInEditMode);
  
  return StreamBuilder(
    stream: bloc.effectivePromo,
    builder:(context,snapshot){
       if(snapshot.hasData)
        {_controller.value = _controller.value.copyWith(text:  DateFormat("dd/MM/yyyy").format(snapshot.data));}
          
    return SizedBox(width:300,
    child: new DateTimePickerFormField(
      controller: _controller, 
      inputType: inputType,
      format: formats[inputType],
      enabled: (!isInEditMode),
      initialValue: DateTime.now(),
      decoration: const InputDecoration(
      // prefixIcon: const Icon(Icons.calendar_today, color: Colors.green), 
      labelText: 'Effective Date',
      hasFloatingPlaceholder: true
      ), 
      onChanged: bloc.effectivePromoChanged
          ), 
        ); }
    );
 }
//  setState(DateTime Function() date) {}


 expiringDate(Bloc bloc)
 {
   TextEditingController _controller = new TextEditingController();
  final formats = { InputType.date: DateFormat('dd/MM/yyyy'),};
  InputType inputType = InputType.date;
  bool editable = true;
  return StreamBuilder<DateTime>(
    stream: bloc.expiryPromo,
    builder:(context,snapshot){
    if(snapshot.hasData)
        {_controller.value = _controller.value.copyWith(text:  DateFormat("dd/MM/yyyy").format(snapshot.data));}
             
      return  SizedBox( width:300,child:  new DateTimePickerFormField(
          controller: _controller,
          inputType: inputType,
          format: formats[inputType],
          editable: editable,
          decoration: const InputDecoration(
          //prefixIcon: const Icon(Icons.calendar_today, color: Colors.green), 
          labelText: 'Expiring Date',
          hasFloatingPlaceholder: true
          ), 
          onChanged: bloc.expiryPromoChanged,
          ),
        );
      }
    );

 }

  promotionTypeDD(Bloc bloc,bool isInEditMode)
  {  
    List<String> _promType = ['DISCOUNT','FREE PRODUCTS'];

    return StreamBuilder(
      stream: bloc.promoType,
      builder: (context,snapshot)
      {
        return SizedBox(width: 300,
          child:InputDecorator(
          decoration: InputDecoration(
            labelText: 'Promotion Type'),
            child:new IgnorePointer(
              ignoring: !isInEditMode,
              child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isDense: true,
                      items: _promType
                      .map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                          }
                      ).toList(),
                      value: snapshot.data,
                      onChanged: bloc.promoTypeChanded,
                      // hint: Text('Select Promotions Types'),
                      isExpanded: true,
                      elevation: 8,
                    ),
             ), ),
              ),
            );
        }
      );
  }

  dispDDbox(Bloc bloc,bool isInEditMode)
  {
    return StreamBuilder(
      stream: bloc.promoType ,
      builder: (context, sspromotype)
      { if (sspromotype.hasData)
        {
        if (sspromotype.data == 'DISCOUNT')
        { return discountTxtFld(bloc,isInEditMode);}
        else
        { return productsdownValue(bloc,isInEditMode);}}
        else {return Container(height: 1.0,width: 1.0,);}
      });
  }
  
  disptxtFields(Bloc bloc,bool isInEditMode)
  {
    return StreamBuilder(
      stream: bloc.promoType ,
      builder: (context, sspromotype)
      { if(sspromotype.hasData){
        if (sspromotype.data == 'DISCOUNT')
        { return amountTxtFld(bloc);}
        else
        { return qntyTxtFld(bloc);}}
        else {return Container(height: 1.0, width: 1.0,);}
      });
  }


  discountTxtFld(Bloc bloc,bool isInEditMode)
  {   
    List<String> _discounttype = ['PERCENTAGE','AMOUNT'];
    return StreamBuilder(
    stream: bloc.discountPromo,
    builder: (context,snapshot){
      return SizedBox(width: 300,
      child:InputDecorator(
        decoration: InputDecoration(
          labelText: 'Discount Type'),
        child: new IgnorePointer(
          ignoring: isInEditMode,
          child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
          isDense: true,
          items: _discounttype
            .map<DropdownMenuItem<String>>(
            (String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
            }).toList(),
          value: snapshot.data,
          onChanged: bloc.discountPromoChanged,
          // hint: Text('Select Discount Types'),
          isExpanded: true,elevation: 8,
                  ),
          )  ),
            ),
          );
    }
    );
  }
  

  amountTxtFld(Bloc bloc)
  {  TextEditingController _controller = new TextEditingController();
    return StreamBuilder<String>(
    stream: bloc.amountPromo,
    builder:(context,snapshot)
    {
       if(snapshot.hasData)
      {_controller.value = _controller.value.copyWith(text: snapshot.data.toString());}
      return SizedBox(
        width: 300.0,
        child: TextField(onChanged: bloc.amountPromoChanged, 
        keyboardType: TextInputType.numberWithOptions(),
        decoration: InputDecoration(labelText: 'Amount/Percentage'),
        controller: _controller,
          )
        );
    },
    );
  }

  productsdownValue(Bloc bloc,bool isInEditMode)
  {  
    // ProductApiProvider wlApi = new ProductApiProvider();
    return StreamBuilder<String>(
    stream: bloc.promoCodesdd,
    builder: (context,snapshot)
    {
    return StreamBuilder(
      stream:bloc.initProducts,
      builder: (context,ssWLDD)
      { 
      if (ssWLDD.hasData)
        {
        return SizedBox(width: 300, 
        child: InputDecorator(
          
          decoration: InputDecoration(
          labelText: 'Discount Product Code'),
          child: new IgnorePointer(
            ignoring: isInEditMode,
            child: 
          DropdownButtonHideUnderline(
            child:  DropdownButton<String>(
              isDense: true,
              items: ssWLDD.data
              .map<DropdownMenuItem<String>>(
              (Product dropDownStringitem){ 
              // print('product Code : ' + dropDownStringitem.productCode);
              // print('Stream Code : ' + snapshot.data);
              return DropdownMenuItem<String>(
                      value: dropDownStringitem.productCode.trim(), 
                      child: Text(dropDownStringitem.description),
                    );},
              ).toList(),
            value: snapshot.data,
            onChanged: bloc.promoCodesddChanged,
            isExpanded: true,
            elevation: 10,
          )) ) ) );
        }else { return CircularProgressIndicator(); }
        });
      });
  }

  qntyTxtFld(Bloc bloc)
  {
    TextEditingController _controller = new TextEditingController();
    return StreamBuilder<String>(
    stream: bloc.qtypromo,
    builder:(context,snapshot)
    {
       if(snapshot.hasData)
      {_controller.value = _controller.value.copyWith(text: snapshot.data.toString());}
      return SizedBox(width: 300.0,
          child: TextField(
          keyboardType: TextInputType.numberWithOptions(),
          onChanged: bloc.qtypromoChanded, 
          decoration: InputDecoration(labelText: 'Qty'),
          controller: _controller,),
          
           );}
           );
  }

  Widget saveFlatbtn(BuildContext context, Bloc bloc, Users loginInfo, String promoID )
  {
    PromotionApiProvider promApi = PromotionApiProvider();
    return Container(
      child:  Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
      FlatButton(child: Text('CANCEL',style: TextStyle(color: Colors.blue),),
      onPressed: () {Navigator.pop(context);},),
      FlatButton( child: Text( 'SAVE', style: TextStyle(color: Colors.blue),),
      onPressed: ()
      async{PromotionMod savePromoDtls = new PromotionMod();  
            savePromoDtls=bloc.savePromoDtls(promoID);
            await promApi.savePromotionList(savePromoDtls).then((onValue){
            if(onValue == true){
              bloc.clearPromotions();
              Navigator.push(context, MaterialPageRoute(builder: (context)=> PromotionList(loginInfo:loginInfo) ));
              }else {return  Exception('Failed to Save Promotions');} }
              );
        }, ),
            ],
          ),
        );
   
  }
