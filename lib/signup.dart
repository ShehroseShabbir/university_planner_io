import 'package:flutter/material.dart';


class Register extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _RegisterState();
}
  class _RegisterState extends State<Register>
  {
  @override
  Widget build(BuildContext context)
  {
  return new Scaffold
  (
  appBar: new AppBar
  (
  title: new Text("Welcome Shehrose!"),
  ),

  body: new Container
  (
  child: new Text('This is the body container')
  )
  );
  }
  }
