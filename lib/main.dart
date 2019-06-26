//import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import 'package:split/Bloc/Bloc.dart';
import 'package:split/Bloc/CommonVariables.dart';
import 'package:split/appdrawer.dart';
import 'package:split/src/Models/loginmodel.dart';
import 'package:split/Bloc/provider.dart';
import 'src/APIprovider/loginApiprovider.dart';
//import 'package:split/appdrawer.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  build(context) 
  {
    return Provider(
     child: MaterialApp(
      debugShowCheckedModeBanner: false,       
      home: Scaffold(       
      body: MyHomePage()
      ),
     )
    );
  }
}

class MyHomePage extends StatefulWidget
{
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // bool _obscureText = false;
  

  //  final MyHomePage homePage;
  LoginUserInfo message = new LoginUserInfo();
  LoginApi loginApi = new LoginApi();

 @override
  Widget build(BuildContext context){
    var bloc = Provider.of(context);
    bloc.showPassword(true); 
    return new Scaffold(      
      body: new SingleChildScrollView(
      child: Column(children: <Widget>[
      Container(child:Column(
      children: <Widget>[
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2.5,
        decoration: BoxDecoration(
          gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFf45d27), Color(0xFFf5851f)],),
        // borderRadius:BorderRadius.only(bottomLeft: Radius.circular(0.0))
        ),
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
      Spacer(),
      Align(alignment: Alignment.center,child: Icon( Icons.person,size: 90,color: Colors.white,),),
      Spacer(),
      Align(alignment: Alignment.bottomRight,child: Padding( 
      padding: const EdgeInsets.only(bottom: 32, right: 32),
      child: Text('Login',style: TextStyle(color: Colors.white, fontSize: 30),),),),],),
              ),
      SizedBox(
        height: 20.0,
      ),
      Container(
      child: Column(
      children: <Widget>[
      //dateDisplayFld(bloc),
      txtField(bloc),
      pwdField(bloc),
      SizedBox(
      height: 20.0,),

    // Container(
    //   alignment: Alignment(1.0, 0.0),
    //   padding: EdgeInsets.only(top: 15.0, left: 20.0),
    //   child: InkWell(
    //   onTap: () {},
    //   child: Text(
    //   'Forgot Password',
    //   style: TextStyle(
    //   color: Colors.green,
    //   fontWeight: FontWeight.bold,
    //   fontFamily: 'Montserrat',
    //   decoration: TextDecoration.underline),
    //     ),
    //   ),
    // ),
    SizedBox( height: 50.0, width: 100.0,),
    StreamBuilder<bool>(stream: bloc.submitCheck,  builder:(context,snapshot)=> ButtonTheme(
      minWidth: 600.0,
      height: 30.0,
      child: RaisedButton(
      onPressed: () async {
        Users loginuser = new Users();
        loginuser = bloc.getLoginUser();
        await  loginApi.checkUserLogin(loginuser).then((onValue){
        if(onValue == true){
        Navigator.push(context,
        MaterialPageRoute(builder: (context) => AppDrawer(loginInfo: loginuser)));
        } else {  StaticsVar.showAlert(context, "Invalid User Id / Password");} });
      },
      textColor: Colors.white,
      color: Color(0xffd35400),
      padding: const EdgeInsets.all(8.0),
      child: new Text('Login'),
      ), ),
    )
  ],
  ),
  padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 0.0),
                ),
              ])),
        ]),
      ),
    );
  }

  
  txtStyle(double txtSize, Color txtColor) {
    return TextStyle(
      fontSize: txtSize,
      fontFamily: 'Raleway',
      color: txtColor,
                );
  }
  

  txtField(Bloc bloc)
  {
    return StreamBuilder<String>(
      stream: bloc.email,
      builder:(context,snapshot)=>
      TextField(
        onChanged: bloc.emailChanged,
        decoration: InputDecoration(
          errorText: snapshot.error,
          labelText: 'Email',
          suffixIcon: Icon(Icons.email),
          labelStyle: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            color: Colors.grey),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.green)),
        ),
      ),
    );
  }

  pwdField(Bloc bloc) 
  {    
    return StreamBuilder<String>(
      stream: bloc.password,  
      builder:(context,snapshot)
      {
        return StreamBuilder(
          stream: bloc.showPwd, 
          builder:(context,ssShowPwd)
          {        
            return TextField(
              onChanged: bloc.passwordChanged,
              obscureText: ssShowPwd.data == null ? true : ssShowPwd.data,      
              decoration: InputDecoration
              (
                //errorText: snapshot.error,
                labelText: 'Password',
                suffixIcon: IconButton(icon: Icon(ssShowPwd.data == null ? Icons.visibility_off : (ssShowPwd.data ? Icons.visibility_off : Icons.visibility)), onPressed: (){
                  bloc.showPassword(ssShowPwd.data == null ? false : !ssShowPwd.data);        
                },),                      
                labelStyle: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: Colors.grey),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)),
              ),
            );
          });
        }
      );
  }

  lblField(String lblTxt, double txtSize, Color txtColor){
    return Text(lblTxt, style: txtStyle(txtSize, txtColor));
  }

  // dateDisplayFld(Bloc bloc)
  // {
  //   return StreamBuilder(
  //     stream: bloc.unBilldDateFrom,
  //     builder: (context, ssDate)
  //     {
  //       return DateTimePickerFormField(
  //         format: DateFormat('dd-MM-yyyy'),
  //         //dateOnly: true,
  //         decoration: const InputDecoration(
  //           labelText: "Testing Date",
  //         ),
  //         onChanged: bloc.unBilldDateFormChanged,
  //       );
  //     }
  //   );
  // }

}
