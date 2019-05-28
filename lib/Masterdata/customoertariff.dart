import 'package:flutter/material.dart';
import 'package:split/Bloc/Bloc.dart';
import 'package:split/Bloc/provider.dart';
import 'package:split/Masterdata/custoListpopup.dart';
import 'package:split/Masterdata/masterdatatab.dart';
import 'package:split/src/APIprovider/customerApiProvider.dart';
import 'package:split/src/Models/loginmodel.dart';
// import 'package:split/Bloc/providers.dart';

// void main() => runApp(new CustomerList()); //one-line function

class CustomerList extends StatefulWidget {

  final Users loginInfo;
  CustomerList({Key key, @required this.loginInfo}) :super(key: key);

  @override
  _ListCardsState createState() => _ListCardsState();
}

class _ListCardsState extends State<CustomerList> {

 @override
  Widget build(BuildContext context) {
    //final bloc = Bloc();

    var bloc = Provider.of(context);
    return Scaffold(
            appBar: AppBar(
           backgroundColor: Color(0xffd35400),
            title: Text('Customer List'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
             color: Colors.white,

              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MasterDataTab(loginInfo: widget.loginInfo,)));
              },
            ),
          ),
      body: Container(child: listTile(bloc,widget.loginInfo),),

          floatingActionButton: FloatingActionButton(heroTag: 'btn1',
          backgroundColor:Color(0xffd35400),  child: Icon(Icons.add),  onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> CustomerListPopup(loginInfo: widget.loginInfo,cusCode: "" ,cusName: "",regNo: "",)));
          }
            ),
     ); } 
}





Widget listTile(Bloc bloc,Users loginInfo) 
{
  
  CustomerApiProvider cusApi = new CustomerApiProvider();
   return FutureBuilder(
        future: cusApi.customerList(),
        builder: (context, ssCustomer) {
        if (ssCustomer.hasData) {
        return ListView.builder(
        itemCount: ssCustomer.data.length,
        itemBuilder: (context, index) {
        return Container(height: 80.0,padding: EdgeInsets.only(top:15.0),
        child:Card(
          margin: EdgeInsets.only(right: 5.0, left: 5.0),
          elevation: 10.0,
          child: ListTile(
          title:Row(
            children: <Widget>[
              Expanded(flex: 5, child: Text('Customer Code:'),),
              Expanded(flex: 5,child: Text( ssCustomer.data[index].customerCode.trim()),)
            ],
          ),
          onTap:(){
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                  CustomerListPopup(loginInfo: loginInfo,cusCode:ssCustomer.data[index].customerCode.trim(),
                  cusName: ssCustomer.data[index].customerName,
                  regNo: ssCustomer.data[index].registrationNo)));
                },
              trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
              CustomerApiProvider cusApi = new CustomerApiProvider();
              await (cusApi.delCustList(ssCustomer.data[index].customerCode)).then((onValue)
                  {
                    if(onValue == true){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> CustomerList(loginInfo: loginInfo,)));
                    }else {return  Exception('Loading Failed');}
                  }
                );
            },
          ),
            // leading: CircleAvatar(),
            subtitle: Container(
            child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(flex: 5,child:Text('Customer Name:'),),
                  Expanded(flex: 5,child: Text(ssCustomer.data[index].customerName.trim()))
                    ],
                  ),
                  ],
                )
              ),
            ) ),
      ) );
      }  );
  } else {return Center(child:CircularProgressIndicator());}
  });

}


