import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  State createState() => new LoginPageState();
}

enum FormType{
  login,
  register
}

class LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final formKey = new GlobalKey<
      FormState>(); // FormKey for validation and saving data on StateChange

  String _username; // Student ID
  String _password; // Password
  FormType _formType = FormType.login;

// Validation Entered Credentials.
  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
    }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        AuthResult result = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _username, password: _password);
        FirebaseUser user = result.user;
        print('Signed in: ${user.uid}');
      }
      catch (e) {
        print('Error: $e');
      }
    }
  }

  void moveToRegister(){
    setState(() {
      _formType = FormType.register;
    });
  }

  AnimationController _iconAnimationController;
  Animation<double> _iconAnimation;

  @override
  void initState() {
    super.initState();
    _iconAnimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 500));
    _iconAnimation = new CurvedAnimation(
      parent: _iconAnimationController,
      curve: Curves.easeOut,
    );
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: Colors.greenAccent,
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Image(
            image: new AssetImage("assets/background.jpg"),
            fit: BoxFit.cover,
            color: Colors.black54,
            colorBlendMode: BlendMode.darken,
          ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new FlutterLogo(
                size: _iconAnimation.value * 100,
              ),
              new Form(
                key: formKey,
                child: new Theme(
                  data: new ThemeData(
                      brightness: Brightness.dark,
                      primarySwatch: Colors.teal,
                      inputDecorationTheme: new InputDecorationTheme(
                          labelStyle: new TextStyle(
                              color: Colors.teal, fontSize: 20.0))),
                  child: Container(
                    padding: const EdgeInsets.all(50.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: buildInputs() + buildSubmitButton(),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  List<Widget> buildInputs(){
    return[
      new TextFormField(
        validator: (value) => value.isEmpty ? 'Student ID cannot be empty.' : null,
        onSaved: (value) => _username = value,
        decoration:
        new InputDecoration(labelText: 'Enter Student ID', icon: new Icon(Icons.mail,)),
        keyboardType: TextInputType.text,
      ),

      new TextFormField(
        onSaved: (value) => _password = value,
        validator: (value) => value.isEmpty ? 'Password cannot be left blank.' : null,
        decoration: new InputDecoration(labelText: 'Enter Password', icon: new Icon(Icons.lock,)),
        keyboardType: TextInputType.text,
        obscureText: true,
      ),
    ];
  }

  List<Widget> buildSubmitButton()
  {
    return[
      new Row(
        children: <Widget>[
          new MaterialButton
            (
            height: 40.0,
            shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.teal,
            textColor: Colors.white,
            child: new Text("Sign in"),
            onPressed: validateAndSubmit,
            splashColor: Colors.redAccent,
          ),


      new FlatButton(
        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
        color: Colors.teal,
        textColor: Colors.white,
        child: new Text("Register Now"),
        onPressed: moveToRegister,

      )
        ],
      ),
    ];



  }

}

