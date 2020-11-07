import 'package:firebase_auth/firebase_auth.dart';
import 'package:w8/models/user.dart';
import 'package:w8/services/database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create custom user 

  CustomUser _userFromFireBaseUser(User user) {
    return (user != null) ? CustomUser(uid: user.uid) : null ;
  }

  //auth change user stream
  Stream<CustomUser> get user {
    return _auth.onAuthStateChanged
    .map((User user) => _userFromFireBaseUser(user));
  }

  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user; //User class from FireBase
      return _userFromFireBaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }


  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      // print(user);

      //create a new document for the user with the uid

      return _userFromFireBaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }

  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      // print(user);
      dynamic hey = await DatabaseService(uid: user.uid).updateUserData('0', 'New Anonym' , 100);
      print('here');
      print(hey);
      return _userFromFireBaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }

  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }


}