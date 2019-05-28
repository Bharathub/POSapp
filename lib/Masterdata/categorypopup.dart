import 'package:flutter/material.dart';
import 'package:split/Bloc/Bloc.dart';
import 'package:split/Bloc/provider.dart';
import 'package:split/Masterdata/category.dart';
import 'package:split/src/APIprovider/productCategoryApiprovider.dart';
import 'package:split/src/Models/loginmodel.dart';
import 'package:split/src/Models/productcategorymodel.dart';
// import 'package:split/src/Models/productcategorymodel.dart';
// import 'package:split/Bloc/provider.dart';

class Categorypopup extends StatefulWidget {

  final  Users loginInfo;
  final String catCode;
  final String catDesc;
  Categorypopup({Key key, @required this.loginInfo,this.catCode,this.catDesc}) :super(key: key);

  @override
  _CategorypopupState createState() => _CategorypopupState();
}

class _CategorypopupState extends State<Categorypopup>
{
  bool isInEditMode = false;
  ProductCateProvider proCatApi = new ProductCateProvider();
  ProductCategorys proCatDts = new ProductCategorys();

  // bool _sel = false;
  @override
  Widget build(BuildContext context) 
  {
    var bloc = Provider.of(context);
    isInEditMode = (widget.catCode != "");

    if(isInEditMode) {
       bloc.setProdCatDtls(widget.catCode, widget.catDesc); }
    

    return MaterialApp(
      home: Scaffold(
       
           appBar: AppBar(
           backgroundColor: Color(0xffd35400),
            title: Text('Product Category'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
             color: Colors.white,
              onPressed: () {
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => CategoryPage(loginInfo: widget.loginInfo,)));
              },
            ),
          ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 220.0, left: 10.0, right: 10.0),
            child: Card(
              //  margin: EdgeInsets.only(left: 10.0,right: 10.0),

              elevation: 10,

              child: Column(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: <Widget>[
                 SizedBox(width: 300,child: proCatCodeTxtFld(bloc, !isInEditMode),),
                 SizedBox(width: 300,child:proCatDescTxtFld(bloc),),
                  // codeTxtf(bloc),
                  // descTxtF(bloc),
              
                  // Row(
                  //   mainAxisSize: MainAxisSize.min,
                  //   children: <Widget>[
                  //     new Text('Internal Stock'),
                  //     new Checkbox(
                  //       activeColor: Colors.blue,
                  //       onChanged: (bool resp) {
                  //         setState(() {
                  //           _sel = resp;
                  //         });
                  //       },
                  //       value: _sel,
                  //     )
                  //   ],
                  // ),

                  savcanFlatbtn(context ,bloc, widget.loginInfo),
                  
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

  Widget proCatCodeTxtFld(Bloc bloc,bool isEditable)
  {
    TextEditingController _controller = new TextEditingController();
    return StreamBuilder(
      stream: bloc.prodCatCode,
      builder: (context, snapshot) 
      { 
          _controller.value = _controller.value.copyWith(text: snapshot.data);
          print(snapshot.data.toString());
          return TextField(
            textCapitalization: TextCapitalization.characters,
            // style: txtRoboStyle(20),
            onChanged: bloc.prodCatCodeChanged,
            controller: _controller,
            //keyboardType: TextInputType.emailAddress
            decoration: InputDecoration(
               enabled: isEditable,
            // labelStyle: txtRoboStyle(20),
            // hintText: 'UOM Code',
            labelText: 'Code',
            //errorText: snapshot.error,
            ),
          );
      }
      );
  }

  Widget proCatDescTxtFld(Bloc bloc)
  {
    TextEditingController _controller = new TextEditingController();
    return StreamBuilder(
      stream: bloc.prodDescription,
      builder: (context, snapshot) 
      { 
          _controller.value = _controller.value.copyWith(text: snapshot.data);
          print(snapshot.data.toString());
          return TextField(
            textCapitalization: TextCapitalization.characters,
            // style: txtRoboStyle(20),
            onChanged: bloc.prodDescChanged,
            controller: _controller,
            //keyboardType: TextInputType.emailAddress
            decoration: InputDecoration(
            // labelStyle: txtRoboStyle(20),
            // hintText: 'UOM Code',
            labelText: 'Description',
            //errorText: snapshot.error,
            ),
          );
      }
      );
  }


Widget savcanFlatbtn(BuildContext context, Bloc bloc, Users logininfo)
{     ProductCateProvider proCatApi = new ProductCateProvider();
      return Container(
            child:  Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
            FlatButton(child: Text('CANCEL',style: TextStyle(color: Colors.blue),),
            onPressed: () {Navigator.pop(context);},),
            FlatButton( child: Text( 'SAVE', style: TextStyle(color: Colors.blue),),
            onPressed: ()
            async{        
            ProductCategorys proCatDts = new ProductCategorys();
            proCatDts = bloc.saveProdCatDtls();
            await proCatApi.saveProductList(proCatDts).then((onValue){
                  if(onValue == true){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> CategoryPage(loginInfo: logininfo ,)));
                    }else {return  Exception('Failed to Save UOM');}}
                    );
            }, ),
            ],
          ),
        );
   
}









