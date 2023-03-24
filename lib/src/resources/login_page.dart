import 'package:book_car_app/src/app.dart';
import 'package:book_car_app/src/blocs/auth_bloc.dart';
import 'package:book_car_app/src/resources/bottomtab.dart';
import 'package:book_car_app/src/resources/carousel.dart';
import 'package:book_car_app/src/resources/dialog/loading_dialog.dart';
import 'package:book_car_app/src/resources/dialog/msg_dialog.dart';
import 'package:book_car_app/src/resources/home_page.dart';
import 'package:book_car_app/src/resources/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  void _onClick() {
    String email = _emailController.text;
    String pass = _passController.text;
    var authBloc = MyApp.of(context)?.authBloc;
    // LoadingDialog.showLoadingDialog(context, 'Loading...');
    // authBloc!.signIn(email, pass, (msg) {
    //   LoadingDialog.hideLoadingDialog(context);
    //   MsgDialog.showMsgDialog(context, 'Sucess', msg);
    // }, (msg) {
    //   LoadingDialog.hideLoadingDialog(context);
    //   MsgDialog.showMsgDialog(context, 'Sign In', msg);
    // });
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => BottomNavBar()));
  }

  void initState() {
    super.initState();
    initialization();
  }

  void initialization() {
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
        constraints: const BoxConstraints.expand(),
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: SingleChildScrollView(
              child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              Image.asset('ic_car_green.png'),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
                child: Text(
                  'Welcome back!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              const Text('Login to continue using iCab'),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                child: StreamBuilder(
                    builder: (context, snapshot) => TextField(
                          controller: _emailController,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.0),
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 3.0)),
                            prefixIcon: const Icon(Icons.email_outlined),
                          ),
                        )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: TextField(
                  controller: _passController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                        onTap: () {}, child: const Text('Forgot password?')),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xff3277D8)),
                        ),
                        onPressed: () {
                          _onClick();
                        },
                        child: const Text('Log In'))),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                      child: Text('New User?'),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignupPage()));
                      },
                      child: const Text(
                        'Sign up for a new account',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.blue),
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
