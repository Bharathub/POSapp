import 'package:flutter/material.dart';
import 'package:split/Bloc/Bloc.dart';
import 'package:split/Bloc/provider.dart';
import 'package:split/Masterdata/masterdatatab.dart';
import 'package:split/Masterdata/promotionPopup.dart';
import 'package:split/src/APIprovider/promotionApiProvider.dart';
import 'package:split/src/Models/loginmodel.dart';
import 'package:split/Bloc/CommonVariables.dart';
import 'package:intl/intl.dart';

// import 'package:split/Bloc/providers.dart';

// void main() => runApp(new UomList()); //one-line function

class PromotionList extends StatefulWidget
{
  final  Users loginInfo;
  PromotionList({Key key, @required this.loginInfo}) :super(key: key);
  @override
  _ListCardsState createState() => _ListCardsState();
}

class _ListCardsState extends State<PromotionList> 
{
  @override
  Widget build(BuildContext context) 
  {
    var bloc = Provider.of(context);
    
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Color(0xffd35400),
      title: Text('Promotions'),
      leading: IconButton(
      icon: Icon(Icons.arrow_back),
      color: Colors.white,
      onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context) => MasterDataTab(loginInfo: widget.loginInfo,)));},
      ),
    ),
    body: Container(child: listTile(bloc),),
    floatingActionButton: FloatingActionButton(
      heroTag: 'btn7',
      backgroundColor:Color(0xffd35400),  child: Icon(Icons.add),  onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Prmotionpopup(loginInfo: widget.loginInfo, promoID: "",)));
            },    
          ),
        ); 
  } 

  Widget listTile(Bloc bloc)
  {
    PromotionApiProvider uomApi = new PromotionApiProvider();
    return FutureBuilder(
      future: uomApi.promotionList(StaticsVar.branchID),
      builder: (context, ssPromo)
      {
      if (ssPromo.hasData) {
      return ListView.builder(
      itemCount: ssPromo.data.length,
      itemBuilder: (context, index) 
      {
      return Container(height: 120.0,padding: EdgeInsets.only(top:15.0),
      child: Card( 
      margin: EdgeInsets.only(right: 5.0, left: 5.0),
      elevation: 10.0,
      child: ListTile(
      title:Row(children: <Widget>[
        Expanded(flex: 5,child: Text('PromotionID : '),),
        Expanded(flex: 5,child: Text( ssPromo.data[index].promotionID),)
        ],),        
        
          onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => 
                    Prmotionpopup(loginInfo:widget.loginInfo, promoID: ssPromo.data[index].promotionID)));},
          trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: ()async
           {
                  PromotionApiProvider promoApi = new PromotionApiProvider();
                    await (promoApi.delPromotion(ssPromo.data[index].branchID.toString(),ssPromo.data[index].promotionID)).then((onValue)
                  {
                    if(onValue == true){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> PromotionList(loginInfo: widget.loginInfo,)));
                    } else {return  Exception('Loading Failed');}
                  }
                );
              },
            ),
            subtitle: Container(
            child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              children: <Widget>[
                Row(
                children: <Widget>[
                  Expanded(flex: 5,child: Text('Effective Date:')),
                  // SizedBox(width: 10.0,),
                  Expanded(flex: 5,child: Text(DateFormat('dd/MM/yyyy').format(ssPromo.data[index].effectiveDate).toString()),),
                  ],),
                  
                  Row(children: <Widget>[
                    Expanded(flex: 5,child: Text('Expiry Date:')),
              //    SizedBox(width: 10.0,),
                    Expanded(flex: 5,child: Text(DateFormat('dd/MM/yyyy').format(ssPromo.data[index].expiryDate).toString()),),
                              ],
                            ), 
                          ]
                        )
                      ),
                    )
                  ),
                )
              );
            }
          );
        } else {return Center(child: CircularProgressIndicator(),);}
      }
    );
  }

}