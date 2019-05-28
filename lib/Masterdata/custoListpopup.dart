import 'package:flutter/material.dart';
import 'package:split/Bloc/Bloc.dart';
import 'package:split/Bloc/provider.dart';
import 'package:split/Masterdata/customoertariff.dart';
import 'package:split/src/APIprovider/customerApiProvider.dart';
import 'package:split/src/Models/customermodel.dart';
import 'package:split/src/Models/loginmodel.dart';
import 'package:split/src/Models/suppliermodel.dart';

class CustomerListPopup extends StatefulWidget {
 final Users loginInfo;
 final String cusCode;
 final String cusName;
 final String regNo;
  CustomerListPopup({Key key, @required this.loginInfo,this.cusCode,this.cusName,this.regNo}) :super(key: key);
  @override
  _CustomerPopupState createState() => _CustomerPopupState();
}

class _CustomerPopupState extends State<CustomerListPopup> 
{
  //final bloc =  Bloc();
  bool isInEditMode = true;
  int intCount = 0;
  @override
  Widget build(BuildContext context) {

    var bloc = Provider.of(context);
    isInEditMode = (widget.cusName != "");
    // if(isInEditMode) 
    // { 
      intCount = intCount+1; //print('Customer --> Times Executed: ' + intCount.toString()); 
      if(intCount==1) {bloc.initiateCountrys(); bloc.fetchCustomer(widget.cusCode);}
      //if(intCount==1) { bloc.fetchCustomer(widget.cusCode,widget.cusName, widget.regNo);}
    //}

    // bloc.setCustomerDtls(widget.cusCode,widget.cusName, widget.regNo);
    
    return MaterialApp(
      home: Scaffold(
            appBar: AppBar(
            title: Text('Add Customer Details'),
            backgroundColor: Color(0xffd35400),
            leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context) => CustomerList(loginInfo: widget.loginInfo,))); },),
        ),
      body: SingleChildScrollView(
            child: Container(
            margin: EdgeInsets.only(left: 5.0, right: 5.0),
            child: Card(
            elevation: 10,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
            // SizedBox(width: 300,child: cusCode(bloc,isEditable),),
            SizedBox(width: 300,child: cusName(bloc),),
            SizedBox(width: 300,child: custRegTxtFld(bloc),),
            custCraditTermTxtFld(bloc),
            // custContactTxtFld(bloc),
            Divider(height: 80.0,color: Colors.blueGrey,),
            custAddress1TxtFld(bloc),
            custAddress2TxtFld(bloc),
           
            Wrap(children: <Widget>[
            // SizedBox(width: 20.0,),
            custCityTxtFld(bloc),
             SizedBox(width: 20.0,),
            custStateTxtFld(bloc),
            // SizedBox(width: 20.0,),
            ]),
            SizedBox(height: 10.0,),
            custCountiesTxtFld(bloc),
            SizedBox(height: 10.0,),
            custZipTxtFld(bloc),
            custPhoneNumTxtFld(bloc),
            custFaxNumTxtFld(bloc),
            custEmailTxtFld(bloc),
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


Widget cusCode(Bloc bloc,bool isEditable)
  {
    TextEditingController _controller = new TextEditingController();
    return StreamBuilder(
      stream: bloc.codeCustomer,
      builder: (context, snapshot) 
        { 
          _controller.value = _controller.value.copyWith(text: snapshot.data);
          print(snapshot.data.toString());
          return TextField(
            textCapitalization: TextCapitalization.characters,
            // style: txtRoboStyle(20),
            onChanged: bloc.codeCustomerChange,
            controller: _controller,
            //keyboardType: TextInputType.emailAddress
            decoration: InputDecoration(
               enabled: isEditable,
            // labelStyle: txtRoboStyle(20),
            // hintText: 'UOM Code',
            labelText: 'Code',
            //errorText: snapshot.error,
            ),
            enabled: false,
          );
        }
      );
    
  }
 


Widget cusName(Bloc bloc)
  {
    TextEditingController _controller = new TextEditingController();
    return StreamBuilder(
      stream: bloc.nameCustomer,
      builder: (context, snapshot) 
        { 
          if(snapshot.hasData) {_controller.value = _controller.value.copyWith(text: snapshot.data);}
          // print(snapshot.data.toString());
          return TextField(
            onChanged: bloc.custNameChange,
            controller: _controller,
            textCapitalization: TextCapitalization.characters,
            decoration: InputDecoration(labelText: 'Customer Name'),
          );
        }
      );
    
  }
Widget custRegTxtFld(Bloc bloc)
  {
    TextEditingController _controller = new TextEditingController();
    return StreamBuilder(
      stream: bloc.regCustomer,
      builder: (context, snapshot) 
        { 
          if(snapshot.hasData) {_controller.value = _controller.value.copyWith(text: snapshot.data);}
          // print(snapshot.data.toString());
          return TextField(
            onChanged: bloc.custRegChange,
            controller: _controller,
            textCapitalization: TextCapitalization.characters,
            decoration: InputDecoration(labelText: 'Reg No.'),
          );
        }
      );
    
  }
             
    custCraditTermTxtFld(Bloc bloc)
    {
      TextEditingController _controller = new TextEditingController();  
      return StreamBuilder(
      stream: bloc.custCreditTerm,
      builder:(context,snapshot){
         if(snapshot.hasData)
            {_controller.value = _controller.value.copyWith(text: snapshot.data.toString());}
      return SizedBox(width: 300.0,
      child: TextField(
        onChanged: bloc.custCreditChange,
        controller: _controller,
        textCapitalization: TextCapitalization.characters,
        keyboardType: TextInputType.numberWithOptions(), 
        decoration: InputDecoration(
          labelText: 'CreditTerm'),
          ) );});
    }
  custAddress1TxtFld(Bloc bloc)
  {
    TextEditingController _controller = new TextEditingController();
    return StreamBuilder<String>(
      stream: bloc.custaddress1,
      builder:(context,snapshot){
        if(snapshot.hasData)
            {_controller.value = _controller.value.copyWith(text: snapshot.data.toString());}
      return SizedBox(width: 300.0,
        child: TextField(maxLines: 1,
        onChanged: bloc.custadress1Change,
        controller: _controller, 
        decoration: InputDecoration(
          labelText: 'Address 1'),) );});
    }
  custAddress2TxtFld(Bloc bloc)
  {
       TextEditingController _controller = new TextEditingController();  
  
        return StreamBuilder<String>(
        stream: bloc.custaddress2,
        builder:(context,snapshot){
          if(snapshot.hasData)
                    {_controller.value = _controller.value.copyWith(text: snapshot.data.toString());}
       return SizedBox(width: 300.0,
        child: TextField(maxLines: 1,
        onChanged: bloc.custadress2Change,
        controller: _controller, 
        decoration: InputDecoration(     
        labelText: 'Address 2'),) );});
  }
custCityTxtFld(Bloc bloc)
 {
   TextEditingController _controller = new TextEditingController();  
              return StreamBuilder<String>(
              stream: bloc.custcity,
              builder:(context,snapshot){
                if(snapshot.hasData)
            {_controller.value = _controller.value.copyWith(text: snapshot.data.toString());}
             return SizedBox(width: 150.0,
              child: TextField(
                onChanged: bloc.custcityChange,
                controller: _controller, 
                decoration: InputDecoration(labelText: 'City / District'),) );});
}
  custStateTxtFld(Bloc bloc)
  { 
      TextEditingController _controller = new TextEditingController();
      return StreamBuilder<String>(
      stream: bloc.custstate,
      builder:(context,snapshot){
        if(snapshot.hasData)
            {_controller.value = _controller.value.copyWith(text: snapshot.data.toString());}
      return SizedBox(width: 150.0,
      child: TextField(
        onChanged: bloc.custstateChange,
        controller: _controller, 
        decoration: InputDecoration(
          errorText: snapshot.error,
        labelText: 'State'),) );});
  }
  custCountiesTxtFld(Bloc bloc) {  
    // SupplierApiProvider supApi = new SupplierApiProvider();

        return StreamBuilder(
                            stream: bloc.custcountry,
                            builder: (context, snapshot){
                            return StreamBuilder(
                            stream: bloc.initCountries,
                            builder:(context, country)
                            {
                              if (country.hasData){
                              return SizedBox(width: 300,child:InputDecorator(
                                decoration: InputDecoration(
                                   errorText: snapshot.error,
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
                                  onChanged: bloc.custcountryChange,
                                  hint: Text('Country Name'),
                                  isExpanded: true,elevation: 8,
                                  ) ) ));}
                                    else{return CircularProgressIndicator();}
                                }
                              );}
                            );}

custZipTxtFld(Bloc bloc)
 {
   TextEditingController _controller = new TextEditingController();
   return StreamBuilder<String>(
      stream: bloc.custzipCode,
      builder:(context,snapshot){
        if(snapshot.hasData)
            {_controller.value = _controller.value.copyWith(text: snapshot.data.toString());}
        return SizedBox(width: 300.0,
      child: TextField(
        onChanged: bloc.custzipCodeChange,
        controller: _controller,
        keyboardType: TextInputType.numberWithOptions(),
        decoration: InputDecoration(labelText: 'ZIP Code'),) );});
}
  custPhoneNumTxtFld(Bloc bloc)
  {  
    TextEditingController _controller = new TextEditingController();  
    return StreamBuilder<String>(
    stream: bloc.custphoneNum,
    builder:(context,snapshot){
       if(snapshot.hasData)
            {_controller.value = _controller.value.copyWith(text: snapshot.data.toString());}
    return SizedBox(width: 300.0,
    child: TextField(
      onChanged: bloc.custphoneNumChange,
      controller: _controller,
      keyboardType: TextInputType.numberWithOptions(),
      decoration: InputDecoration(labelText:'Phone No.'),) );});
  }
  custFaxNumTxtFld(Bloc bloc)
  {
    TextEditingController _controller = new TextEditingController();  
      return StreamBuilder<String>(
        stream: bloc.custfaxNum,
        builder:(context,snapshot){
           if(snapshot.hasData)
            {_controller.value = _controller.value.copyWith(text: snapshot.data.toString());}
        return  SizedBox(width: 300.0,
        child: TextField(
          onChanged: bloc.custfaxNumChange,
          controller: _controller,
          keyboardType: TextInputType.numberWithOptions(), 
          decoration: InputDecoration(labelText: 'Fax'),
        ) 
      );
    }
  );
  }
  custEmailTxtFld(Bloc bloc)
  {
        TextEditingController _controller = new TextEditingController();  
          return StreamBuilder<String>(
          stream: bloc.custemailAdr,
          builder:(context,snapshot){
            if(snapshot.hasData)
            {_controller.value = _controller.value.copyWith(text: snapshot.data.toString());}
            return   SizedBox(width: 300.0,
            child: TextField(
              onChanged: bloc.custemailAddChange,
              controller: _controller,
              keyboardType: TextInputType.emailAddress, 
              decoration: InputDecoration(labelText:'Email'),
              )
            );
          }
        );
  }


Widget saveFlatbtn(BuildContext context, Bloc bloc,Users loginInfo)
{    CustomerApiProvider custApi = new CustomerApiProvider();
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
                Customer saveCustDtls = new Customer();    
                saveCustDtls = bloc.saveCustomerDtls();
                await custApi.saveCustomerList(saveCustDtls).then((onValue){
                    if(onValue == true){
                      bloc.clearCustomer();
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> CustomerList(loginInfo: loginInfo,)));
                    }else {return  Exception('Failed to Save Customer List');}}
                    );
              },
            ),
            ],
          ),
        );
}