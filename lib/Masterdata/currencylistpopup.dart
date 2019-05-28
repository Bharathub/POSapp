import 'package:flutter/material.dart';
import 'package:split/Bloc/Bloc.dart';
import 'package:split/Bloc/provider.dart';
import 'package:split/Masterdata/currencylist.dart';
import 'package:split/src/APIprovider/currencyApiProvider.dart';
import 'package:split/src/Models/currencyModel.dart';
import 'package:split/src/Models/loginmodel.dart';



class CurrencyPopup extends StatefulWidget {

  final Users loginInfo;
  final String curCode;
  final String curDes; 
  final String curDes1; 
  CurrencyPopup({Key key, @required this.loginInfo,this.curCode,this.curDes,this.curDes1}) :super(key: key);
  @override
  _CurrencyPopupState createState() => _CurrencyPopupState();
}

class _CurrencyPopupState extends State<CurrencyPopup> 
{
  bool isInEditMode = false;
  int intCount = 0;
  @override
  Widget build(BuildContext context) 
  {
    var bloc = Provider.of(context); 
    isInEditMode = (widget.curCode != "");
    
    intCount = intCount+1; //print('Currency Executed N.O.Times: ' + intCount.toString()); 
    if(intCount==1) { bloc.setCurrencyDtls(widget.curCode, widget.curDes,widget.curDes1);}
    
    return MaterialApp(
      home: Scaffold(
            appBar: AppBar(
            title: Text('Add/Edit Currency'),
            backgroundColor: Color(0xffd35400),
            leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed:(){Navigator.push(context,MaterialPageRoute(builder: (context) => CurrencyList(loginInfo: widget.loginInfo,))); },),
        ),
      body: SingleChildScrollView(
            child: Container(
            margin: EdgeInsets.only(top: 220.0, left: 5.0, right: 5.0),
            child: Card(
            elevation: 10,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(width:300,child: currCodTxtFld(bloc, !isInEditMode)),
              SizedBox(width:300,child:currDesTxtFld(bloc)),
              SizedBox(width:300,child:currDes1TxtFld(bloc)),
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

  Widget  currCodTxtFld(Bloc bloc,bool isEditable)
 {
    TextEditingController _controller = new TextEditingController();
    return StreamBuilder(
      stream: bloc.currCode,
      builder: (context, snapshot) 
      { 
          _controller.value = _controller.value.copyWith(text: snapshot.data);
          print(snapshot.data.toString());
          return TextField(
            textCapitalization: TextCapitalization.characters,
            // style: txtRoboStyle(20),
            onChanged: bloc.currCodeChanged,
            controller: _controller,
            //keyboardType: TextInputType.emailAddress
            decoration: InputDecoration(
              enabled: isEditable,
              labelText: 'Currency Code',
            //errorText: snapshot.error,
            ),
          );
      }
      );
  }


  Widget currDesTxtFld(Bloc bloc)
 {
    TextEditingController _controller = new TextEditingController();
    return StreamBuilder(
      stream: bloc.currDes,
      builder: (context, snapshot) 
      { 
          _controller.value = _controller.value.copyWith(text: snapshot.data);
          print(snapshot.data.toString());
          return TextField(
            textCapitalization: TextCapitalization.characters,
            // style: txtRoboStyle(20),
            onChanged: bloc.currDescChanged,
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
  
  Widget currDes1TxtFld(Bloc bloc)
 {
    TextEditingController _controller = new TextEditingController();
    return StreamBuilder(
      stream: bloc.currDes1,
      builder: (context, snapshot) 
      { 
          _controller.value = _controller.value.copyWith(text: snapshot.data);
          print(snapshot.data.toString());
          return TextField(
            textCapitalization: TextCapitalization.characters,
            // style: txtRoboStyle(20),
            onChanged: bloc.currDesc1Changed,
            controller: _controller,
            //keyboardType: TextInputType.emailAddress
            decoration: InputDecoration(
            // labelStyle: txtRoboStyle(20),
            // hintText: 'UOM Code',
            labelText: 'Description1',
            //errorText: snapshot.error,
            ),
          );
      }
      );
  }


Widget saveFlatbtn(BuildContext context, Bloc bloc,Users logininfo)
{    CurrencyApiProvider currApi = new CurrencyApiProvider();
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
              Currency  currDtls = new Currency();    
              currDtls=bloc.saveCurrencyDtls();
              await currApi.saveCurrencyList(currDtls).then((onValue){
                  if(onValue == true){
                    bloc.clearCurrencyDetails();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> CurrencyList(loginInfo: logininfo ,)));
                    }else {return  Exception('Failed to Save UOM');}}
                    );
        }, ),
            ],
          ),
        );
   
}



