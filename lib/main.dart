import 'package:book_car_app/src/blocs/auth_bloc.dart';
import 'package:book_car_app/src/resources/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'src/app.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp(
      AuthBloc(),
      const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
      )));
}
