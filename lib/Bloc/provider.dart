import 'package:flutter/material.dart';
import 'package:split/Bloc/Bloc.dart';
import 'package:split/Bloc/InitBloc.dart';

class Provider extends InheritedWidget
{
  final bloc = Bloc();
  Provider({Key key,Widget child}) : super(key: key,child: child);

  bool updateShouldNotify(_) => true;

  static Bloc of(BuildContext context)
  {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider).bloc;
  }
}

class InitProvider extends InheritedWidget
{
  final initbloc = InitiateBloc();

  InitProvider({Key key,Widget child}) :super(key:key, child: child);

  bool updateShouldNotify(_) => true;

  static InitiateBloc of(BuildContext context)
    {
      return (context.inheritFromWidgetOfExactType(InitProvider) as InitProvider).initbloc;    
    }
}

// // class GateInProvider extends InheritedWidget
// // {
// //   final preGateinbloc = PreGateInBloc();

// //   GateInProvider({Key key, Widget child}) :super(key:key,child:child);

// //   bool updateShouldNotify(_) => true;

// //   static PreGateInBloc of(BuildContext context)
// //   {
// //     return (context.inheritFromWidgetOfExactType(GateInProvider) as GateInProvider).preGateinbloc;
// //   }

// // }