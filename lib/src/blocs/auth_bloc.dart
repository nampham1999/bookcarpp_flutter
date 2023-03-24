import 'dart:async';

import 'package:book_car_app/src/firebase/firebase_auth.dart';

class AuthBloc {
  final StreamController _nameController = StreamController();
  final StreamController _phoneController = StreamController();
  final StreamController _emailController = StreamController();
  final StreamController _passController = StreamController();

  Stream get nameStream => _nameController.stream;
  Stream get phoneStream => _phoneController.stream;
  Stream get emailStream => _emailController.stream;
  Stream get passStream => _passController.stream;

  bool isValid(String name, String phone, String email, String pass) {
    if (name == null || name.length == 0) {
      _nameController.sink.addError('Nhập tên');
      return false;
    }
    _nameController.sink.add('');
    if (phone == null || phone.length != 10) {
      _phoneController.sink.addError('Nhập sdt');
      return false;
    }
    _phoneController.sink.add('');
    if (email == null || email.length == 0) {
      _emailController.sink.addError('Nhập email');
      return false;
    }
    _emailController.sink.add('');
    if (pass == null || pass.length < 6) {
      _passController.sink.addError('Nhập pass');
      return false;
    }
    _passController.sink.add('');
    return true;
  }

  void signUp(String name, String phone, String email, String pass,
      Function onSucess, Function onRegisterErr) {
    FireAuth().signUp(name, phone, email, pass, onSucess, onRegisterErr);
  }

  void signIn(
      String email, String pass, Function onSucess, Function onSignInErr) {
    FireAuth().SignIn(email, pass, onSucess, onSignInErr);
  }

  void handleSignIn(
    String email,
    String pass,
  ) async {
    await FireAuth().handleSignInEmail(email, pass);
  }

  void dispose() {
    _nameController.close();
    _phoneController.close();
    _emailController.close();
    _passController.close();
  }

  void handleSignInEmail(String email, String pass) {}
}
