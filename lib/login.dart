import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  State createState() => new LoginPageState();
}

enum FormType { login, register }

class LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final formKey = new GlobalKey<
      FormState>(); // FormKey for validation and saving data on StateChange

  String _username; // Student ID
  String _password; // Password
  FormType _formType = FormType.login;

  // Password Eye Button
  Color _eyeButtonColor = Colors.grey;
  bool _isObscured = true;

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
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  void moveToRegister() {
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin(){
    setState((){
      _formType = FormType.login;
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
          buildBackgroundImage(),
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
                              color: Colors.white, fontSize: 20.0))),
                  child: Container(
                    padding: const EdgeInsets.all(50.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
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

  Image buildBackgroundImage() {
    return new Image(
      image: new AssetImage("assets/background.jpg"),
      fit: BoxFit.cover,
      color: Colors.black87,
      colorBlendMode: BlendMode.darken,
    );
  }

  List<Widget> buildInputs() {
    return [
      new TextFormField(
        validator: (value) =>
            value.isEmpty ? 'Email ID cannot be empty.' : null,
        onSaved: (value) => _username = value,
        decoration: new InputDecoration(
            labelText: 'Enter Email Address',
            suffixIcon: IconButton(
              onPressed: null,
              icon: Icon(Icons.mail),
            )),
        keyboardType: TextInputType.text,
      ),
      new TextFormField(
        onSaved: (value) => _password = value,
        validator: (value) =>
            value.isEmpty ? 'Password cannot be left blank.' : null,
        decoration: new InputDecoration(
            labelText: 'Enter Password',
            suffixIcon: IconButton(
              onPressed: () {
                if (_isObscured) {
                  setState(() {
                    _isObscured = false;
                    _eyeButtonColor = Theme.of(context).primaryColor;
                  });
                } else {
                  setState(() {
                    _isObscured = true;
                    _eyeButtonColor = Colors.grey;
                  });
                }
              },
              icon: Icon(Icons.remove_red_eye),
            )),
        keyboardType: TextInputType.text,
        obscureText: _isObscured,
      ),
    ];
  }

  List<Widget> buildSubmitButton() {
    if(_formType == FormType.login)
      {
        return [
          Padding(
            padding: const EdgeInsets.only(top: 1.0),
            child: Align(
              alignment: Alignment.centerRight,
              //child: Text("Don't have an account?", style: TextStyle(color: Colors.green),),
              child: FlatButton(
                  onPressed: moveToRegister,
                  child: Text(
                    "Dont have an account?",
                    style: TextStyle(color: Colors.green),
                  )),
            ),
          ),
          SizedBox(
            height: 80.0,
          ),
          Align(
            child: SizedBox(
              height: 40.0,
              width: 250.0,
              child: MaterialButton(
                onPressed: validateAndSubmit,
                splashColor: Colors.green[500],
                color: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                child:
                Text('Login', style: Theme.of(context).primaryTextTheme.button),
              ),
            ),
          )
        ];
      }
    else
      {
        return [
          /*Padding(
            padding: const EdgeInsets.only(top: 1.0),
            child: Align(
              alignment: Alignment.centerRight,
              //child: Text("Don't have an account?", style: TextStyle(color: Colors.green),),
              child: FlatButton(
                  onPressed: moveToRegister,
                  child: Text(
                    "Dont have an account?",
                    style: TextStyle(color: Colors.green),
                  )),
            ),
          ),*/
          SizedBox(
            height: 40.0,
          ),
          Align(
            child: SizedBox(
              height: 40.0,
              width: 250.0,
              child: MaterialButton(
                onPressed: moveToRegister,
                splashColor: Colors.green[500],
                color: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                child:
                Text('Register Now', style: Theme
                    .of(context)
                    .primaryTextTheme
                    .button),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Align(
            child: SizedBox(
              height: 40.0,
              width: 250.0,
              child: MaterialButton(
                onPressed: moveToLogin,
                splashColor: Colors.green[500],
                color: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                child:
                Text('Back To Login', style: Theme.of(context).primaryTextTheme.button),
              ),
            ),
          )
        ];
      }

  }
}
