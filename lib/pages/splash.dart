import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socket/api/auth_api.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  final _authAPI = AuthAPI();
  @override
  void initState() {
    super.initState();
    this.check();
  }

  check()async{
    final token = await _authAPI.getAccessToken();

    if(token != null){
      Navigator.pushReplacementNamed(context, 'home');
    }
    else{
      Navigator.pushReplacementNamed(context, 'login');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CupertinoActivityIndicator(radius: 15,)
      ),
    );
  }
}