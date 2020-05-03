import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart' show required;
import 'package:socket/utils/dialogs.dart';
import '../app_config.dart';
import 'package:http/http.dart' as http;
import 'package:socket/utils/session.dart';

class AuthAPI{

  final _session = Session();

  Future<bool> register(BuildContext context,{@required String username, @required String email, @required String password}) async {
    final url = "${AppConfig.apiHost}/register";

    try{

      final response = await http.post(url,body:{
      "username":username,
      "email":email,
      "password":password
    });

    //final responseString = response.body;
    final parsed = jsonDecode(response.body);

    if(response.statusCode == 200){
     final token = parsed['token'] as String;
     final expiresIn = parsed['expiresIn'] as int;
     print("response 200 ${response.body}");

     //save token

     await _session.set(token, expiresIn);

     return true;
    }
    else if (response.statusCode == 500){
      throw PlatformException(code: "500", message: parsed['message']);
    } 
      throw PlatformException(code: "201", message: parsed['Error /register']);

    }on PlatformException catch(e){
      print("Error ${e.code}:${e.message}");
      Dialogs.alert(context, title: "Error", message: e.message);
      return false;
    }
  }

  Future<bool> login(BuildContext context,{@required String email, @required String password}) async {
    final url = "${AppConfig.apiHost}/login";

    try{

      final response = await http.post(url,body:{
      "email":email,
      "password":password
    });

    //final responseString = response.body;
    final parsed = jsonDecode(response.body);

    if(response.statusCode == 200){
     final token = parsed['token'] as String;
     final expiresIn = parsed['expiresIn'] as int;
     print("response 200 ${response.body}");

     //save token

     await _session.set(token, expiresIn);

     return true;
    }
    else if (response.statusCode == 500){
      throw PlatformException(code: "500", message: parsed['message']);
    } 
      throw PlatformException(code: "201", message: parsed['Error /login']);

    }on PlatformException catch(e){
      print("Error ${e.code}:${e.message}");
      Dialogs.alert(context, title: "Error", message: e.message);
      return false;
    }
  }
}