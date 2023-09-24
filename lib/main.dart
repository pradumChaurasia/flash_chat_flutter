import 'package:flutter/material.dart';
import 'package:flash_flutter/screens/welcome_screen.dart';
import 'package:flash_flutter/screens/chat_screen.dart';
import 'package:flash_flutter/screens/login_screen.dart';
import 'package:flash_flutter/screens/register_screen.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme:ThemeData.dark().copyWith(
      //   textTheme: TextTheme(
      //     bodyText1: TextStyle(color: Colors.black54),
      //   ),


        home:WelcomeScreen(

        ),
        initialRoute: WelcomeScreen.id,
        routes:{
          LoginPage.id:(context)=>LoginPage(),
          RegisterPage.id:(context)=>RegisterPage(),
          WelcomeScreen.id:(context)=>WelcomeScreen(),
          ChatPage.id:(context)=>ChatPage()
        }
      );
  }
}

