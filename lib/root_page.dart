import 'package:flutter/material.dart';
import 'auth.dart';
import 'login.dart';
import 'home_page.dart';

class RootPage extends StatefulWidget {
  RootPage({this.auth});
  final BaseAuth auth;
  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

enum AuthStatus
{
  notSignedin,
  signedIn
}


class _RootPageState extends State<RootPage>
{
  AuthStatus authStatus = AuthStatus.notSignedin;


  initState()
  {
    super.initState();
    widget.auth.currentUser().then((userId) {
      setState((){
        //authStatus = userId == null ? AuthStatus.notSignedin : AuthStatus.signedIn;
      });
    });
  }

  void _signedIn()
  {
    setState((){
      authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut()
  {
    setState((){
      authStatus =  AuthStatus.notSignedin;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notSignedin:
        return new LoginPage(
            auth: widget.auth,
            onSignedIn: _signedIn,
        );
      case AuthStatus.signedIn:
        return new HomePage(
          auth: widget.auth,
          onSignedOut: _signedOut,
        );

    }
}
}