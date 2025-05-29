import 'package:flutter/material.dart';
import 'package:php_app/customWidgets/custom_text_form.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Signup Page"),
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
                  CustomTextForm(textHint: "enter ur username", controller: username),
                  const SizedBox(height: 20),
                  CustomTextForm(textHint: "enter ur emaiL", controller: email),
                  const SizedBox(height: 20),
                  CustomTextForm(
                    textHint: "enter ur password",
                    controller: email,
                  ),
                  const SizedBox(height: 20),
                  MaterialButton(
                    textColor: Colors.white,
                    color: Colors.deepPurple,
                    padding: EdgeInsets.symmetric(horizontal: 35),
                    onPressed: () {},
                    child: Text("signup"),
                  ),
                  const SizedBox(height: 15),
                  InkWell(
                    child: Text("already have an account ? login"),
                    onTap: () {
                      Navigator.of(context).pushNamed("login");
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
