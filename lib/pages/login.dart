import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:socket/api/auth_api.dart';
import 'package:socket/pages/home.dart';
import 'package:socket/utils/responsive.dart';
import 'package:socket/widgets/circle.dart';
import 'package:socket/widgets/input_text..dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  var _email= '', _password='';
  final _authAPI = AuthAPI();
  final _formKey = GlobalKey<FormState>();
  var _isFetching = false;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  _submit() async {

   if(_isFetching) return;  

  final isValid = _formKey.currentState.validate();
  if(isValid){
    setState(() {
      _isFetching = true;
    });
    final isOk = await _authAPI.login(context, email: _email, password: _password);
    setState(() {
      _isFetching = false;
    });
    if(isOk){
      print('Login Ok');
      Navigator.pushNamed(context, 'home');
    }
  }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
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
                              width: responsive.wp(25),
                              height: responsive.hp(25),
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
                              height: responsive.hp(4),
                            ),
                            Text(
                              'hello hello \n hello hello',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: responsive.ip(2), fontWeight: FontWeight.w300),
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
                                      inputType: TextInputType.emailAddress,
                                      fontSize: responsive.ip(1.8),
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
                                      height: responsive.hp(3),
                                    ),
                                    InputText(
                                      isSecure: true,
                                      fontSize: responsive.ip(1.8),
                                      label: "PASSWORD",
                                      validaor: (String text) {
                                        if (text.isNotEmpty &&
                                            text.length > 5) {
                                              _password=text;
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
                              height: responsive.hp(4),
                            ),
                            ConstrainedBox(
                              constraints:
                                  BoxConstraints(maxWidth: 350, minWidth: 350),
                              child: CupertinoButton(
                                padding: EdgeInsets.symmetric(vertical: responsive.ip(2)),
                                color: Colors.pinkAccent,
                                borderRadius: BorderRadius.circular(5),
                                onPressed: () => _submit(),
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(fontSize: responsive.ip(2.5)),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: responsive.hp(5),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'lorem lorem lorem',
                                  style: TextStyle(
                                      fontSize: responsive.ip(1.8), color: Colors.black54),
                                ),
                                CupertinoButton(
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        fontSize: responsive.ip(1.8), color: Colors.pinkAccent),
                                  ),
                                  onPressed: () => Navigator.pushNamed(context, "signup"),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: responsive.hp(1),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
             _isFetching? Positioned.fill(child: Container(
                color: Colors.black45,
                child: Center(
                  child: CupertinoActivityIndicator(radius: 15,)
                ),
              ),):Container()
            ],
          ),
        ),
      ),
    );
  }
}
