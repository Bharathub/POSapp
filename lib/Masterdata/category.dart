import 'package:flutter/material.dart';
import 'package:split/Bloc/Bloc.dart';
import 'package:split/Bloc/provider.dart';
import 'package:split/Masterdata/categorypopup.dart';
import 'package:split/Masterdata/masterdatatab.dart';
import 'package:split/src/APIprovider/productCategoryApiprovider.dart';
import 'package:split/src/Models/loginmodel.dart';
// import 'package:split/Bloc/providers.dart';

// void main() => runApp(new CategoryPage()); //one-line function

class CategoryPage extends StatefulWidget { 

  final Users loginInfo;
  CategoryPage({Key key, @required this.loginInfo}) :super(key: key);


  @override
  _ListCardsState createState() => _ListCardsState();
}

class _ListCardsState extends State<CategoryPage> {

  
  @override
  Widget build(context) {
    //final bloc = Bloc();

    var bloc = Provider.of(context);
    bloc.clearProdCatDtls();

    return Scaffold(
            appBar: AppBar(
            backgroundColor: Color(0xffd35400),
            title: Text('Product Category List'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
             color: Colors.white,

              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MasterDataTab(loginInfo: widget.loginInfo,)));
              },
            ),
          ),

      body: Container(
        child: listTile(bloc),
  ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffd35400),
        child: Icon(Icons.add),
        onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=> Categorypopup(loginInfo: widget.loginInfo,catCode: "",catDesc: "",)));
      
        },
      ),

    ); 
}

Widget listTile(Bloc bloc) {
  ProductCateProvider proCatApi = new ProductCateProvider();
  // ProductCategorys proCatDts = new ProductCategorys();

  return FutureBuilder(
      future: proCatApi.productCatList(),
              builder: (context, ssProCat) {
              if (ssProCat.hasData) {
              return ListView.builder(
              itemCount: ssProCat.data.length,
              itemBuilder: (context, index) {
                return Container(height: 80.0,padding: EdgeInsets.only(top:15.0),
                child:Card(                  
                  margin: EdgeInsets.only(right: 10.0, left: 10.0),
                  elevation: 10.0,
                  child: ListTile(
                  title:Row(children: <Widget>[
                    Expanded(flex: 4, child: Text('Code:'),),
                    Expanded(flex: 6, child: Text(ssProCat.data[index].categoryCode),)
                      ],),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                          Categorypopup(loginInfo: widget.loginInfo,catCode:  ssProCat.data[index].categoryCode.trim(),catDesc: ssProCat.data[index].description)));
                      },
                      trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: ()async {
                      ProductCateProvider lukup = new ProductCateProvider();
                          await (lukup.proCatDelt(ssProCat.data[index].categoryCode)).then((onValue)
                          {
                            if(onValue == true){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> CategoryPage(loginInfo: widget.loginInfo,)));
                            }else {return  Exception('Loading Failed');} 
                            }
                       );
                        },
                        ),
                      subtitle: Container(
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              children: <Widget>[
                                   Row(
                              children: <Widget>[
                               Expanded(flex: 4,child: Text('Description:'),),
                                // SizedBox(width: 20,),
                               Expanded(flex: 6,child: Text( ssProCat.data[index].description.trim()))

                              ],
                            ),
                            //   Row(
                            //   children: <Widget>[
                            //    Expanded(flex: 5,child: Text('CreatedBy:'),),
                            //     // SizedBox(width: 20,),
                            //    Expanded(flex: 5,child: Text( ssProCat.data[index].createdBy.trim()))

                            //   ],
                            // ),
                                //  SizedBox(width: 250,child:Text('Description:         ' + ssProCat.data[index].description)),                            
                                //  SizedBox(width: 250,child:Text('CreatedBy:           ' + ssProCat.data[index].createdBy)),
                               ],
                            )),
                      )
                      ),
                      
               ) );
              
              }
              );
        } else {
          return Center(child: CircularProgressIndicator(),);
        }
      });
}
}

