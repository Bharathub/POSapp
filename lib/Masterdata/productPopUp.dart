import 'package:flutter/material.dart';
import 'package:split/Bloc/Bloc.dart';
import 'package:split/Bloc/provider.dart';
import 'package:split/Masterdata/products.dart';
import 'package:split/src/APIprovider/masterProductApiProvider.dart';
import 'package:split/src/Models/loginmodel.dart';
import 'package:split/src/Models/lookupModel.dart';
import 'package:split/src/Models/productModel.dart';
import 'package:split/src/Models/productcategorymodel.dart';

class Productpopup extends StatefulWidget {

   final  Users loginInfo;
   final String prodCode;

  Productpopup({Key key, @required this.loginInfo,this.prodCode}) :super(key: key);
  @override
  _ProductpopupState createState() => _ProductpopupState();
}

class _ProductpopupState extends State<Productpopup> 
{
  //final bloc = Bloc();
  bool isInEditMode = false;
  int intCount = 0;
  ProductApiProvider proApi = ProductApiProvider();

  @override
  Widget build(BuildContext context) 
  {
    var bloc = Provider.of(context);
    isInEditMode = (widget.prodCode != "");
    
    //if(isInEditMode) // If old record Editing
    { intCount = intCount+1; print('EDIT MODE:-> No Of Times Executed: ' + intCount.toString()); 
      if(intCount==1) 
      { bloc.initiateUOMs(true); 
        bloc.initiateProdCategorys(true); 
        bloc.initiateLocation(true);
        bloc.fetchProdutDtls(widget.prodCode); }}
    //else {print('In Add MODE' + widget.prodCode); bloc.clearProductDtls();}  // If new record


   // bloc.setProducttDtls(widget.product, widget.catgCode); // Bharat: Find out why we are using this???
    // isInEditMode = (widget.productcode != "");
    return MaterialApp(
        home: Scaffold(
        appBar: AppBar(
        title: Text('Add/Edit Products'),
        backgroundColor: Color(0xffd35400),
        leading: IconButton(
        icon: Icon(Icons.arrow_back),
        color: Colors.white,
        onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context) => ProductPage(loginInfo: widget.loginInfo,)));},
            ),
          ),
        body: SingleChildScrollView(
          child: Container(padding: EdgeInsets.only(bottom: 50.0),
             margin: EdgeInsets.only(top: 50.0, left: 5.0, right: 5.0),
            child: Card(
            elevation: 10,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
            SizedBox(width: 300,child:proDesTxtFld(bloc, isInEditMode)),
            proBarCodeTxtFld(bloc),
            uomCountUnitDropDwn(bloc),
            colorTxtFld(bloc),
            reOrderQtyTxtFld(bloc),
            categoryProDrpDwn(bloc),
            sizeProdTxtFld(bloc),
            whLocationDrpDwn(bloc),
            SizedBox(height: 10.0),
            saveFlatbtn(context, bloc ,widget.loginInfo,widget.prodCode),
                  ],
              ),
            ), 
          ),
        ),
      ),
    );
  }
}

  Widget proDesTxtFld(Bloc bloc, bool isInEditMode)
  {
    TextEditingController _controller = new TextEditingController();
    return StreamBuilder(
      stream: bloc.prodDesCode,
      builder: (context, snapshot) 
        { 
          if(snapshot.hasData) {_controller.value = _controller.value.copyWith(text: snapshot.data);}
          //print(snapshot.data.toString());
          return TextField(
            onChanged: bloc.proDesChanged,
            controller: _controller,
            textCapitalization: TextCapitalization.characters,
            decoration: InputDecoration(labelText: 'Description'),
          );
        }
      );
    
  }
  // proDesTxtFld(Bloc bloc)
  // {  
  //             return StreamBuilder<String>( 
  //             stream: bloc.prodDesCode,
  //             builder:(context,snapshot)=>
  //             SizedBox( width: 300.0,
  //             child:TextField(
  //             onChanged: bloc.proDesChanged,  
  //             decoration:InputDecoration(labelText: 'Description'),) ),);
  
  // }


  proBarCodeTxtFld(Bloc bloc)
  {  
    TextEditingController _controller = new TextEditingController();
    return StreamBuilder<String>(
    stream: bloc.prodBarCode,
    builder:(context,snapshot){
      if(snapshot.hasData) {_controller.value = _controller.value.copyWith(text: snapshot.data);}
      return  SizedBox(
        width: 300.0,  
        child: TextField(
        onChanged: bloc.propopBarCodeChanged,
        controller: _controller,
        keyboardType: TextInputType.numberWithOptions(),
        decoration: InputDecoration(labelText:'Bar Code'),) );});
  }



 Widget uomCountUnitDropDwn(Bloc bloc) //DropDown
 {    

    // LookUpApiProvider proApi = new LookUpApiProvider();
    return StreamBuilder<String>(
        stream: bloc.prodcatUOMdd,
        builder: (context,snapshot)
        {
          return StreamBuilder(
          stream: bloc.initUOM,
          builder: (context,ssProDD)
          { 
          if (ssProDD.hasData)
            {
            return SizedBox(
              width: 300,
              child: InputDecorator(
                decoration: InputDecoration(labelText: 'UOM'),
                  child:DropdownButtonHideUnderline(
                  child:  DropdownButton<String>(
                  // isDense: true,
                  items: ssProDD.data
                  .map<DropdownMenuItem<String>>(
                  (Lookup dropDownStringitem){ 
                  return DropdownMenuItem<String>(
                    value: dropDownStringitem.lookupCode.toString(), 
                    child: Text(dropDownStringitem.description),
                    );},
                  ).toList(),
                  value: snapshot.data,
                  onChanged: bloc.proUOMMasterddChanged,
                  isExpanded: true,
                  elevation: 10,
                ) ) ) );
            }else { return CircularProgressIndicator(); }
        });
      });
        

  }
