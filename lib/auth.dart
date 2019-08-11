import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

abstract class BaseAuth {
  Stream<String> get onAuthStateChanged;
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<String> createUserWithEmailAndPassword(String email, String password);
  Future<String> currentUser();
  Future<FirebaseUser> getUser();
  Future<void> signOut();
}

class Auth implements BaseAuth
{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Stream<String> get onAuthStateChanged
  {
    return _firebaseAuth.onAuthStateChanged.map((FirebaseUser user) => user?.uid);
  }
  Future<String> signInWithEmailAndPassword(String email, String password) async
  {
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
    return user?.uid;
  }

  Future<String> createUserWithEmailAndPassword(String email, String password) async{
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
    return user?.uid;
  }

  Future<String> currentUser() async{
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user?.uid;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

Future<FirebaseUser> getUser() {
  return _firebaseAuth.currentUser();
}
}
