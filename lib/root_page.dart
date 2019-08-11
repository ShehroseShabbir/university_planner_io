import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:university_planner/auth_provider.dart';
import 'package:university_planner/auth.dart';
import 'package:university_planner/login.dart';
import 'package:university_planner/home_page.dart';


class RootPage extends StatelessWidget {
    @override
  Widget build(BuildContext context) {
    final BaseAuth auth = AuthProvider.of(context).auth;
    return StreamBuilder<String>(
      stream: auth.onAuthStateChanged,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot){
        if(snapshot.connectionState == ConnectionState.active) {
          if(snapshot.error != null)
          {
            print('error');
            return Text(snapshot.error.toString());
          }
          final bool isLoggedIn = snapshot.hasData;
          if(isLoggedIn == true)
          {
            return new FutureBuilder<FirebaseUser>(
              future: auth.getUser(),
              builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot)
              {
                if(snapshot.connectionState == ConnectionState.done)
                {
                     return HomePage(snapshot.data);
                }
               return LoginPage();
              }
            );
            
            //isLoggedIn ? HomePage(user) : LoginPage();
          }
        }
          return LoginPage();//Text('${snapshot.data}');
      }
    );
    /*FutureBuilder<FirebaseUser>(
      future: auth.getUser(),
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot){
        if(snapshot.connectionState == ConnectionState.active)
        {
          if(snapshot.error != null)
          {
            print('error');
            return Text(snapshot.error.toString());
          }
          final bool isLoggedIn = snapshot.hasData;
           return isLoggedIn ? HomePage() : LoginPage();
         
        }
        else if(snapshot.connectionState == ConnectionState.done)
        {
         final bool isLoggedIn = snapshot.hasData;
          return isLoggedIn ? HomePage(snapshot.data) : LoginPage();
        }

        return Text("Waiting for connection.");
        
      }
    );*/
    
    /**/
    }    
} 