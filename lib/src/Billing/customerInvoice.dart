import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:split/Bloc/Bloc.dart';
import 'package:split/Bloc/CommonVariables.dart';
import 'package:split/Bloc/provider.dart';
import 'package:split/src/APIprovider/reportsApiProvider.dart';
import 'package:split/src/Billing/invoice.dart';
import 'package:split/src/Models/invoiceModel.dart';
import 'package:split/src/Models/loginmodel.dart';
import 'package:split/src/Models/reportModel.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerInv extends StatefulWidget
{
  final Users loginInfo;
  final String invNo;
  CustomerInv({Key key, @required this.loginInfo,this.invNo,}) :super(key: key);
  @override
  _CustomerInvState createState() => _CustomerInvState();
}

class _CustomerInvState extends State<CustomerInv> 
{
  bool isInEditMode = false;
  int intCount = 0;
  String invoiceNo;

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of(context);
    isInEditMode = (widget.invNo != ""); // true : means Edit mode // false: means New Quotation

    //if(isInEditMode) 
      //{ 
        intCount = intCount+1; //print('SUPPLIER No Of Times Executed: ' + intCount.toString()); 
        if(intCount==1) {bloc.initiateCustomers(true); bloc.fetchCusInvDtls(widget.invNo);}
      //}

    //  bloc.setSupplierDtls(widget.supCode);
    //  isEditable = (widget.supCode == "");
    
