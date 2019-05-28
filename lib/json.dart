// import 'dart:convert';
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:split/src/Models/loginmodel.dart';

// void main() => runApp(new FetchBranchList());

// class FetchBranchList extends StatefulWidget {
//      final Users loginInfo;
//   FetchBranchList({Key key, @required this.loginInfo}) :super(key: key);



  
//   @override
//   _FetchBranchListState createState() => _FetchBranchListState();
// }

// class _FetchBranchListState extends State<FetchBranchList> {
//   Future<List<Branch>> fetchListUser() async {
//     final response = await http.get(
//         'http://dmsapi.logiconglobal.com/api/master/branch/branchlist/sct');
//     if (response.statusCode == 200) {
//       print(response.body);
//       List users = json.decode(response.body);
//       return users.map((user) => new Branch.fromJson(user)).toList();
//     } else
//       throw Exception('Failed to load Branch');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: FutureBuilder<List<Branch>>(
//             future: fetchListUser(),
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 List<Branch> users = snapshot.data;
//                 return new ListView(
//                   children: users
//                       .map((user) => Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               Text('Branch ID:${user.branchID}'),
//                               Text('Branch Code:${user.branchCode}'),
//                               Text('Branch Name:${user.branchName}'),
//                               Text('Company Name:${user.companyCode}'),
//                             ],
//                           ))
//                       .toList(),
//                 );
//               } else if (snapshot.hasError) {
//                 return Text('${snapshot.error}');
//               }
//               return new CircularProgressIndicator();
//             }),
//       ),
//     );
//   }
// }

// class Branch {
//   final int branchID;
//   final String branchCode, branchName, companyCode;

//   Branch({this.branchID, this.branchCode, this.branchName, this.companyCode});

//   factory Branch.fromJson(Map<String, dynamic> json) {
//     return Branch(
//         branchID: json['branchID'],
//         branchCode: json['branchCode'],
//         branchName: json['branchName'],
//         companyCode: json['companyCode']);
//   }
// }
