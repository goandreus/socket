import 'package:flutter/material.dart';

class InputText extends StatefulWidget {

  final String label;
  final Function(String) validaor;
  final bool isSecure;

  const InputText({Key key,@required this.label, this.validaor, this.isSecure=false}) : super(key: key);

  @override
  _InputTextState createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.isSecure,
      validator: widget.validaor,
      decoration: InputDecoration(
        labelText: widget.label,
        contentPadding: EdgeInsets.symmetric(vertical:10)
      ),
    );
  }
}