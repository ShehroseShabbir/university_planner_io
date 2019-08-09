import 'package:flutter/material.dart';
import 'auth.dart';
import 'root_page.dart';
//import 'package:firebase_auth/firebase_auth.dart';


void main() => runApp(new myApp());

class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new RootPage(auth: new Auth()),
        theme: new ThemeData(primarySwatch: Colors.green));
  }
}

