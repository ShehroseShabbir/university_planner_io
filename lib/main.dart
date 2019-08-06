import 'package:flutter/material.dart';
import 'login.dart';
import 'signup.dart';

//import 'package:firebase_auth/firebase_auth.dart';


void main() => runApp(new myApp());

class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new LoginPage(),
        theme: new ThemeData(primarySwatch: Colors.blue));
  }
}

