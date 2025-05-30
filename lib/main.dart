import 'package:flutter/material.dart';
import 'package:php_app/auth/login.dart';
import 'package:php_app/auth/signup.dart';
import 'package:php_app/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
      routes: {
        "login" : (context) => (Login()),
        "signup" :(context)=>(Signup()),
        "home" : (context) => (Home()),
      },
      
   );
  }
}
