import 'package:flutter/material.dart';
import 'package:split/Bloc/Bloc.dart';
import 'package:split/Bloc/provider.dart';
import 'package:split/Masterdata/location.dart';
import 'dart:ui';
import 'package:split/src/APIprovider/lookUpApiProvider.dart';
import 'package:split/src/Models/loginmodel.dart';
import 'package:split/src/Models/lookupModel.dart';

class Locationpopup extends StatefulWidget {
  final Users loginInfo;
  final String locCode;
  final String locDes;  
  Locationpopup({Key key, @required this.loginInfo,this.locCode,this.locDes}) :super(key: key);


  @override
  _LocationpopupState createState() => _LocationpopupState();
}

class _LocationpopupState extends State<Locationpopup> 
{
  bool isInEditMode = false;
  int intCount = 0;

  @override
  Widget build(BuildContext context) 
  {
    var bloc = Provider.of(context);
    isInEditMode = (widget.locCode != "");
    
    intCount = intCount+1; //print('UOM Executed N.O.Times: ' + intCount.toString()); 
    if(intCount==1) {bloc.setUOMDtls(widget.locCode, widget.locDes);}

    return MaterialApp(
      home: Scaffold(
         appBar: AppBar(
            backgroundColor: Color(0xffd35400),
            title: Text('Add/Edit Werehouse Location'),
            leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed:(){ Navigator.push(context,MaterialPageRoute(builder: (context) => WareHouseLocation(loginInfo: widget.loginInfo,)));},),
          ),
      body:SingleChildScrollView(
            child: Container(
            margin: EdgeInsets.only(top: 220.0, left: 5.0, right: 5.0),
            child: Card(
            elevation: 10,
            child: Column(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(width: 300,child: loccodeTxtField(bloc, !isInEditMode)),
              SizedBox(width: 300,child: locdescTxtField(bloc),),
              savpopFlatbtn(context,bloc,widget.loginInfo),],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


  
  Widget loccodeTxtField(Bloc bloc, bool isEditable)
  {
    TextEditingController _controller = new TextEditingController();
    return StreamBuilder(
      stream: bloc.lookUpCode,
      builder: (context, snapshot) 
        { 
          _controller.value = _controller.value.copyWith(text: snapshot.data);
          print('LOCATION ' + snapshot.data.toString());
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


  Widget locdescTxtField(Bloc bloc)
 {
    TextEditingController _controller = new TextEditingController();
    return StreamBuilder(
      stream: bloc.lookUpDes,
      builder: (context, snapshot) 
      { 
          _controller.value = _controller.value.copyWith(text: snapshot.data);
          print('LOCATION ' + snapshot.data.toString());
          return TextField(
            textCapitalization: TextCapitalization.characters,
            // style: txtRoboStyle(20),
            onChanged: bloc.lookUpDesChanged,
            // onSubmitted:bloc.locDesChanged,
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

  Widget savpopFlatbtn(BuildContext context, Bloc bloc, Users loginInfo)

  {      LookUpApiProvider lookupApi = LookUpApiProvider();
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
                    uomSavDtls=bloc.saveLookUpDtls("LOCATION");
                    await lookupApi.saveLookUptList(uomSavDtls).then((onValue){
                    if(onValue == true){
                      bloc.clearLookUps();
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> WareHouseLocation(loginInfo:loginInfo)));
                      }else {return  Exception('Failed to Save Location');} }
                      ); }, ),
                      ],
                    ),
                  );
          
  }