// void setState(Null Function() param0) {}

 colorTxtFld(Bloc bloc)
 {
       TextEditingController _controller = new TextEditingController();
       return StreamBuilder<String>(
        stream: bloc.prodColor,
        builder:(context,snapshot){
          if(snapshot.hasData) {_controller.value = _controller.value.copyWith(text: snapshot.data);}
          return SizedBox(
          width: 300.0,
          child: TextField
          (onChanged: bloc.proColorChanged,
          controller: _controller, 
          decoration: InputDecoration(labelText: 'Color'),) );});
}


  reOrderQtyTxtFld(Bloc bloc)
  {
    TextEditingController _controller = new TextEditingController();
    return StreamBuilder<String>(
      stream: bloc.prodreOrderQty,
      builder:(context,snapshot){
      if(snapshot.hasData) {_controller.value = _controller.value.copyWith(text: snapshot.data);}
      return SizedBox(width: 300.0,
      child:Column(children: <Widget>[
        TextField(
          onChanged: bloc.prodReOrderChanged,
          controller: _controller, 
          keyboardType: TextInputType.numberWithOptions(),
          decoration: InputDecoration(labelText: 'Re-Order Qty'),)
      ],) 
    );});
  }

  categoryProDrpDwn(Bloc bloc)
  {
    //  ProductCateProvider proApi = new ProductCateProvider();
     return StreamBuilder<String>(
       stream: bloc.prodCateDD,
       builder: (context,snapshot)
       {
         return StreamBuilder(
          stream:bloc.initProdCategory,
          builder: (context,ssProDD)
          {
            if (ssProDD.hasData)
            {
              return SizedBox(width: 300, child: InputDecorator(
                decoration: InputDecoration(labelText: 'Category'),
                child:DropdownButtonHideUnderline(
                  child:  DropdownButton<String>(
                  isDense: true,
                  items: ssProDD.data
                  .map<DropdownMenuItem<String>>(
                  (ProductCategorys dropDownStringitem){ 
                    // print('Product category code : ' + dropDownStringitem.categoryCode);
                    // print('Product Description : ' + dropDownStringitem.description);
                    // print('Product Stream : ' + snapshot.data.toString());
                    return DropdownMenuItem<String>(
                      value: dropDownStringitem.categoryCode.trim(),
                      child: Text(dropDownStringitem.description),
                    );},
                  ).toList(),
                  value: snapshot.data,
                  onChanged: bloc.prodCateddChanged,
                  isExpanded: true,
                  elevation: 10,
                ) 
              ) ) );
            } else { return CircularProgressIndicator(); }
    });
  });
}

sizeProdTxtFld(Bloc bloc)
 {
   TextEditingController _controller = new TextEditingController();  
   return StreamBuilder<String>(
      stream: bloc.proSizeControll,
      builder:(context,snapshot)
      {
        if(snapshot.hasData) {_controller.value = _controller.value.copyWith(text: snapshot.data);}
        return SizedBox(width: 300.0,
          child: TextField(
            onChanged: bloc.proSizeChanged,
            controller: _controller,
            // keyboardType: TextInputType.numberWithOptions(),
            decoration: InputDecoration(labelText: 'Size'),) );
      });
}

  whLocationDrpDwn(Bloc bloc)
  {
    // WareHouseLocApi wlApi = new WareHouseLocApi();
    return StreamBuilder<String>(
      stream: bloc.whLocDD,
      builder: (context,snapshot)
      {
        return StreamBuilder(
          stream: bloc.initLocation,
          builder: (context,ssWLDD)
          { 
            if (ssWLDD.hasData)
            {
              return SizedBox(
                width: 300,
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'W/H Location'),
              child:DropdownButtonHideUnderline(
                child:  DropdownButton<String>(
                isDense: true,
                items: ssWLDD.data
                      .map<DropdownMenuItem<String>>(
                      (Lookup dropDownStringitem){ 
                      return DropdownMenuItem<String>(
                        value: dropDownStringitem.lookupCode.toString(), 
                        child: Text(dropDownStringitem.description),
                      );},
                      ).toList(),
                value: snapshot.data,
                onChanged: bloc.whLocDDChanged,
                isExpanded: true,
                elevation: 10,
                ) ) ) );
            } else { return CircularProgressIndicator(); }
          });
      });
  }

  Widget saveFlatbtn(BuildContext context, Bloc bloc, Users loginInfo,String productcode)
  {    ProductApiProvider productsApi = ProductApiProvider();
        return Container(
              child:  Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
              FlatButton(child: Text('CANCEL',style: TextStyle(color: Colors.blue),),

              onPressed: () {Navigator.pop(context);},),
              FlatButton( child: Text( 'SAVE', style: TextStyle(color: Colors.blue),),
              onPressed: ()
                async{Product proSavDtls = new Product();  
                proSavDtls=bloc.saveProductDtls(productcode);
                await productsApi.saveProductList(proSavDtls).then((onValue) {
                if(onValue == true)
                { //StaticsVar.showAlert(context, 'Product Saved');
                  bloc.clearProductDtls();
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductPage(loginInfo:loginInfo,)));
                }
                else {return  Exception('Failed to Save Products');} }
                );
                },),
              ],
            ),
          );
  }
