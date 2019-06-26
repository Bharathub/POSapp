import 'package:flutter/material.dart';
import 'package:split/Bloc/Bloc.dart';
import 'package:split/Bloc/provider.dart';
import 'package:split/Masterdata/suppliertariff.dart';
import 'package:split/src/APIprovider/supplierApiProvider.dart';
import 'package:split/src/Models/loginmodel.dart';
import 'package:split/src/Models/suppliermodel.dart';

class SupplierPopup extends StatefulWidget
{
  final Users loginInfo;
  final String supCode;
  SupplierPopup({Key key, @required this.loginInfo,this.supCode,}) :super(key: key);
  @override
  _SupplierPopupState createState() => _SupplierPopupState();
}

class _SupplierPopupState extends State<SupplierPopup> 
{
  bool isInEditMode = false;
  int intCount = 0;

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of(context);
    isInEditMode = (widget.supCode != ""); // true : means Edit mode // false: means New Quotation

    //if(isInEditMode) 
      //{ 
        intCount = intCount+1; //print('SUPPLIER No Of Times Executed: ' + intCount.toString()); 
        if(intCount==1) {bloc.initiateSuppliers(true); bloc.initiateCountrys(true); bloc.fetchSupplier(widget.supCode);}
      //}

    //  bloc.setSupplierDtls(widget.supCode);
    //  isEditable = (widget.supCode == "");
    
