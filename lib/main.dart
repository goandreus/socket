import 'package:flutter/material.dart';
import 'package:socket/pages/login.dart';
import 'package:socket/pages/sign_up.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
      
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      routes: {
        'login' : (context)=>LoginPage(),
        'signup': (context)=>SignUpPage(),
      },
    );
  }
}


