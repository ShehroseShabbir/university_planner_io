import 'package:flutter/material.dart';
import 'package:university_planner/root_page.dart';
import 'package:university_planner/auth_provider.dart';
import 'auth.dart';

//import 'package:firebase_auth/firebase_auth.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthProvider(
      auth: Auth(),
          child: new MaterialApp(
          home: new RootPage(),
          theme: new ThemeData(primarySwatch: Colors.green)),
    );
  }
}