    return MaterialApp(
      //theme: new ThemeData(primaryColor: Color.fromRGBO(58, 66, 86, 1.0)),
      home: Scaffold(
            appBar: AppBar(
            title: Text('Add Supplier List'),
            backgroundColor: Color(0xffd35400),
            leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context) => SupplierCards(loginInfo: widget.loginInfo,))); },),
        ),
        body: SingleChildScrollView(
          child: Container(
          margin: EdgeInsets.only(left: 5.0, right: 5.0),
          child: Card(
          elevation: 10,
          child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
           //SizedBox(width: 300,child: supCodeTxtFld(bloc,!isInEditMode)),
           SizedBox(width: 300,child:suppNameTxtFld(bloc)),
           SizedBox(width: 300,child:suppRegTxtFld(bloc)),
            suppCustTxtFld(bloc),
            suppContactTxtFld(bloc),
            Divider(height: 80.0,color: Colors.blueGrey,),
            suppAddress1TxtFld(bloc),
            suppAddress2TxtFld(bloc),
            Wrap(children: <Widget>[
            // SizedBox(width: 20.0,),
            suppCityTxtFld(bloc),
            SizedBox(width: 20.0,),
            suppStateTxtFld(bloc),
            ]),
            SizedBox(height: 10.0,),
            suppCountiesTxtFld(bloc),
            SizedBox(height: 10.0,),
            suppZipTxtFld(bloc),
            suppPhoneNumTxtFld(bloc),
            suppFaxNumTxtFld(bloc),
            suppEmailTxtFld(bloc),
            SizedBox(height: 20.0),
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


Widget supCodeTxtFld(Bloc bloc,bool isEditable)
  {
    TextEditingController _controller = new TextEditingController();
    return StreamBuilder(
      stream: bloc.codeSupp,
      builder: (context, snapshot) 
        { 
          _controller.value = _controller.value.copyWith(text: snapshot.data);
          print(snapshot.data.toString());
          return TextField(
            textCapitalization: TextCapitalization.characters,
            onChanged: bloc.suppCodeChange,
            controller: _controller,
            decoration: InputDecoration(
            labelText: 'Code',
            ),
            enabled: false,
          );
        }
      );
    
  }


  Widget suppNameTxtFld(Bloc bloc,)
  {
    TextEditingController _controller = new TextEditingController();
    return StreamBuilder(
      stream: bloc.nameSupp,
      builder: (context, snapshot) 
        { 
          _controller.value = _controller.value.copyWith(text: snapshot.data);
          print(snapshot.data.toString());
          return TextField(
            textCapitalization: TextCapitalization.characters,
            // style: txtRoboStyle(20),
            onChanged: bloc.suppNameChange,
            controller: _controller,
            //keyboardType: TextInputType.emailAddress
            decoration: InputDecoration(
              // enabled: isEditable,
            // labelStyle: txtRoboStyle(20),
            // hintText: 'UOM Code',
            labelText: 'Name/Supplier Name',
            //errorText: snapshot.error,
            ),
          );
        }
      );
    
  }

   Widget suppRegTxtFld(Bloc bloc,)
  {
    TextEditingController _controller = new TextEditingController();
    return StreamBuilder(
      stream: bloc.regSupp,
      builder: (context, snapshot) 
        { 
          _controller.value = _controller.value.copyWith(text: snapshot.data);
          print(snapshot.data.toString());
          return TextField(
            textCapitalization: TextCapitalization.characters,
            onChanged: bloc.suppRegChange,
            controller: _controller,
            decoration: InputDecoration(
            labelText: 'Reg No.',
            ),
          );
        }
      );
    
  }

 suppCustTxtFld(Bloc bloc)
 {
   return StreamBuilder(
     stream: bloc.custSupp,
     builder: (context,snapshot){
       return SizedBox(
         width: 300,
         child:InputDecorator(
         decoration: InputDecoration(labelText: 'Supplier Type',),
         child: DropdownButtonHideUnderline(
           child: DropdownButton<String>(
             isDense: true,
             items: ['SUPPLIER','NONE','MANUFACTURER']
             .map<DropdownMenuItem<String>>(
               (String value) {
                 return DropdownMenuItem<String>(
                   value: value,
                   child: Text(value),
                   );
                }).toList(),
                value: snapshot.data,
                onChanged: bloc.suppCustChange,
                hint: Text('Select Supplier Types'),
                isExpanded: true,elevation: 8,
              ),
              ),
            ),
          );
      }
      );
  }

             
 suppContactTxtFld(Bloc bloc)
 {  TextEditingController _controller = new TextEditingController();
      return StreamBuilder<String>(
      stream: bloc.contactPerson,
      builder:(context,snapshot){
      if(snapshot.hasData)
      {_controller.value = _controller.value.copyWith(text: snapshot.data.toString());}   
                return
              SizedBox(width: 300.0,
              child: TextField(
                 textCapitalization: TextCapitalization.characters,
                onChanged: bloc.contactChange,
                controller: _controller, 
               decoration: InputDecoration(
                // errorText: snapshot.error,
                labelText: 'Contact Person'),)
                 );}
                 );
}
  suppAddress1TxtFld(Bloc bloc)
  {
    TextEditingController _controller = new TextEditingController();
    return StreamBuilder<String>(
      stream: bloc.address1,
      builder:(context,snapshot){
          if(snapshot.hasData)
      {_controller.value = _controller.value.copyWith(text: snapshot.data.toString());}        
                return
              SizedBox(width: 300.0,
              child: TextField(
                textCapitalization: TextCapitalization.characters,
                onChanged: bloc.adress1Change,
                controller: _controller, 
              decoration: InputDecoration(
                // errorText: snapshot.error,
                labelText: 'Address 1'),) );});
}
suppAddress2TxtFld(Bloc bloc)
 {  TextEditingController _controller = new TextEditingController();
              return StreamBuilder<String>(
              stream: bloc.address2,
              builder:(context,snapshot){
                  if(snapshot.hasData)
      {_controller.value = _controller.value.copyWith(text: snapshot.data.toString());}
             return SizedBox(width: 300.0,
              child: TextField(
                textCapitalization: TextCapitalization.characters,
                onChanged: bloc.adress2Change, 
                controller: _controller,
                decoration: InputDecoration(
                //  errorText: snapshot.error,
                labelText: 'Address 2'),) );});
}
suppCityTxtFld(Bloc bloc)
 {  TextEditingController _controller = new TextEditingController();
              return StreamBuilder<String>(
              stream: bloc.city,
              builder:(context,snapshot){
                if(snapshot.hasData)
      {_controller.value = _controller.value.copyWith(text: snapshot.data.toString());}
                return
              SizedBox(width: 150.0,
              child: TextField(
                textCapitalization: TextCapitalization.characters,
                onChanged: bloc.cityChange,
                controller: _controller, 
                decoration: InputDecoration(
                //  errorText: snapshot.error,
                labelText: 'City / District'),) );});
}
suppStateTxtFld(Bloc bloc)
 {  TextEditingController _controller = new TextEditingController();
              return StreamBuilder<String>(
              stream: bloc.state,
              builder:(context,snapshot){
                 if(snapshot.hasData)
      {_controller.value = _controller.value.copyWith(text: snapshot.data.toString());}
             return
              SizedBox(width: 150.0,
              child: TextField(
                textCapitalization: TextCapitalization.characters,
                onChanged: bloc.stateChange,
                controller: _controller,
                decoration: InputDecoration(
                //  errorText: snapshot.error,
                labelText: 'State'),) );});
}
  suppCountiesTxtFld(Bloc bloc) {  
    // SupplierApiProvider supApi = new SupplierApiProvider();

        return StreamBuilder(
          stream: bloc.country,
                  builder: (context, snapshot){
                  return StreamBuilder(
                  stream: bloc.initCountries,
                  builder:(context, country)
                  {
                    if (country.hasData){
                    return SizedBox(width: 300,child:InputDecorator(
                      decoration: InputDecoration(
                        //  errorText: snapshot.error,
                        labelText: 'Select Country'),
                      child:DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isDense: true,
                        items: country.data
                            .map<DropdownMenuItem<String>>(
                                (CountryList value) {
                          return DropdownMenuItem<String>(
                            value: value.countryCode.toString(),
                            child: Text(value.countryName),
                          );
                        }).toList(),
                        value: snapshot.data,
                        onChanged: bloc.countryChange,
                        hint: Text('Country Name'),
                        isExpanded: true,elevation: 8,
                        ) ) ));}
                          else{return CircularProgressIndicator();}
                      }
                              );}
                            );}

  suppZipTxtFld(Bloc bloc)
  { TextEditingController _controller = new TextEditingController();
    return StreamBuilder<String>(
      stream: bloc.zipCode,
      builder:(context,snapshot){
                if(snapshot.hasData)
      {_controller.value = _controller.value.copyWith(text: snapshot.data.toString());}
        return SizedBox(width: 300.0,
      child: TextField(
        textCapitalization: TextCapitalization.characters,
        onChanged: bloc.zipCodeChange,
        controller: _controller,
        keyboardType: TextInputType.number,
      // maxLength: 6,
      decoration: InputDecoration(
      // errorText: snapshot.error,
      labelText: 'ZIP Code'),
      ) );});
}
  suppPhoneNumTxtFld(Bloc bloc)
  {
    TextEditingController _controller = new TextEditingController();
    return StreamBuilder<String>(
      stream: bloc.phoneNum,
      builder:(context,snapshot)
      {
        if(snapshot.hasData)
        {_controller.value = _controller.value.copyWith(text: snapshot.data.toString());}
        return SizedBox(
          width: 300.0,
          child: TextField(
          textCapitalization: TextCapitalization.characters,
          onChanged: bloc.phoneNumChange,
          controller: _controller,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(labelText: 'Phone No.'),
          )
        );
      }
      );
}
  suppFaxNumTxtFld(Bloc bloc)
  {
    TextEditingController _controller = new TextEditingController();
    return StreamBuilder<String>(
      stream: bloc.faxNum,
      builder:(context,snapshot)
      {
        if(snapshot.hasData)
      {_controller.value = _controller.value.copyWith(text: snapshot.data.toString());}
      return SizedBox(
        width: 300.0,
        child: TextField(
          textCapitalization: TextCapitalization.characters,
          onChanged: bloc.faxNumChange,
          controller: _controller,
          keyboardType: TextInputType.numberWithOptions(), 
          decoration: InputDecoration(labelText: 'Fax'),
         )
        );
        }
      );
}
  suppEmailTxtFld(Bloc bloc)
  {
     TextEditingController _controller = new TextEditingController();
    return StreamBuilder<String>(
      stream: bloc.emailAdr,
      builder:(context,snapshot){
         if(snapshot.hasData)
      {_controller.value = _controller.value.copyWith(text: snapshot.data.toString());}
      return SizedBox(width: 300.0,
      child: TextField(
        textCapitalization: TextCapitalization.characters,
        onChanged: bloc.emailAddChange,
        controller: _controller,
         decoration: InputDecoration(labelText: 'Email'),
         )
       );}
      );
  }



  Widget saveFlatbtn(BuildContext context, Bloc bloc,Users loginInfo)
  { 
    SupplierApiProvider suppApi = new SupplierApiProvider();
    return Container(
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                FlatButton(child: Text('CANCEL',style: TextStyle(color: Colors.blue),),
                onPressed: () {Navigator.pop(context);},),
                FlatButton( child: Text('SAVE', style: TextStyle(color: Colors.blue),),
                onPressed: () async{
                  Supplier savsuppDtls = new Supplier();    
                  savsuppDtls = bloc.saveSupplierDtls();
                  await suppApi.saveSupplierList(savsuppDtls).then((onValue){
                  if(onValue == true){
                    bloc.clearSupplier();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> SupplierCards(loginInfo: loginInfo,)));
                    }else {return  Exception('Failed to Save Supplier List');}}
                    );
                }, ),
            ],
          ),
        );
   
}
