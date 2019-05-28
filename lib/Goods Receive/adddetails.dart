import 'package:flutter/material.dart';
import 'package:split/Bloc/Bloc.dart';


void main() => runApp(new AddDetails()); //one-line function

class AddDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "",
      home: new Scaffold(
        body: SingleChildScrollView(
          child: Container(
            color: Color(0xffecf0f1),
            
            child: new Column(
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                listTile(Text('Concerto 6"x72"x78'), Text('Product Code')),
                SizedBox(
                  height: 15.0,
                ),
                listTile(Text('1'), Text('Quentity')),
                SizedBox(
                  height: 15.0,
                ),
                listTile(Text('0'), Text('Received Qty')),
                SizedBox(
                  height: 15.0,
                ),
                listTile(Text('0'), Text('Pending Qty')),
                SizedBox(
                  height: 15.0,
                ),
                listTile(Text('UNIT'), Text('UOM')),
                SizedBox(
                  height: 15.0,
                ),

                Divider(
                  color: Colors.red,
                  height: 25.0,
                ),


              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[ 
                   RaisedButton(    color:  Color(0xffd35400),
                          elevation: 5.0,
                  child: Text('SAVE',style:TextStyle(color:Colors.white)), onPressed: (){
                   //  Navigator.push(context, MaterialPageRoute(builder: (context)=>Purchasepopup()));
                    

                  },),

                  SizedBox(width: 15.0,),


                     RaisedButton(    color:  Color(0xffd35400),
                          elevation: 5.0,
                  child: Text('DELETE',style:TextStyle(color:Colors.white)), onPressed: (){
                    

                  },),
                  
                  ],)

          
              ],
            ),
        
          ),
        ),
        

      ),
    );
  }
}

Widget listTile(subtitle, title) {
  return SizedBox(
      height: 90,
      child: Card(
        margin: EdgeInsets.only(right: 10.0, left: 10.0),
        elevation: 10.0,
        child: ListTile(
          title: title,
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {},
          ),
          subtitle: subtitle,
        ),
      ));
}




// Widget listTiles(Bloc bloc, )
// {
//   //ProductApiProvider pProductDtApi = new ProductApiProvider();
//   return StreamBuilder(
//     stream: bloc.poDetails,
//     builder: (context, ssPOproDt) {
//     List poData = ssPOproDt.hasData ? ssPOproDt.data : <PurchaseOrderDetails>[];
//     //if (poData.) {
//       return ListView.builder(
//           itemCount: poData.length,
//           itemBuilder: (context, index) 
//           { return Container(height: 150.0,padding: EdgeInsets.only(top:15.0),
//               child: Card(
//                 margin: EdgeInsets.only(right: 5.0, left: 5.0),
//                 elevation: 10.0,
//                 child: ListTile(
//                   title: Text('Code:   ' + poData[index].productCode),
//                   trailing: IconButton( icon: Icon(Icons.delete), onPressed: () { bloc.deletePODetail(poData[index].productCode); StaticsVar.showAlert(context, "Product Deleted"); }),
//                   subtitle: Container(
//                     child: Align(
//                     alignment: Alignment.centerLeft,
//                       child: Column(
//                       children: <Widget>[
//                         //Text('Description:' + poData[index].description),
//                         Text('Qty:    ' + poData[index].quantity.toString()),
//                         Text('Unit Price:    ' + poData[index].unitPrice.toString()),
//                         Text('UOM:    ' + poData[index].uom),

//                       ],
//                     )),
//                   )),
//               )); 
//         });
//     //} else { return Center(child:CircularProgressIndicator());}
//   });
// }





            
saveDeltBtn(Bloc bloc)
{
  return   Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[ 
                   RaisedButton(    color:  Color(0xffd35400),
                          elevation: 5.0,
                  child: Text('SAVE',style:TextStyle(color:Colors.white)), onPressed: (){
                   //  Navigator.push(context, MaterialPageRoute(builder: (context)=>Purchasepopup()));
                    

                  },),

                  SizedBox(width: 15.0,),


                     RaisedButton(    color:  Color(0xffd35400),
                          elevation: 5.0,
                  child: Text('DELETE',style:TextStyle(color:Colors.white)), onPressed: (){
                   //  Navigator.push(context, MaterialPageRoute(builder: (context)=>Purchasepopup()));
                    

                  },),
                  
                  ],);
}