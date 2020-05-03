import 'package:flutter/material.dart';


class HomePapge extends StatefulWidget {
  HomePapge({Key key}) : super(key: key);

  @override
  _HomePapgeState createState() => _HomePapgeState();
}

class _HomePapgeState extends State<HomePapge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(
         child: Text("Home"),
       ),
    );
  }
}