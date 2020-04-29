import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:socket/api/auth_api.dart';
import 'package:socket/widgets/circle.dart';
import 'package:socket/widgets/input_text..dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  final _authAPI = AuthAPI();
  var _username = '', _email= '', _password='';

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  _submit() async {
    final isValid =
    _formKey.currentState.validate();
    if(isValid){
     final isOk = await _authAPI.register(username:_username,email: _email,password: _password);
     if(isOk){
       print('Register');
     }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          width: size.width,
          height: size.height,
          child: Stack(
            children: <Widget>[
              Positioned(
                right: -size.width * 0.22,
                top: -size.width * 0.36,
                child: Circle(
                  radius: size.width * 0.45,
                  colors: [
                    Colors.pink,
                    Colors.pinkAccent,
                  ],
                ),
              ),
              Positioned(
                left: -size.width * 0.15,
                top: -size.width * 0.34,
                child: Circle(
                  radius: size.width * 0.35,
                  colors: [
                    Colors.orange,
                    Colors.deepOrange,
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  width: size.width,
                  height: size.height,
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: <Widget>[
                            Container(
                              width: 90,
                              height: 90,
                              margin: EdgeInsets.only(top: size.width * 0.3),
                              //color: Colors.white,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black26, blurRadius: 20)
                                  ]),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'hello hello \n hello hello',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w300),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            ConstrainedBox(
                              constraints:
                                  BoxConstraints(maxWidth: 350, minWidth: 350),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: <Widget>[
                                    InputText(
                                      label: "USERNAME",
                                      validaor: (String text) {
                                        if (RegExp(r'^[a-zA-Z0-9]+$').hasMatch(text)) {
                                          _username=text;
                                          return null;
                                        }
                                        return "invalid Username";
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    InputText(
                                      inputType: TextInputType.emailAddress,
                                      label: "MAIL ADDRESS",
                                      validaor: (String text) {
                                        if (text.contains('@')) {
                                          _email=text;
                                          return null;
                                        }
                                        return "invalid Email";
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    InputText(
                                      isSecure: true,
                                      label: "PASSWORD",
                                      validaor: (String text) {
                                        if (text.isNotEmpty &&
                                            text.length > 5) {
                                              _password = text;
                                          return null;
                                        }
                                        return "invalid password";
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            ConstrainedBox(
                              constraints:
                                  BoxConstraints(maxWidth: 350, minWidth: 350),
                              child: CupertinoButton(
                                padding: EdgeInsets.symmetric(vertical: 17),
                                color: Colors.pinkAccent,
                                borderRadius: BorderRadius.circular(5),
                                onPressed: () => _submit(),
                                child: Text(
                                  'Sign up',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Already have an account?',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black54),
                                ),
                                CupertinoButton(
                                  child: Text(
                                    'Sign In',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.pinkAccent),
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.08,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 15,
                top: 5,
                child: SafeArea(
                  child: CupertinoButton(
                      padding: EdgeInsets.all(10),
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black12,
                      onPressed: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
