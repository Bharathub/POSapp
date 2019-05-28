import 'package:flutter/material.dart';
import 'package:split/Bloc/Bloc.dart';
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
      title: 'Login me In!',
      home: Scaffold(
        //body: LoginScreen()
        body: MyHomePage()
        //body: TabsViewBar(),
        //body: PregateIn(),
      ),
    )
    );
  }
  
  // build(context ) {
  //   Provider()
  //   return new MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     home: new MyHomePage(),

  //     );
  // }
}

class MyHomePage extends StatefulWidget
{
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  //  final MyHomePage homePage;
  LoginUserInfo message = new LoginUserInfo();
  LoginApi loginApi = new LoginApi();
  // nextpage(BuildContext context){
  // }
   //final bloc = Bloc();
 @override
  Widget build(BuildContext context){
    var bloc = Provider.of(context);
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
      txtField(bloc),
      pwdField(bloc),
      SizedBox(
      height: 20.0,),

    Container(
      alignment: Alignment(1.0, 0.0),
      padding: EdgeInsets.only(top: 15.0, left: 20.0),
      child: InkWell(
      onTap: () {},
      child: Text(
      'Forgot Password',
      style: TextStyle(
      color: Colors.green,
      fontWeight: FontWeight.bold,
      fontFamily: 'Montserrat',
      decoration: TextDecoration.underline),
        ),
      ),
    ),
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
      } else {  return Exception('Login Failed');} });
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
      stream: bloc.email,builder:(context,snapshot)=>
      TextField(
      onChanged: bloc.emailChanged,
      decoration: InputDecoration(
      errorText: snapshot.error,
      labelText: 'Email',
      labelStyle: TextStyle(
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.bold,
      color: Colors.grey),
      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)),),),);
  }

  pwdField(Bloc bloc) 
  {
    return StreamBuilder<String>(
      stream: bloc.password,  builder:(context,snapshot)=>
      TextField(
      onChanged: bloc.passwordChanged,
      obscureText: true,
      decoration: InputDecoration(
      errorText: snapshot.error,
      labelText: 'Password',
      labelStyle: TextStyle(
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.bold,
      color: Colors.grey),
      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)),),),);
  }

  lblField(String lblTxt, double txtSize, Color txtColor){
    return Text(lblTxt, style: txtStyle(txtSize, txtColor));
    }