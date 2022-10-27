import 'package:flutter/material.dart';
import 'package:ticketingsystem/screens/home.dart';
import 'package:ticketingsystem/screens/login.dart';
import 'package:ticketingsystem/screens/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: SafeArea(
          child: HomePage(),
        ),
      ),
      routes: {
        '/login': (context) => Login(),
        '/register': (context) => Register(),
        '/home': (context) => HomePage(),
      },
    );
  }
}
