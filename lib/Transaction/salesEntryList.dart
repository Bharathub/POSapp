import 'package:flutter/material.dart';
import 'package:split/Bloc/Bloc.dart';
import 'package:split/Bloc/CommonVariables.dart';
import 'package:split/Bloc/provider.dart';
import 'package:split/Transaction/transaction.dart';
import 'package:split/Transaction/salesEntry.dart';
import 'package:split/src/APIprovider/salesEntryApiProvider.dart';
import 'package:split/src/Models/loginmodel.dart';
import 'package:intl/intl.dart';

class SalesEntryList extends StatefulWidget {

  final  Users loginInfo;
  SalesEntryList({Key key, @required this.loginInfo}) :super(key: key);

  @override
  _SalesEntryState createState() => _SalesEntryState();
}

class _SalesEntryState extends State<SalesEntryList>{
  
  @override
  Widget build(BuildContext context) {

    var bloc = Provider.of(context);
    return Scaffold(
            appBar: AppBar(
            backgroundColor: Color(0xffd35400),
            title: Text('Sales Entry'),
            leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context) => Transaction(loginInfo: widget.loginInfo,)));},
            ),
          ),
            body:  Container(height: 620, child: listTile(bloc),),

            floatingActionButton: FloatingActionButton(heroTag: 'btn1',
              backgroundColor:Color(0xffd35400),  child: Icon(Icons.add),  
              onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> SalesEntry(loginInfo: widget.loginInfo,orderNum:"")));
          },

      
       ),

    ); 
}

  Widget listTile(Bloc bloc) 
  {
    SalesEntryApi seApi = new SalesEntryApi();

    return FutureBuilder(
      future: seApi.salesEntryList(StaticsVar.branchID),
      builder: (context, sspo) 
      {
        if (sspo.hasData) 
          {
            return ListView.builder(
            itemCount: sspo.data.length,
            itemBuilder: (context, index) {
            return Container(height: 100.0,padding: EdgeInsets.only(top:10.0),
              child: Card( 
                margin: EdgeInsets.only(right: 8.0, left: 8.0),
                elevation: 10.0,
                child: ListTile(
                  title: Row(children: <Widget>[
                    Expanded(flex: 4,child: Text('S.E.No.:')),
                    Expanded(flex: 6,child: Text( sspo.data[index].orderNo),)
                  ],),
                  subtitle: Container(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: <Widget>[

                          Row(
                          children: <Widget>[
                            Expanded(flex: 4,child: Text('Customer Name:')),
                            Expanded(flex: 6,child: Text(sspo.data[index].customerName.toString()),),
                          ],),

                          Row(children: <Widget>[
                            Expanded(flex: 5,child: Text('Date:')),
                            Expanded(flex: 5,child: Text(DateFormat('dd/MM/yyyy').format(sspo.data[index].orderDate).toString()),),
                            Expanded(flex: 1, child: IconButton(
                            icon:  Icon(Icons.delete),
                            onPressed: () async
                          {
                            SalesEntryApi seApi = new SalesEntryApi();
                              await (seApi.delSeList(sspo.data[index].branchId,sspo.data[index].orderNo,widget.loginInfo.userID)).then((onValue)
                                {
                                  if(onValue == true){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> SalesEntryList(loginInfo: widget.loginInfo,)));
                                  }else {return  Exception('Loading Failed');}
                                }
                              );
                            },
                          )
                        ),
                      ],
                    ),
                  // Row(children: <Widget>[
                      // Container(padding: EdgeInsets.only(left: 325.0),child:IconButton(
                      //       icon:  Icon(Icons.delete),
                      //       onPressed: () async
                      //     {
                      //       SalesEntryApi seApi = new SalesEntryApi();
                      //         await (seApi.delSeList(sspo.data[index].branchId,sspo.data[index].orderNo,widget.loginInfo.userID)).then((onValue)
                      //           {
                      //             if(onValue == true){
                      //             Navigator.push(context, MaterialPageRoute(builder: (context)=> SalesEntryList(loginInfo: widget.loginInfo,)));
                      //             }else {return  Exception('Loading Failed');}
                      //           }
                      //         );
                      //       },
                      //         )  )
                    
                  // ],)
                    

                  ],
                )
                    ),),
                    trailing: Column(
                      children: <Widget>[
                        Text(sspo.data[index].status ? "ACTIVE" : 'DELETED',style: TextStyle(color: Colors.red),),

                        // SizedBox.shrink(child:IconButton(
                        //   icon:  Icon(Icons.delete),
                        //   onPressed: () async
                        //   {
                        //     SalesEntryApi seApi = new SalesEntryApi();
                        //       await (seApi.delSeList(sspo.data[index].branchId,sspo.data[index].orderNo,widget.loginInfo.userID)).then((onValue)
                        //         {
                        //           if(onValue == true){
                        //           Navigator.push(context, MaterialPageRoute(builder: (context)=> SalesEntryList(loginInfo: widget.loginInfo,)));
                        //           }else {return  Exception('Loading Failed');}
                        //         }
                        //       );
                        //     },
                        // )),
                      ],
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>
                          SalesEntry(loginInfo: widget.loginInfo, orderNum: sspo.data[index].orderNo)));
                    },
               ),));}
            );
          } else { return Center(child: CircularProgressIndicator(),);}
      });
  }

}            