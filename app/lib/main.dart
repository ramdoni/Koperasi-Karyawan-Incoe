import 'package:flutter/material.dart';
import 'Login.dart';
import 'confirm_transfer.dart';
import 'register.dart';
import 'home.dart';
import 'launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/": (ctx) => LauncherScreen(),
        "/login": (ctx) => LoginScreen(),
        "/home": (ctx) => HomeScreen(),
        '/register': (ctx) => RegisterScreen(),
        '/confirm-transfer': (ctx) => ConfirmTransferScreen()
      },
    );
  }
}