    return MaterialApp(
      theme: ThemeData(buttonColor: Color(0xffd35400),),
      home: Scaffold(
            appBar: AppBar(
              title:Text('Customer Invoice'),
              actions: <Widget>[
                GestureDetector( child: Container(width: 25.0, height: 10.0, padding: EdgeInsets.only(top:20.0),
                decoration: new BoxDecoration(
                    image: new DecorationImage( image: new AssetImage('lib/images/pdf.png'),fit: BoxFit.fitWidth,),),),
                onTap: () async {
                  ReportsAPI invRepAPI = new ReportsAPI();
                  ReportOptions rptOpts = new ReportOptions(documentNo: widget.invNo, 
                                                branchID: StaticsVar.branchID, reportName: "Invoice", 
                                                dateFrom: DateTime.now(), dateTo: DateTime.now());
                  await (invRepAPI.invoiceReport(rptOpts).then((onValue) async
                    {
                      if(onValue != ""){
                         await launch(onValue, forceWebView: false);
                      //StaticsVar.downloadPDF(onValue); //, invoices[index].invoiceNo.trim() + ".pdf");
                      } else {return  Exception('Report Loading Failed');}
                    }
                  ));
                }),
                SizedBox(width: 30.0,),
              ],
              
            //   SizedBox(width: 25.0,),
              
            backgroundColor: Color(0xffd35400),
            leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context) => Invoice(loginInfo: widget.loginInfo,))); },),
        ),
        body: SingleChildScrollView(
          child: Center(
          // margin: EdgeInsets.only(left: 5.0, right: 5.0),
          child: Card(
            margin: EdgeInsets.only(left: 10.0,right: 10.0),
          elevation: 10,
          child: Container(
            padding: EdgeInsets.all(10.0),
            height: 900.0,width: 350,
            child: Column(
            children: <Widget>[
              cusName(bloc),
             FittedBox(child: cusAdress(bloc)),
              cusInvDate(bloc),
              cusInvoiceNo(bloc),
              cusOrderNo(bloc),             
              Divider(),
              Text('Invoice Detail',style: TextStyle(fontSize: 20.0,)),
              Divider(),
              Container(height: 250.0,child: listTile(bloc),),              
              Divider(),
              Text('Total Summary',style: TextStyle(fontSize: 20.0,)),
              cusInvoiceAmt(bloc),
              Wrap(spacing: 20.0,
              children: <Widget>[
              cusDiscountAmt(bloc),
              cusVAT(bloc),
              ],),
              Wrap(spacing: 20.0,
              children: <Widget>[
              cusWHTax(bloc),
              cusTotalAmt(bloc)
              ],),
              Wrap(spacing: 20.0,
              children: <Widget>[
              cusPaidAmt(bloc),
              cusBalanceAmt(bloc),
              ],)
            //  dispProductDetails(context,bloc)
            
            ],
          ),
          )
            ),
          ),
        ),
        // bottomNavigationBar: summaryBtn(context, bloc)
      ),
    );
  }

  
  summaryBtn(BuildContext context, Bloc bloc)
  {
    return RaisedButton(        
        child: Text('SUMMARY',style: TextStyle(color: Colors.white),),
        onPressed:(){ _showDialog(context, bloc); },
      );
  }

  void _showDialog(BuildContext context, Bloc bloc) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(children: <Widget>[ 
          showPopUpList(context, bloc),  
        ],);
      },
    );
  }

  Widget showPopUpList(BuildContext contxt, Bloc bloc) {
    return Container( width: 250, height: 500, 
        // decoration: BoxDecoration(border: Border.all(color: Colors.blueGrey), 
        //               shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(5.0)),
        padding: EdgeInsets.all(10.0),
        //elevation: 24,
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
           dispProductDetails(contxt, bloc),
          ],
      )
    );
  }

  dispProductDetails(BuildContext context, Bloc bloc,)
  {
    return  SingleChildScrollView(
      child: Container(margin: EdgeInsets.all(5.0),
              child: Center(
                child: Column(
                children: <Widget>[
                  cusInvoiceAmt(bloc),
                  cusDiscountAmt(bloc),
                  cusVAT(bloc),
                  cusWHTax(bloc),
                  cusTotalAmt(bloc),
                  cusPaidAmt(bloc),
                  cusBalanceAmt(bloc),  
              //  cancelFlatbtn(context,bloc)
                ],
              ),
             ),
              ),
          );

  }

  Widget cancelFlatbtn(BuildContext context, Bloc bloc)
  {
    return Container( 
      child: RaisedButton(color: Color(0xffd35400), child: Text('CANCEL',style: TextStyle(color: Colors.white),),
      onPressed: () {Navigator.of(context).pop();},),                 
      
    );
  }

 
  Widget cusInvoiceAmt(Bloc bloc)
    {
      TextEditingController _controller = new TextEditingController();
      return StreamBuilder(
        stream: bloc.cusInvAmt,
        builder: (context, snapshot) 
          { 
            if(snapshot.hasData)
                  {_controller.value = _controller.value.copyWith(text: snapshot.data);}
            return SizedBox(width: 300.0,child:
            TextField(
              textCapitalization: TextCapitalization.characters,
              onChanged: bloc.cusInvAmtChanged,
              controller: _controller,
              decoration: InputDecoration(
              labelText: 'Invoice Amount'
              ),
              enabled: false,
             ) );
          }
        );          
    }

     Widget cusDiscountAmt(Bloc bloc)
    {
      TextEditingController _controller = new TextEditingController();
      return StreamBuilder(
        stream: bloc.cusDisAmt,
        builder: (context, snapshot) 
          { 
            if(snapshot.hasData)
                  {_controller.value = _controller.value.copyWith(text: snapshot.data);}
            return SizedBox(width: 150.0,child:
            TextField(
              textCapitalization: TextCapitalization.characters,
              onChanged: bloc.cusDisAmtChanged,
              controller: _controller,
              decoration: InputDecoration(
              labelText: 'Discount Amt/Discount'
              ),
              enabled: false,
             ) );
          }
        );
      
    }
    Widget cusVAT(Bloc bloc)
    {
      TextEditingController _controller = new TextEditingController();
      return StreamBuilder(
        stream: bloc.cusVAT,
        builder: (context, snapshot) 
          { 
            if(snapshot.hasData)
                  {_controller.value = _controller.value.copyWith(text: snapshot.data);}
            return SizedBox(width: 150.0,child:
            TextField(
              textCapitalization: TextCapitalization.characters,
              onChanged: bloc.cusVATChanged,
              controller: _controller,
              decoration: InputDecoration(
              labelText: '7% VAT'
              ),
              enabled: false,
             ) );
          }
        );
      
    } 
    
    Widget cusWHTax(Bloc bloc)
    {
      TextEditingController _controller = new TextEditingController();
      return StreamBuilder(
        stream: bloc.cusWHT,
        builder: (context, snapshot) 
          { 
            if(snapshot.hasData)
                  {_controller.value = _controller.value.copyWith(text: snapshot.data);}
            return SizedBox(width: 150.0,child:
            TextField(
              textCapitalization: TextCapitalization.characters,
              onChanged: bloc.cusWHTChanged,
              controller: _controller,
              decoration: InputDecoration(
              labelText: 'W/H Tax'
              ),
              enabled: false,
             ) );
          }
        );
      
    } 

    Widget cusTotalAmt(Bloc bloc)
    {
      TextEditingController _controller = new TextEditingController();
      return StreamBuilder(
        stream: bloc.cusTotAmt,
        builder: (context, snapshot) 
          { 
            if(snapshot.hasData)
                  {_controller.value = _controller.value.copyWith(text: snapshot.data);}
            return SizedBox(width: 150.0,child:
            TextField(
              textCapitalization: TextCapitalization.characters,
              onChanged: bloc.cusTotAmtChanged,
              controller: _controller,
              decoration: InputDecoration(
              labelText: 'Total Amount'
              ),
              enabled: false,
             ) );
          }
        );
      
    } Widget cusPaidAmt(Bloc bloc)
    {
      TextEditingController _controller = new TextEditingController();
      return StreamBuilder(
        stream: bloc.cusPaidAmt,
        builder: (context, snapshot) 
          { 
            if(snapshot.hasData)
                  {_controller.value = _controller.value.copyWith(text: snapshot.data);}
            return SizedBox(width: 150.0,child:
            TextField(
              textCapitalization: TextCapitalization.characters,
              onChanged: bloc.cusPaidAmtChanged,
              controller: _controller,
              decoration: InputDecoration(
              labelText: 'Paid Amount'
              ),
              enabled: false,
             ) );
          }
        );
      
    } Widget cusBalanceAmt(Bloc bloc)
    {
      TextEditingController _controller = new TextEditingController();
      return StreamBuilder(
        stream: bloc.cusBalAmt,
        builder: (context, snapshot) 
          { 
            if(snapshot.hasData)
                  {_controller.value = _controller.value.copyWith(text: snapshot.data);}
            return SizedBox(width: 150.0,child:
            TextField(
              textCapitalization: TextCapitalization.characters,
              onChanged: bloc.cusBalAmtChanged,
              controller: _controller,
              decoration: InputDecoration(
              labelText: 'Balance Amt'
              ),
              enabled: false,
             ) );
          }
        );
      
    }
  

  Widget cusName(Bloc bloc)
    {
      TextEditingController _controller = new TextEditingController();
      return StreamBuilder(
        stream: bloc.cusName,
        builder: (context, snapshot) 
          { 
            if(snapshot.hasData)
                  {_controller.value = _controller.value.copyWith(text: snapshot.data);}
            return SizedBox(width: 300.0,child:
            TextField(
              textCapitalization: TextCapitalization.characters,
              onChanged: bloc.cusNameNoChanged,
              controller: _controller,
              decoration: InputDecoration(
              labelText: 'Customer Name'
              ),
              enabled: false,
             ) );
          }
        );
      
    }


  Widget cusAdress(Bloc bloc)
    {
      TextEditingController _controller = new TextEditingController();
      return StreamBuilder(
        stream: bloc.cusAddress,
        builder: (context, snapshot) 
          { 
            if(snapshot.hasData)
                  {_controller.value = _controller.value.copyWith(text: snapshot.data.toString());}
            return SizedBox(width: 300.0,child:
            TextField(
              textCapitalization: TextCapitalization.characters,
              onChanged: bloc.cusAddressChanged,
              controller: _controller,
              decoration: InputDecoration(
              labelText: 'Customer Address'
              ),
              enabled: false,
             ) );
          }
        );
      
    }
    
    
  Widget cusInvDate(Bloc bloc)
    {
      TextEditingController _controller = new TextEditingController();
      // final formats = { InputType.date: DateFormat('dd/MM/yyyy'),};
    // InputType inputType = InputType.date;
      return StreamBuilder(
        stream: bloc.cusInvDate,
        builder: (context, snapshot) 
          { 
           if(snapshot.hasData)
        {_controller.value = _controller.value.copyWith(text:  DateFormat("dd/MM/yyyy").format(snapshot.data).toString());}
            // if(snapshot.hasData)
            //       {_controller.value = _controller.value.copyWith(text: snapshot.data.toString());}
            return  SizedBox(width: 300.0,child: TextField(
              textCapitalization: TextCapitalization.characters,
              // onChanged: bloc.cusInvDateChanged,
              controller: _controller,
              decoration: InputDecoration(
              labelText: 'Date'
              ),
              enabled: false,
            ));
          }
        );
      
    }


  Widget cusInvoiceNo(Bloc bloc)
    {
      TextEditingController _controller = new TextEditingController();
      return StreamBuilder(
        stream: bloc.cusInvNo,
        builder: (context, snapshot) 
          { 
            if(snapshot.hasData)
                  {_controller.value = _controller.value.copyWith(text: snapshot.data.toString());}
            return 
          SizedBox(width: 300.0,child:  TextField(
              textCapitalization: TextCapitalization.characters,
              onChanged: bloc.cusInvNoChanged,
              controller: _controller,
              decoration: InputDecoration(
              labelText: 'Invoice No.'
              ),
              enabled: false,
           ) );
          }
        );
      
    }
    
  Widget cusOrderNo(Bloc bloc)
    {
      TextEditingController _controller = new TextEditingController();
      return StreamBuilder(
        stream: bloc.cusInvOrderNo,
        builder: (context, snapshot) 
          { 
                    if(snapshot.hasData)
                  {_controller.value = _controller.value.copyWith(text: snapshot.data.toString());}
            return 
          SizedBox(width: 300.0,child:  TextField(
              textCapitalization: TextCapitalization.characters,
              onChanged: bloc.cusInvOrderNoChanged,
              controller: _controller,
              decoration: InputDecoration(
              labelText: 'Order No.',
              ),
              enabled: false,
           ) );
          }
        );
      
    }
  Widget cusItemNo(Bloc bloc)
    {
      TextEditingController _controller = new TextEditingController();
      return StreamBuilder(
        stream: bloc.cusInvItemNo,
        builder: (context, snapshot) 
          { 
            _controller.value = _controller.value.copyWith(text: snapshot.data);
            print(snapshot.data.toString());
            return TextField(
              textCapitalization: TextCapitalization.characters,
              onChanged: bloc.cusInvItemNoChanged,
              controller: _controller,
              decoration: InputDecoration(
              labelText: 'Item No.',
              ),
              enabled: false,
            );
          }
        );
      
    }
  Widget cusProductCode(Bloc bloc)
    {
      TextEditingController _controller = new TextEditingController();
      return StreamBuilder(
        stream: bloc.cusInvProdCode,
        builder: (context, snapshot) 
          { 
                if(snapshot.hasData)
                  {_controller.value = _controller.value.copyWith(text: snapshot.data.toString());}
            return TextField(
              textCapitalization: TextCapitalization.characters,
              onChanged: bloc.cusInvProdCodeChanged,
              controller: _controller,
              decoration: InputDecoration(
              labelText: 'Product Code',
              ),
              enabled: false,
            );
          }
        );
      
    }
  Widget cusProdDesc(Bloc bloc)
    {
      TextEditingController _controller = new TextEditingController();
      return StreamBuilder(
        stream: bloc.cusInvPrdDes,
        builder: (context, snapshot) 
          { 
            _controller.value = _controller.value.copyWith(text: snapshot.data);
            print(snapshot.data.toString());
            return TextField(
              textCapitalization: TextCapitalization.characters,
              onChanged: bloc.cusInvPrdDesChanged,
              controller: _controller,
              decoration: InputDecoration(
              labelText: 'Product Description',
              ),
              enabled: false,
            );
          }
        );
      
    }
  Widget cusQuantity(Bloc bloc)
    {
      TextEditingController _controller = new TextEditingController();
      return StreamBuilder(
        stream: bloc.cusInvQty,
        builder: (context, snapshot) 
          { 
            _controller.value = _controller.value.copyWith(text: snapshot.data);
            print(snapshot.data.toString());
            return TextField(
              textCapitalization: TextCapitalization.characters,
              onChanged: bloc.cusInvQtyChanged,
              controller: _controller,
              decoration: InputDecoration(
              labelText: 'Quantity',
              ),
              enabled: false,
            );
          }
        );
      
    }
  Widget cusPrice(Bloc bloc)
    {
      TextEditingController _controller = new TextEditingController();
      return StreamBuilder(
        stream: bloc.cusInvPrice,
        builder: (context, snapshot) 
          { 
            _controller.value = _controller.value.copyWith(text: snapshot.data);
            print(snapshot.data.toString());
            return TextField(
              textCapitalization: TextCapitalization.characters,
              onChanged: bloc.cusInvPriceChanged,
              controller: _controller,
              decoration: InputDecoration(
              labelText: 'Price',
              ),
              enabled: false,
            );
          }
        );
      
    }


