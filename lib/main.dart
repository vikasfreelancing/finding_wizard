import 'package:flutter/material.dart';
import 'package:lost_and_found/screens/lostItem.dart';
import 'package:lost_and_found/screens/lostItemViewList.dart';
import 'home.dart';
import 'screens/login.dart';
import 'screens/register.dart';
import 'messagingModule/screens/welcome_screen.dart';
import 'messagingModule/screens/login_screen.dart';
import 'messagingModule/screens/registration_screen.dart';
import 'messagingModule/screens/chat_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() => runApp(LostAndFoundApp());

class LostAndFoundApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //print(FirebaseMessaging().getToken());
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
        "/newItem": (context) => LostItem(),
        "/listItems": (context) => LostItemView(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen()
      },
    );
  }
}
