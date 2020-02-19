import 'package:flutter/material.dart';
import 'package:lost_and_found/screens/newItem.dart';
import 'home.dart';
import 'screens/login.dart';
import 'screens/register.dart';

void main() => runApp(LostAndFoundApp());

class LostAndFoundApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF6D60FB),
        scaffoldBackgroundColor: Color(0xFF6D60FB),
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => Home(),
        "/login": (context) => LogIn(),
        "/registor": (context) => Register(),
        "/newItem": (context) => NewItem()
      },
    );
  }
}
