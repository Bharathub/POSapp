import 'package:flutter/material.dart';
import 'package:split/Bloc/Bloc.dart';
import 'package:split/Bloc/provider.dart';
import 'package:split/Masterdata/paymenttype.dart';
import 'dart:ui';
import 'package:split/src/APIprovider/lookUpApiProvider.dart';
import 'package:split/src/Models/loginmodel.dart';
import 'package:split/src/Models/lookupModel.dart';

class PaymentPopup extends StatefulWidget 
{
  final Users loginInfo;
  final String payCode;
  final String payDes;
  PaymentPopup({Key key, @required this.loginInfo,this.payCode,this.payDes}) :super(key: key);
  @override
  _PaymentPopuppState createState() => _PaymentPopuppState();
}

class _PaymentPopuppState extends State<PaymentPopup> 
{
  bool isInEditMode =  false;
  int intCount = 0;

  @override
  Widget build(BuildContext context) 
  {
    var bloc = Provider.of(context);
    isInEditMode = (widget.payCode != "");
    
    intCount = intCount+1; //print('UOM Executed N.O.Times: ' + intCount.toString()); 
    if(intCount==1) {bloc.setUOMDtls(widget.payCode, widget.payDes);}

    return MaterialApp(
      //theme: new ThemeData(primaryColor: Color.fromRGBO(58, 66, 86, 1.0)),
      home: Scaffold(
            appBar: AppBar(
            backgroundColor: Color(0xffd35400),
            title: Text('Add/Edit PaymentType'),
            leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context) => PaymentType(loginInfo: widget.loginInfo,)));
              },
            ),
          ),
        body: SingleChildScrollView(
              child: Container(
              margin: EdgeInsets.only(top: 220.0, left: 5.0, right: 5.0),
              child: Card(
              elevation: 10,
              child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
             SizedBox(width: 300,child:payTypeTxtFld(bloc, !isInEditMode),),
             SizedBox(width: 300,child:    payDesTxtFld(bloc)),
              saveFlatbtn(context, bloc,widget.loginInfo),
                ],
                ),
            ),
          ),
        ),
      ),
    );
  }
}


  Widget payTypeTxtFld(Bloc bloc,bool isEditable)
  {
    TextEditingController _controller = new TextEditingController();
    return StreamBuilder(
      stream: bloc.lookUpCode,
      builder: (context,snapshot) 
      { 
        _controller.value = _controller.value.copyWith(text: snapshot.data);
        print('PAYMENT ' + snapshot.data.toString());
        return TextField(
          textCapitalization: TextCapitalization.characters,
          onChanged: bloc.lookUpCodeChanged,
          controller: _controller,
          decoration: InputDecoration(  
          enabled: isEditable, 
          labelText: 'Code: ',
            ),
          );
        }
      );
  }


 Widget payDesTxtFld(Bloc bloc)
 {
    TextEditingController _controller = new TextEditingController();
    return StreamBuilder(
      stream: bloc.lookUpDes,
      builder: (context, snapshot) 
      { 
          _controller.value = _controller.value.copyWith(text: snapshot.data);
          print('PAYMENT ' + snapshot.data.toString());
          return TextField(
            textCapitalization: TextCapitalization.characters,
            // style: txtRoboStyle(20),
            onChanged: bloc.lookUpDesChanged,
            controller: _controller,
            //keyboardType: TextInputType.emailAddress
            decoration: InputDecoration(
            // labelStyle: txtRoboStyle(20),
            // hintText: 'UOM Code',
            labelText: 'Description: ',
            //errorText: snapshot.error,
            ),
          );
      }
      );
  }


Widget saveFlatbtn(BuildContext context, Bloc bloc,Users loginInfo)
{    LookUpApiProvider lookupApi = LookUpApiProvider();
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
                Lookup uomSavDtls = new Lookup();  
                  uomSavDtls=bloc.saveLookUpDtls("PAYMENTTYPE");
                  await lookupApi.saveLookUptList(uomSavDtls).then((onValue){
                  if(onValue == true){
                    bloc.clearLookUps();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> PaymentType(loginInfo:loginInfo,)));
                    }else {return  Exception('Failed to Save Payment Type');}}
                    );

        }, ),
            ],
          ),
        );
   
}