Widget listTile(Bloc bloc)
{
   
  return StreamBuilder(
    stream: bloc.cusInvDtls,
    builder: (context, ssInvDt) {
    List invData = ssInvDt.hasData ? ssInvDt.data : <CustomerInvDts>[];
    print('Items Length: ');
      return ListView.builder(
          itemCount: invData.length,
          itemBuilder: (context, index) 
          { return Container(height: 95.0,padding: EdgeInsets.only(top:15.0),
              child: Card(
                margin: EdgeInsets.only(right: 5.0, left: 5.0),
                elevation: 10.0,
                child: ListTile(
                  title: Column(children: <Widget>[
                    Row(children: <Widget>[
                    Expanded(flex: 4,child: Text('Product:'),),
                    Expanded(flex: 6,child: Text(invData[index].productDescription),),
                  ],),
                   Row(children: <Widget>[
                    Expanded(flex: 4,child: Text('Quantity:'),),
                    Expanded(flex: 6,child: Text(invData[index].quantity.toString()),),
                  ],),
                   Row(children: <Widget>[
                    Expanded(flex: 4,child: Text('Price:'),),
                    Expanded(flex: 6,child: Text(invData[index].price.toString()),),
                  ],),
                  ],), 
                  
               
                  ),
              )); 
        });
    //} else { return Center(child:CircularProgressIndicator());}
  });
}
  Widget listTile1(Bloc bloc)
  {
    // InvoiceApi inAPI = new InvoiceApi();
    // CustomerInvDts cusInv;
    return StreamBuilder(
      stream: bloc.cusInvDtls,
      builder: (context,ssInv){
         print('productcode');
      //  return   FutureBuilder(
      // future: inAPI.getInvoiceDetails(StaticsVar.branchID,invoiceNo),
      // builder: (context, ssInvoices) {

      //   if(ssInvoices.hasData)
      //   { 
      //     cusInv = ssInvoices.data; 
      
      //   }
      List invoices = ssInv.hasData ? ssInv.data : <CustomerInvDts>[];
        return ListView.builder(
            itemCount: invoices.length,
            itemBuilder: (context, index) 
            { 
              return Container(height: 125.0,padding: EdgeInsets.only(top:15.0),
                child: Card(
                  margin: EdgeInsets.only(right: 5.0, left: 5.0),
                  elevation: 10.0,
                  child: ListTile(
                    title:Column(children: <Widget>[
                      Text(invoices[index].productCode),        
                            
                    ],), 
                    onTap: (){},                   
                  
                  ),
                )
                ); 
          // });
      //} else { return Center(child:CircularProgressIndicator());}
       }
        ); 
         });
  
}

}



//   Widget saveFlatbtn(BuildContext context, Bloc bloc,Users loginInfo)
//   { 
//     SupplierApiProvider suppApi = new SupplierApiProvider();
//     return Container(
//             child:  Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: <Widget>[
//                 FlatButton(child: Text('CANCEL',style: TextStyle(color: Colors.blue),),
//                 onPressed: () {Navigator.pop(context);},),
//                 FlatButton( child: Text('SAVE', style: TextStyle(color: Colors.blue),),
//                 onPressed: () async{
//                   Supplier savsuppDtls = new Supplier();    
//                   savsuppDtls = bloc.saveSupplierDtls();
//                   await suppApi.saveSupplierList(savsuppDtls).then((onValue){
//                   if(onValue == true){
//                     bloc.clearSupplier();
//                     Navigator.push(context, MaterialPageRoute(builder: (context)=> SupplierCards(loginInfo: loginInfo,)));
//                     }else {return  Exception('Failed to Save Supplier List');}}
//                     );
//                 }, ),
//             ],
//           ),
//         );
   
//  }
