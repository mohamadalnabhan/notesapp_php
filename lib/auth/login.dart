import 'package:flutter/material.dart';
import 'package:php_app/customWidgets/custom_text_form.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("login Page"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Form(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(9),
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/logo.PNG",
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(height: 50),
                  CustomTextForm(textHint: "enter ur emaiL",
                   controller: email),
                  const SizedBox(height: 20),
                  CustomTextForm(
                    textHint: "enter ur password",
                    controller: password,
                  ),
                  const SizedBox(height: 20),
                  MaterialButton(
                    textColor: Colors.white,
                    color: Colors.deepPurple,
                    padding: EdgeInsets.symmetric(horizontal: 35),
                    onPressed: () {},
                    child: Text("login"),
                  ),
                  const SizedBox(height: 15),
                  InkWell(
                    child: Text("signup"),
                    onTap: () {
                      Navigator.of(context).pushNamed("signup");
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
