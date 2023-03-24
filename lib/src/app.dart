import 'package:book_car_app/src/blocs/auth_bloc.dart';
import 'package:flutter/material.dart';

import 'resources/login_page.dart';
import 'resources/signup_page.dart';

// ignore: use_key_in_widget_constructors
class MyApp extends InheritedWidget {
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     title: 'Flutter Demo',
  //     theme: ThemeData(
  //       primarySwatch: Colors.blue,
  //     ),
  //     home: const LoginPage(),
  //   );
  // }

  final AuthBloc? authBloc;
  final Widget child;
  MyApp(this.authBloc, this.child) : super(child: child);
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return false;
  }

  static MyApp? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyApp>();
  }
}
