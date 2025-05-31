import 'package:flutter/material.dart';
import 'package:php_app/auth/login.dart';
import 'package:php_app/auth/signup.dart';
import 'package:php_app/auth/success_signup.dart';
import 'package:php_app/home.dart';
import "package:shared_preferences/shared_preferences.dart" ;


late SharedPreferences sharedPreferences ;
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        initialRoute: sharedPreferences.getString('id')==null ?"login" :"home",
      routes: {
        "login" : (context) => (Login()),
        "signup" :(context)=>(Signup()),
        "home" : (context) => (Home()),
        "success" : (context) => (SuccessSignup()),
      },
      
   );
  }
}
