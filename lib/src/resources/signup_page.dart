import 'package:book_car_app/src/blocs/auth_bloc.dart';
import 'package:book_car_app/src/resources/dialog/loading_dialog.dart';
import 'package:book_car_app/src/resources/dialog/msg_dialog.dart';
import 'package:book_car_app/src/resources/login_page.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  AuthBloc bloc = AuthBloc();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  void Signup() {
    if (bloc.isValid(_nameController.text, _phoneController.text,
        _emailController.text, _passController.text)) {
      LoadingDialog.showLoadingDialog(context, 'loading...');
      bloc.signUp(_nameController.text, _phoneController.text,
          _emailController.text, _passController.text, () {
        LoadingDialog.hideLoadingDialog(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      }, (msg) {
        LoadingDialog.hideLoadingDialog(context);
        MsgDialog.showMsgDialog(context, 'Sign Up', msg);
      });
    }
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
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
                height: 50,
              ),
              Image.asset('ic_car_red.png'),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 40, 0, 5),
                child: Text(
                  'Welcome Aboard!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              const Text('Signup with iCab in simple steps'),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
                child: StreamBuilder(
                  stream: bloc.nameStream,
                  builder: (context, snapshot) => TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        errorText: snapshot.hasError
                            ? snapshot.error.toString()
                            : null,
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person_outline),
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: StreamBuilder(
                    stream: bloc.phoneStream,
                    builder: (context, snapshot) => TextField(
                          controller: _phoneController,
                          decoration: InputDecoration(
                            errorText: snapshot.hasError
                                ? snapshot.error.toString()
                                : null,
                            labelText: 'Phone Number',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.phone),
                          ),
                        )),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: StreamBuilder(
                    stream: bloc.emailStream,
                    builder: (context, snapshot) => TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            errorText: snapshot.hasError
                                ? snapshot.error.toString()
                                : null,
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.mail_outline),
                          ),
                        )),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: StreamBuilder(
                    stream: bloc.passStream,
                    builder: (context, snapshot) => TextField(
                          controller: _passController,
                          // obscureText: true,
                          decoration: InputDecoration(
                            errorText: snapshot.hasError
                                ? snapshot.error.toString()
                                : null,
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock_outline),
                          ),
                        )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 40),
                child: SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xff3277D8)),
                        ),
                        onPressed: Signup,
                        child: const Text('Signup'))),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                      child: Text('Already a User?'),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      },
                      child: const Text(
                        'Login now',
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
