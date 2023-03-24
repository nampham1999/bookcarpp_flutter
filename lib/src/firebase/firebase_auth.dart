import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FireAuth {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void signUp(String name, String phone, String email, String pass,
      Function onSucess, Function onRegisterErr) {
    _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((user) {
      _createUser(
          user.user!.uid, name, phone, email, pass, onSucess, onRegisterErr);
      print(user);
      // print(user.user.pass);
    }).catchError((err) {
      _onSignUpErr(err.code, onRegisterErr);
    });
  }

  _createUser(String userId, String name, String phone, String email,
      String pass, Function onSucess, Function onRegisterErr) {
    var user = {"name": name, "phone": phone, "email": email, "pass": pass};
    // ignore: deprecated_member_use
    var ref = FirebaseDatabase.instance.reference().child('users');
    ref.child(userId).set(user).then((user) {
      onSucess();
    }).catchError((onError) {
      onRegisterErr(onError);
    });
  }

  Future<User> handleSignInEmail(String email, String password) async {
    UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    final User user = result.user!;

    return user;
  }

  SignIn(
      String email, String password, Function onSucess, Function onSignInErr) {
    _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((user) {
      print(user.user);
      onSucess();
    }).catchError((e) {
      print(email + password);
      onSignInErr('Sign In Fail, please try again');
    });
  }
}

void _onSignUpErr(String code, Function onRegisterErr) {
  switch (code) {
    case "ERROR_INVALID_EMAIL":
    case "ERROR_INVALID_CREDENTIAL":
      onRegisterErr('Invalid email');
      break;
    case "ERROR_INVALID_ALREADY_IN_USE":
      onRegisterErr('email existed');
      break;
    case "ERROR_WEAK_PASSWORD":
      onRegisterErr('Password is not strong');
      break;
    default:
      onRegisterErr('Signup fail, please try again');
      break;
  }
}
