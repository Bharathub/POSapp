import 'package:flutter/material.dart';
import 'package:split/Bloc/Bloc.dart';
import 'package:split/Bloc/CommonVariables.dart';
import 'package:split/Bloc/provider.dart';
import 'package:split/Masterdata/masterdatatab.dart';
import 'package:split/Masterdata/suppPopup.dart';
import 'package:split/src/APIprovider/customerApiProvider.dart';
import 'package:split/src/APIprovider/supplierApiProvider.dart';
import 'package:split/src/Models/loginmodel.dart';
// import 'package:split/Bloc/providers.dart';

// void main() => runApp(new SupplierCards()); //one-line function

class SupplierCards extends StatefulWidget {

  final Users loginInfo;
  SupplierCards({Key key, @required this.loginInfo}) :super(key: key);

  @override
  _ListCardsState createState() => _ListCardsState();
}

class _ListCardsState extends State<SupplierCards>
 {
    @override
    Widget build(BuildContext context) {
      var bloc = Provider.of(context);
      
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffd35400),
          title: Text('Supplier List'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context) => MasterDataTab(loginInfo: widget.loginInfo,)));},
            ),
        ),
        body: Container(child: listTile(bloc,widget.loginInfo),
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: 'btn2',
          backgroundColor: Color(0xffd35400),
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SupplierPopup(loginInfo: widget.loginInfo,supCode: "")));
          },
        ),
    );
  }
}

Widget listTile(Bloc bloc,Users loginInfo) 
{
  SupplierApiProvider supplrApi = new SupplierApiProvider();

  return FutureBuilder(
            future: supplrApi.supplierList(),
            builder: (context, ssSuppliers) {
              if (ssSuppliers.hasData) {
                return ListView.builder(
              itemCount: ssSuppliers.data.length,
              itemBuilder: (context, index) {
                return Container(height: 80.0,padding: EdgeInsets.only(top:15.0),
                child:  Card(
                  margin: EdgeInsets.only(right: 5.0, left: 5.0),
                  elevation: 10.0,
                  child: ListTile(
                      title:Row(
                        children: <Widget>[
                          Expanded(flex: 5,child:Text('Supplier Code:'),),
                          Expanded(flex: 5,child: Text(ssSuppliers.data[index].customerCode.trim()),)
                          ],
                          ),
                       onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context) =>
                         SupplierPopup(loginInfo: loginInfo,supCode:ssSuppliers.data[index].customerCode.trim(),
                        //  supName:ssSuppliers.data[index].customerName.trim(),
                        //   regNo: ssSuppliers.data[index].registrationNo,
                          )));
                          },
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: ()  async {
                          CustomerApiProvider cusApi = new CustomerApiProvider();
                          await (cusApi.delCustList(ssSuppliers.data[index].customerCode.trim())).then((onValue)
                          { if(onValue == true)
                            {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> SupplierCards(loginInfo: loginInfo,)));
                            } else {return  Exception('Loading Failed');}},
                          onError: (e) {StaticsVar.showAlert(context, e.toString());})
                          .catchError((onError) {StaticsVar.showAlert(context, onError.toString());});   
                        },
                      ),
                      subtitle: Container(
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              children: <Widget>[
                                   Row(
                                  children: <Widget>[
                                 Expanded(flex: 5,child:Text('Customer Name:'),),
                                    // SizedBox(width: 20,),
                                 Expanded(flex: 5,child: Text(ssSuppliers.data[index].customerName.trim()))
                                  ],
                                ),
                                //      Row(
                                //   children: <Widget>[
                                // //  Expanded(flex: 5,child:Text('regNo.'),),
                                //     // SizedBox(width: 20,),
                                //     //  Expanded(flex: 5,child: Text(ssSuppliers.data[index].registrationNo.trim()))
                                //   ],
                                // ),


                                // Text('Reg.No:' +
                                //     ssSuppliers.data[index].registrationNo),
                                // Text('Customer Type:      ' +
                                //     ssSuppliers.data[index].customerType),
                              ],
                            )),
                      )),
               ) );
              
              }
              );
        } else {
          return Center(child: CircularProgressIndicator(),);
        }
      });
}
