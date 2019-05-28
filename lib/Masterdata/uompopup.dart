import 'package:flutter/material.dart';
import 'package:split/Bloc/Bloc.dart';
import 'package:split/Bloc/provider.dart';
import 'package:split/Masterdata/uom.dart';
import 'package:split/src/APIprovider/lookUpApiProvider.dart';
import 'package:split/src/Models/loginmodel.dart';
import 'package:split/src/Models/lookupModel.dart';

class UOMpopup extends StatefulWidget {
  
  final  Users loginInfo;
  final String lkupCode;
  final String desc;
  UOMpopup({Key key, @required this.loginInfo, this.lkupCode, this.desc}) :super(key: key);

  @override
  _UOMpopupState createState() => _UOMpopupState();
}

class _UOMpopupState extends State<UOMpopup> 
{
  bool isInEditMode = false;
  int intCount = 0;
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of(context);
    print('UOM CODE: ' +  widget.lkupCode.toString() + ' is the CODE');
    isInEditMode = (widget.lkupCode != "");
    //if(isInEditMode) { bloc.setUOMDtls(widget.lkupCode, widget.desc);}
    
    intCount = intCount+1; //print('UOM Executed N.O.Times: ' + intCount.toString()); 
    if(intCount==1) {bloc.setUOMDtls(widget.lkupCode, widget.desc);}
  
    return MaterialApp(
        home: Scaffold(
        appBar: AppBar(
        title: Text('Add/Edit UOM'),
        backgroundColor: Color(0xffd35400),
        leading: IconButton(
        icon: Icon(Icons.arrow_back),
        color: Colors.white,
        onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context) => UomList(loginInfo: widget.loginInfo,)));},
            ),
          ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 220.0, left: 5.0, right: 5.0),
            child: Card(
            elevation: 10,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
            SizedBox(width: 300,child:lookupCodeTxtFld(bloc, !isInEditMode)),
            SizedBox(width: 300,child: lookupDescTxtFld(bloc)),
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

  Widget lookupCodeTxtFld(Bloc bloc, bool canEdit)
  {
    TextEditingController _controller = new TextEditingController();
    return StreamBuilder(
      stream: bloc.lookUpCode,
      builder: (context, snapshot) 
        { 
          _controller.value = _controller.value.copyWith(text: snapshot.data);
          print('UOM ' + snapshot.data.toString());
          return TextField(
            textCapitalization: TextCapitalization.characters,
            // style: txtRoboStyle(20),
            onChanged: bloc.lookUpCodeChanged,
            controller: _controller,
            //keyboardType: TextInputType.emailAddress
            decoration: InputDecoration(
            enabled: canEdit,
            // labelStyle: txtRoboStyle(20),
            // hintText: 'UOM Code',
            labelText: 'UOM Code',
            //errorText: snapshot.error,
            ),
          );
        }
      );
    
  }

  Widget lookupDescTxtFld(Bloc bloc)
 {
    TextEditingController _controller = new TextEditingController();
    return StreamBuilder(
      stream: bloc.lookUpDes,
      builder: (context, snapshot) 
      { 
          _controller.value = _controller.value.copyWith(text: snapshot.data);
          print('UOM ' + snapshot.data.toString());
          return TextField(
            textCapitalization: TextCapitalization.characters,
            // style: txtRoboStyle(20),
            onChanged: bloc.lookUpDesChanged,
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

  Widget saveFlatbtn(BuildContext context, Bloc bloc, Users loginInfo)
  {   
    LookUpApiProvider uomApi = LookUpApiProvider();
    return Container(
      child:Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        FlatButton(child: Text('CANCEL',style: TextStyle(color: Colors.blue),),
        onPressed: () //{Navigator.push(context, MaterialPageRoute(builder: (context)=> UomList(loginInfo:loginInfo,)));}), 
        {Navigator.pop(context);},),
        FlatButton( child: Text( 'SAVE', style: TextStyle(color: Colors.blue),),
        onPressed: ()
        async{Lookup uomSavDtls = new Lookup();
        uomSavDtls=bloc.saveLookUpDtls("UOM");
        await uomApi.saveLookUptList(uomSavDtls).then((onValue)
          {
            if(onValue == true){
              bloc.clearLookUps();
              Navigator.push(context, MaterialPageRoute(builder: (context)=> UomList(loginInfo:loginInfo,)));}
            else {return  Exception('Failed to Save UOM');} 
          }
        );},
        ),
      ],
    ),
  );
   
  }
