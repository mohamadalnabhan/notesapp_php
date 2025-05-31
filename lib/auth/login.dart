import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:php_app/constant/links.dart';
import 'package:php_app/customWidgets/crud.dart';
import 'package:php_app/customWidgets/custom_text_form.dart';
import 'package:php_app/customWidgets/custom_validator.dart';
import 'package:php_app/main.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Crud crud = Crud();
  bool isLoading = false;
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  logIn() async {
    bool isLoading = true;
    setState(() {});
    if (formstate.currentState!.validate()) {
      var response = await crud.PostRequest(LinkLogin, {
        "email": email.text,
        "password": password.text,
      });
      bool isLoading = true;
      setState(() {});
      if (response['status'] == "success") {
        sharedPreferences.setString("id", response['data']['id'].toString());
        sharedPreferences.setString("username", response['data']['username']);
        sharedPreferences.setString("email", response['data']['email']);
        Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
      } else {
        return AwesomeDialog(
          context: (context),
          title: "login failed",
          body: Text(
            "your email or password are wrong ,or ur email does not exist ",
          ),
        )..show();
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("login Page", style: TextStyle(color: Colors.white)),

        backgroundColor: Colors.deepPurple,
      ),
      body:
          isLoading == true
              ? Center(child: CircularProgressIndicator())
              : Form(
                key: formstate,
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
                          CustomTextForm(
                            valid: (val) {
                              return validateForm(val!, 3, 50);
                            },
                            textHint: "enter ur emaiL",
                            controller: email,
                          ),
                          const SizedBox(height: 20),
                          CustomTextForm(
                            valid: (val) {
                              return validateForm(val!, 3, 50);
                            },
                            textHint: "enter ur password",
                            controller: password,
                          ),
                          const SizedBox(height: 20),
                          MaterialButton(
                            textColor: Colors.white,
                            color: Colors.deepPurple,
                            padding: EdgeInsets.symmetric(horizontal: 35),
                            onPressed: () async {
                              await logIn();
                            },
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
