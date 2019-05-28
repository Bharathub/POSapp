import 'package:flutter/material.dart';
import 'package:split/Bloc/Bloc.dart';
import 'package:split/Bloc/provider.dart';
import 'package:split/src/APIprovider/branchApiProvider.dart';
import 'package:split/src/APIprovider/inquiryApiProvider.dart';
import 'package:split/src/APIprovider/masterProductApiProvider.dart';
import 'package:split/src/APIprovider/productCategoryApiprovider.dart';
import 'package:split/src/APIprovider/supplierApiProvider.dart';
import 'package:split/src/Models/branchmodel.dart';
import 'package:split/src/Models/inquiryModel.dart';
import 'package:split/src/Models/loginmodel.dart';
import 'package:split/src/Models/productModel.dart';
// import 'package:split/src/Models/productModel.dart';
import 'package:split/src/Models/productcategorymodel.dart';
import 'package:split/src/Models/suppliermodel.dart';
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
    return Scaffold(
          
            body: Center(
            child:
            Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
               branchdownValue(bloc),
               productdownValue(bloc),
               categorydownValue(bloc),
               suppsupCodedownValue(bloc),
               searchbtn(context, bloc,widget.loginInfo),
              //  listTile(bloc),

            ],)),

    ); 
  }

 


  branchdownValue(Bloc bloc)
  {  
                                   BranchApiProvider brApi = new BranchApiProvider();
             //  LookUpApiProvider proApi = LookUpApiProvider();
                        
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
                        return SizedBox(width: 300, child: InputDecorator(decoration: InputDecoration(labelText: 'Branch'),
                        child:DropdownButtonHideUnderline(
                        child:  DropdownButton<String>(
                        isDense: true,
                        items: ssWLDD.data
                        .map<DropdownMenuItem<String>>(
                        (BranchModel dropDownStringitem){ 
                        return DropdownMenuItem<String>(
                        value: dropDownStringitem.branchCode.toString(), 
                        child: Text(
                          dropDownStringitem.branchCode 
                              ),
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
                                   ProductApiProvider wlApi = new ProductApiProvider();
             //  LookUpApiProvider proApi = LookUpApiProvider();
                        
                            return StreamBuilder<String>(
                            stream: bloc.prodcatInqdd,
                            builder: (context,snapshot)
                            {
                              return FutureBuilder(
                           future: wlApi.productList(),
                           builder: (context,ssWLDD)
                           { 
                           if (ssWLDD.hasData)
                         {
                        return SizedBox(width: 300, child: InputDecorator(decoration: InputDecoration(labelText: 'Product Name'),
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
              ProductCateProvider proApi = new ProductCateProvider();
             //  LookUpApiProvider proApi = LookUpApiProvider();
                        
                            return StreamBuilder<String>(
                            stream: bloc.catInqdd,
                            builder: (context,snapshot)
                            {
                              return FutureBuilder(
                           future: proApi.productCatList(),
                           builder: (context,ssProDD)
                           { 
                           if (ssProDD.hasData)
                         {
                        return SizedBox(width: 300, child: InputDecorator(decoration: InputDecoration(labelText: 'Category'),
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
                  SupplierApiProvider wlApi = new SupplierApiProvider();
             //  LookUpApiProvider proApi = LookUpApiProvider();
                        
                            return StreamBuilder<String>(
                            stream: bloc.supplierCodeInqdd,
                            builder: (context,snapshot)
                            {
                              return FutureBuilder(
                           future: wlApi.supplierList(),
                           builder: (context,ssWLDD)
                           { 
                           if (ssWLDD.hasData)
                         {
                        return SizedBox(width: 300, child: InputDecorator(decoration: InputDecoration(labelText: 'Supplier / Supplier Code'),
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
    InquiryApi inqApi = InquiryApi();
    return  
      Center(
        child:  RaisedButton(
        color: Colors.red,
        child: Text('Search',style: TextStyle(color: Colors.white),),
        onPressed: ()
        async{
        InquiryModel inqmod = InquiryModel();
        inqmod=bloc.saveInqdtls();
        await inqApi.inquiryList(inqmod).then((onValue){
        if(onValue.isEmpty){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> StockInquiry(loginInfo:loginInfo,) ));
         }else {return  Exception('Failed to Show Inquiry');} }
                    );},

 
     ),
    );
   
  }
}
