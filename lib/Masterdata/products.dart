import 'package:flutter/material.dart';
import 'package:split/Bloc/Bloc.dart';
import 'package:split/Bloc/provider.dart';
import 'package:split/Masterdata/masterdatatab.dart';
import 'package:split/Masterdata/productPopUp.dart';
import 'package:split/src/APIprovider/masterProductApiProvider.dart';
import 'package:split/src/Models/loginmodel.dart';

class ProductPage extends StatefulWidget
{
  final Users loginInfo;
  ProductPage({Key key, @required this.loginInfo}) :super(key: key);
  @override
  _ListCardsState createState() => _ListCardsState();
}

class _ListCardsState extends State<ProductPage> {

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffd35400),
            title: Text('Product List'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MasterDataTab(loginInfo: widget.loginInfo)));
              },
            ),
          ),
          body:Container(child: listTile(bloc)),
          
          floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xffd35400),
          child: Icon(Icons.add),
          onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Productpopup(loginInfo: widget.loginInfo, prodCode: "")));
          },
      ),

    ); 
  }

  Widget listTile(Bloc bloc) 
  {
    ProductApiProvider proApi = new ProductApiProvider();
    return FutureBuilder(
      future: proApi.productList(),
      builder: (context, ssProduct) {
      if (ssProduct.hasData) {
          //  bloc.initiateProductList(ssProduct.data);
      return ListView.builder(
          itemCount: ssProduct.data.length,
          itemBuilder: (context, index) {
          return Container(height: 80.0,padding: EdgeInsets.only(top:15.0),child:Card(
          margin: EdgeInsets.only(right: 10.0, left: 10.0),
          elevation: 10.0,
          child: ListTile(
            title: Row(children: <Widget>[
                Expanded(flex: 5,child:Text('Product:'),),
                Expanded(flex: 5,child: Text(ssProduct.data[index].description.trim()),)
              ],), 
            onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>
                  Productpopup(loginInfo: widget.loginInfo,
                  prodCode: ssProduct.data[index].productCode,            
                  )));},
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: ()async { 
                ProductApiProvider proApi = new ProductApiProvider();
                await (proApi.delProducts(ssProduct.data[index].productCode)).then((onValue)
                {
                  if(onValue == true){ //StaticsVar.showAlert(context, ssProduct.data[index].productCode + ' Deleted');
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductPage(loginInfo: widget.loginInfo,)));
                    }else {return  Exception('Loading Failed');} 
                });
              },),
            subtitle: Container(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                    Expanded(flex: 5,child:Text('Category:'),),
                      // SizedBox(width: 20,),
                        Expanded(flex: 5,child: Text(ssProduct.data[index].productCategory))
                  ],),
                  // Text('Category: ' + ssProduct.data[index].productCategory),
                ],)
              ),
            )
          ),
          ) );
        });
      } else {return Center(child: CircularProgressIndicator(),);}
    });
  }
}

