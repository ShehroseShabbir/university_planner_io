import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:university_planner/auth.dart';
import 'package:university_planner/auth_provider.dart';

class HomePage extends StatefulWidget {
final FirebaseUser user;
HomePage(this.user);
  @override
  State createState() => new HomePageState();
}
class HomePageState extends State<HomePage>{
  void _signOut(BuildContext context) async {
    try{
      var auth = AuthProvider.of(context).auth;
      await auth.signOut();
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
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ), 
              currentAccountPicture: CircleAvatar(
                backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
                ? Colors.blue : Colors.white,
                child: Text("S", style: TextStyle(fontSize: 40.0),),
              ),
              accountEmail: Text("${widget.user.email}"),
              accountName: Text("${widget.user.displayName}"),
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
              onTap: () => 
                _signOut(context),
            ),
          ],
        ),
      ),
      appBar: new AppBar(
        title: new Text('Welcome'),
        actions: <Widget>[
          new FlatButton(
              child: new Text('Logout', style: new TextStyle(fontSize: 17.0, color: Colors.white)),
              onPressed: () => _signOut(context)
          )
        ]
      ),
      body: new Container(
        child: new Padding(
          padding: const EdgeInsets.all(40.0),
          child: new Text("Welcome", style: new TextStyle(fontSize: 32.0)),
        ),
      ),
    );
  }
}
