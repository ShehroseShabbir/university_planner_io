import 'package:flutter/material.dart';
import 'auth.dart';


class HomePage extends StatelessWidget{
  HomePage({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  void _signOut() async {
    try{
      await auth.signOut();
      onSignedOut();
    }
    catch(e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Navigation', style: new TextStyle(fontSize: 28.0),),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('View My Account'),
              onTap: (){
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Courses'),
              onTap: (){
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Calender'),
              onTap: (){
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Logout'),
              onTap: (){
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      appBar: new AppBar(
        title: new Text('Welcome'),
        actions: <Widget>[
          new FlatButton(
              child: new Text('Logout', style: new TextStyle(fontSize: 17.0, color: Colors.white)),
              onPressed: _signOut
          )
        ]
      ),
      body: new Container(
        child: new Center(
          child: new Text("Welcome", style: new TextStyle(fontSize: 32.0)),
        ),
      ),
    );
  }
}