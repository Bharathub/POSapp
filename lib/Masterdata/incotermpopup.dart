import 'package:flutter/material.dart';
import 'package:split/Bloc/Bloc.dart';
import 'package:split/Bloc/provider.dart';
import 'package:split/Masterdata/incoterms.dart';
import 'package:split/src/APIprovider/lookUpApiProvider.dart';
import 'package:split/src/Models/loginmodel.dart';
import 'dart:ui';

import 'package:split/src/Models/lookupModel.dart';


class Incotermpopup extends StatefulWidget 
{
  final Users loginInfo;
  final String incoCode;
  final String incoDes;
  Incotermpopup({Key key, @required this.loginInfo, this.incoCode, this.incoDes}) :super(key: key);
   @override
  _IncotermpopupState createState() => _IncotermpopupState();
}

class _IncotermpopupState extends State<Incotermpopup> 
{
  bool isInEditMode = false;
  int intCount = 0;

  @override
  Widget build(BuildContext context) 
  {
    var bloc = Provider.of(context);
    isInEditMode = (widget.incoCode != "");

    intCount = intCount+1; //print('UOM Executed N.O.Times: ' + intCount.toString()); 
    if(intCount==1) {bloc.setUOMDtls(widget.incoCode, widget.incoDes);}

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
        title: Text('Add/Edit Incoterms'),
        backgroundColor: Color(0xffd35400),
        leading: IconButton(
        icon: Icon(Icons.arrow_back),
        color: Colors.white,
        onPressed:(){Navigator.push(context, MaterialPageRoute(builder: (context) => IncoTerms(loginInfo: widget.loginInfo,)));},
            ),
        ),
        body: SingleChildScrollView(
              child: Container(
              margin: EdgeInsets.only(top: 220.0, left: 5.0, right: 5.0),
              child: Card(
              elevation: 10,
              child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                  SizedBox(width: 300,child: incoCodTxtFld(bloc, !isInEditMode)),
                  SizedBox(width: 300,child:incoDesTxtFld(bloc)),
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



   Widget incoCodTxtFld(Bloc bloc, bool isEditable)
  {
    TextEditingController _controller = new TextEditingController();
    return StreamBuilder(
      stream: bloc.lookUpCode,
      builder: (context, snapshot) 
        { 
          _controller.value = _controller.value.copyWith(text: snapshot.data);
          print(snapshot.data.toString());
          return TextField(
            textCapitalization: TextCapitalization.characters,
            // style: txtRoboStyle(20),
            onChanged: bloc.lookUpCodeChanged,
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


 Widget incoDesTxtFld(Bloc bloc)
  {
    TextEditingController _controller = new TextEditingController();
    return StreamBuilder(
      stream: bloc.lookUpDes,
      builder: (context, snapshot) 
        { 
          _controller.value = _controller.value.copyWith(text: snapshot.data);
          print(snapshot.data.toString());
          return TextField(
            textCapitalization: TextCapitalization.characters,
            onChanged: bloc.lookUpDesChanged,
            controller: _controller,
            decoration: InputDecoration(
            labelText: 'Description',
            ),
          );
        }
      );
  }

  
Widget saveFlatbtn(BuildContext context, Bloc bloc, Users loginInfo)
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
                  uomSavDtls=bloc.saveLookUpDtls("INCOTERM");
                  await lookupApi.saveLookUptList(uomSavDtls).then((onValue){
                  if(onValue == true){
                    bloc.clearLookUps();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> IncoTerms(loginInfo:loginInfo,)));
                    }else {return  Exception('Failed to Save UOM');} }
                    );   

        }, ),
            ],
          ),
        );
   
}
