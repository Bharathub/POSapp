import 'package:flutter/material.dart';
import 'package:split/Bloc/Bloc.dart';
import 'package:split/Bloc/provider.dart';
import 'package:split/Masterdata/masterdatatab.dart';
import 'package:split/Masterdata/paymentpopup.dart';
import 'package:split/src/APIprovider/lookUpApiProvider.dart';
import 'package:split/src/APIprovider/paymentApiProvider.dart';
import 'package:split/src/Models/loginmodel.dart';
// import 'package:split/Bloc/providers.dart';

// void main() => runApp(new PaymentType()); //one-line function

class PaymentType extends StatefulWidget 
{

  final Users loginInfo;
  PaymentType({Key key, @required this.loginInfo}) :super(key: key);
   @override
  _ListCardsState createState() => _ListCardsState();

}

class _ListCardsState extends State<PaymentType> {
  @override
  Widget build(BuildContext context) 
  {
    var bloc = Provider.of(context);
    //bloc.clearLookUps();

    return Scaffold(
       appBar: AppBar(
         backgroundColor: Color(0xffd35400),
          title: Text('Payment Type'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context) => MasterDataTab(loginInfo: widget.loginInfo,)));},
            ),
          ),
          body: Container(child: listTile(bloc),),
          floatingActionButton: FloatingActionButton(
            heroTag: 'btn3',
            backgroundColor:Color(0xffd35400),
            child: Icon(Icons.add),
            onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> PaymentPopup(loginInfo: widget.loginInfo,payCode: "",payDes: "",)));
            },
          ),
        );
      }

  Widget listTile(Bloc bloc)
  {
    PaymentApiProvider paymentApi = new PaymentApiProvider();
    return FutureBuilder(
      future: paymentApi.paymentList(),
      builder: (context, sspayment) {
        if (sspayment.hasData) {
          return ListView.builder(
              itemCount: sspayment.data.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 80.0,padding: EdgeInsets.only(top:15.0),
                  child:Card(
                  margin: EdgeInsets.only(right: 5.0, left: 5.0),
                  elevation: 10.0,
                  child: ListTile(
                      title:Row(children: <Widget>[
                      Expanded(flex: 4,child:Text('Code:'),),
                      Expanded(flex: 6,child: Text(sspayment.data[index].lookupCode),)
                      ],),
                      onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            PaymentPopup(loginInfo: widget.loginInfo,payCode: sspayment.data[index].lookupCode.trim(),
                            payDes:sspayment.data[index].description)));
                          },
                          trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: ()async{
                          LookUpApiProvider lukup = new LookUpApiProvider();
                          await (lukup.delLookup(sspayment.data[index].lookupCode)).then((onValue)
                          {
                            if(onValue == true){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> PaymentType(loginInfo: widget.loginInfo,)));
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
                               Expanded(flex: 6,child: Text( sspayment.data[index].description.trim()))

                              ],
                            ),
                            Row(
                              children: <Widget>[
                               Expanded(flex: 4,child: Text('Category:'),),
                                // SizedBox(width: 20,),
                               Expanded(flex: 6,child: Text( sspayment.data[index].category.trim()))

                              ],
                            ),


                            ],
                            )),
                      )),
               ) );
              
              }
              );
        } else {
          return Center(child: CircularProgressIndicator(),);}
      });
}
}


// import 'package:flutter/material.dart';
// import 'package:split/Masterdata/paymentpopup.dart';
// import 'package:split/appdrawer.dart';


// void main() => runApp(new PaymentType()); //one-line function

// class PaymentType extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       title: "",
//       home: new Scaffold(
//              appBar: AppBar(
//            backgroundColor: Color(0xffd35400),
//             title: Text('Payment Type'),
//             leading: IconButton(
//               icon: Icon(Icons.arrow_back),
//              color: Colors.white,

//               onPressed: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => AppDrawer()));
//               },
//             ),
//           ),
//         body: SingleChildScrollView(
//           child: Container(
//             color: Color(0xffecf0f1),
       
//             child: new Column(
//               children: <Widget>[
//                 SizedBox(
//                   height: 10.0,
//                 ),
//                 listTile(Text('CASH\tCREDIT\tTRF'), Text('Code')),
//                 SizedBox(
//                   height: 15.0,
//                 ),
//                 listTile(Text('CASH\tCREDIT\tTransfer'), Text('Description')),
//                   SizedBox(
//                   height: 15.0,
//                 ),
      
//               ],
//             ),

//           ),
//         ),
//           floatingActionButton: FloatingActionButton(heroTag: 'btn3',
//             backgroundColor:Color(0xffd35400),  child: Icon(Icons.add),  onPressed: (){
//           Navigator.push(context, MaterialPageRoute(builder: (context)=> PaymentPopup()));


//         },  ),

//       ),
//     );
//   }
// }

// Widget listTile(subtitle, title) {
//   return SizedBox(
//       height: 90,
//       child: Card(
//         margin: EdgeInsets.only(right: 10.0, left: 10.0),
//         elevation: 10.0,
//         child: ListTile(
//           title: title,
//           trailing: IconButton(
//             icon: Icon(Icons.delete),
//             onPressed: () {},
//           ),
//           subtitle: subtitle,
//         ),
//       ));
// }



            
