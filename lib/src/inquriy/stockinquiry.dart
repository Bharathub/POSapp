import 'package:flutter/material.dart';
import 'package:split/Bloc/Bloc.dart';
import 'package:split/Bloc/provider.dart';
import 'package:split/src/APIprovider/branchApiProvider.dart';
import 'package:split/src/Models/branchmodel.dart';
import 'package:split/src/Models/loginmodel.dart';
import 'package:split/src/Models/productModel.dart';
// import 'package:split/src/Models/productModel.dart';
import 'package:split/src/Models/productcategorymodel.dart';
import 'package:split/src/Models/suppliermodel.dart';
import 'package:split/src/inquriy/inquiryTab.dart';
// import 'package:split/Bloc/providers.dart';

// void main() => runApp(new StockInquiry()); //one-line function

class StockInquiry extends StatefulWidget {   
  final Users loginInfo;
  StockInquiry({Key key, @required this.loginInfo}) :super(key: key);  
  @override
  _ListCardsState createState() => _ListCardsState();
}

class _ListCardsState extends State<StockInquiry> 
{  
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of(context);
    bloc.initiateProducts(true);
    bloc.initiateProdCategorys(true);
    bloc.initiateSuppliers(true);
    bloc.clearStockInq();
    return Scaffold(
      appBar: new AppBar(
          title: new Text("Stock Inquiry"),
          backgroundColor: Color(0xffd35400),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.push(context,
              MaterialPageRoute(builder: (context) => Inquirys(loginInfo: widget.loginInfo,)));
            },
          ),
        ),          
            body:SingleChildScrollView(child: Center(
            child:Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10.0), 
                  // width: 400.0,height:220.0,
                  child:Card(child:Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        branchdownValue(bloc),
                      // Expanded(flex:5, child: branchdownValue(bloc),),
                      SizedBox(width: 10.0,),
                      productdownValue(bloc),
                      // Expanded(flex:5, child: productdownValue(bloc),),
                    ],),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                      // Expanded(flex:5, child: categorydownValue(bloc),),
                      categorydownValue(bloc),
                      SizedBox(width: 10.0,),
                      suppsupCodedownValue(bloc),
                      // Expanded(flex:5, child: suppsupCodedownValue(bloc),),
                    ],),                 
                    searchbtn(context, bloc,widget.loginInfo),
                  ],
                )
              )
            ),
                Divider(),
                Container( height: 620.0,child: listTile(bloc)) 
            ],)) ),

    ); 
  }

  branchdownValue(Bloc bloc)
  {
    BranchApiProvider brApi = new BranchApiProvider();                        
    return StreamBuilder<String>(
    stream: bloc.branchInqdd,
    builder: (context,snapshot)
    {
      return FutureBuilder(
    future: brApi.branchList(),
    builder: (context,ssWLDD)
    { 
    if (ssWLDD.hasData)
    {
      return SizedBox(width: 150, child: InputDecorator(decoration: InputDecoration(labelText: 'Branch'),
      child:DropdownButtonHideUnderline(
      child:  DropdownButton<String>(
      isDense: true,
      items: ssWLDD.data
      .map<DropdownMenuItem<String>>(
      (BranchModel dropDownStringitem){ 
      return DropdownMenuItem<String>(
      value: dropDownStringitem.branchCode.toString(), 
      child: Text(dropDownStringitem.branchCode  ),
          );},
      ).toList(),
      value: snapshot.data,
      onChanged: bloc.branchInqddChanged,
      isExpanded: true,
      elevation: 10,
          ) ) ) );
      } else { return CircularProgressIndicator(); }
      });
      });
  }


  productdownValue(Bloc bloc)
  {
    bloc.initiateProducts(false);
    return StreamBuilder<String>(
    stream: bloc.prodcatInqdd,
    builder: (context,snapshot)
    {
      return StreamBuilder(
    stream: bloc.initProducts,
    builder: (context,ssWLDD)
    { 
    if (ssWLDD.hasData)
  {
    return SizedBox(width: 150, child: InputDecorator(decoration: InputDecoration(labelText: 'Product Name'),
    child:DropdownButtonHideUnderline(
    child:  DropdownButton<String>(
    isDense: true,
    items: ssWLDD.data
    .map<DropdownMenuItem<String>>(
    (Product dropDownStringitem){ 
    return DropdownMenuItem<String>(
    value: dropDownStringitem.productCode.toString(), 
    child: Text(
      dropDownStringitem.description, 
      ),
      );},
        ).toList(),
        value: snapshot.data,
        onChanged: bloc.prodcatInqddChanged,
        isExpanded: true,
        elevation: 10,
        ) ) ) );
      } else { return CircularProgressIndicator(); }
      });
      });
  }


  categorydownValue(Bloc bloc)
  {
    bloc.initiateProdCategorys(false);
    return StreamBuilder<String>(
      stream: bloc.catInqdd,
      builder: (context,snapshot)
      {
        return StreamBuilder(
      stream: bloc.initProdCategory,
      builder: (context,ssProDD)
      { 
      if (ssProDD.hasData)
    {
      return SizedBox(width: 150, child: InputDecorator(decoration: InputDecoration(labelText: 'Category'),
      child:DropdownButtonHideUnderline(
      child:  DropdownButton<String>(
      isDense: true,
      items: ssProDD.data
      .map<DropdownMenuItem<String>>(
      (ProductCategorys dropDownStringitem){ 
      return DropdownMenuItem<String>(
      value: dropDownStringitem.categoryCode,
      child: Text(
        dropDownStringitem.description, 
            ),
            );},
        ).toList(),
          value: snapshot.data,
          onChanged: bloc.catInqddrddChanged,
          isExpanded: true,
          elevation: 10,
          ) ) ) );
      } else { return CircularProgressIndicator(); }
      });
      });
  } 



  suppsupCodedownValue(Bloc bloc)
  {
    bloc.initiateSuppliers(false);
     return StreamBuilder<String>(
      stream: bloc.supplierCodeInqdd,
      builder: (context,snapshot)
      {
        return StreamBuilder(
      stream: bloc.initSuppliers,
      builder: (context,ssWLDD)
      { 
      if (ssWLDD.hasData)
      {
        return SizedBox(width: 150, child: InputDecorator(decoration: InputDecoration(labelText: 'Supplier / Supplier Code'),
        child:DropdownButtonHideUnderline(
        child:  DropdownButton<String>(
        isDense: true,
        items: ssWLDD.data
        .map<DropdownMenuItem<String>>(
        (Supplier dropDownStringitem){ 
        return DropdownMenuItem<String>(
        value: dropDownStringitem.customerCode.toString(), 
        child: Text(
        dropDownStringitem.customerName, 
            ),
            );},
        ).toList(),
        value: snapshot.data,
        onChanged: bloc.supplierCodeInqddChanged,
        isExpanded: true,
        elevation: 10,
        ) ) ) );
        } else { return CircularProgressIndicator(); }
                          });
                          });
  }



  Widget searchbtn(BuildContext context, Bloc bloc,Users loginInfo)
  {
    // InquiryApi inqApi = InquiryApi();
    return  
      Center(
        child:  RaisedButton(
        color: Colors.red,
        child: Text('Search',style: TextStyle(color: Colors.white),),
        onPressed: ()
        {bloc.getSer4StockInq();},

 
     ),
    );
  }
  Widget listTile(Bloc bloc)
    {     
      return StreamBuilder(
        stream: bloc.stockInqDtls,
        builder: (context, ssUnAppInv) {
        List unBildInv = ssUnAppInv.hasData ? ssUnAppInv.data : <StockInquiry>[];
        print('inv length : ' + unBildInv.length.toString());
          return ListView.builder(
              itemCount: unBildInv.length,
              itemBuilder: (context, index)
              { 
                return Container(height: 95.0,padding: EdgeInsets.only(top:15.0),
                  child: Card(
                    margin: EdgeInsets.only(right: 8.0, left: 8.0),
                    elevation: 5.0,
                    child: ListTile(
                      title: Row(children: <Widget>[
                        Expanded(flex: 5,child:Text('Product Des:'),),
                        Expanded(flex: 5,child: Text(unBildInv[index].productDescription),),                            
                            ],
                          ),                                                  
                      subtitle: Container(
                      child: Align(
                      alignment: Alignment.centerLeft,
                        child: Column(
                        children: <Widget>[
                          Row(children: <Widget>[
                            Expanded(flex: 5,child:Text('Suppliers:'),),
                            Expanded(flex: 5,child: Text(unBildInv[index].suppliers),),                            
                            ],
                          ),                      
                          Row(children: <Widget>[
                            Expanded(flex: 5,child:Text('ProductCategory:'),),
                            Expanded(flex: 5,child: Text(unBildInv[index].productCategory),),                            
                            ],
                          ),

                          Row(children: <Widget>[
                          Expanded(flex: 5,child:Text('StockInHand:'),),
                          Expanded(flex: 5,child: Text(unBildInv[index].stockInHand.toString()),),                            
                          ],
                        ),
                        ],
                      )),
                    )),
                ));
              }
            );
      });
    }
}
