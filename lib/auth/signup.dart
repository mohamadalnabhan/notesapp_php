import 'package:flutter/material.dart';
import 'package:php_app/constant/links.dart';
import 'package:php_app/customWidgets/crud.dart';
import 'package:php_app/customWidgets/custom_text_form.dart';
import 'package:php_app/home.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  Crud _crud = Crud();
  bool isLoading = false ;
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  signUp()async{
    Future.delayed(Duration(seconds: 2));
var response = await _crud.PostRequest(LinkSignUp, {
  "username" : username.text ,
  "email" : email.text ,
  "password" : password.text

}
) ;
isLoading = true ;
setState(() {
  
});
  if(response['status']=="success"){
    Navigator.of(context).pushNamedAndRemoveUntil("home", (route)=>false);
  }else{
    print("signup failed");
  }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Signup Page"),
        backgroundColor: Colors.deepPurple,
      ),body: isLoading ==true ?Center(child: CircularProgressIndicator(),) : Form(
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
                    controller: password,
                  ),
                  const SizedBox(height: 20),
                  MaterialButton(
                    textColor: Colors.white,
                    color: Colors.deepPurple,
                    padding: EdgeInsets.symmetric(horizontal: 35),
                    onPressed: ()async {
                      await signUp();
                    },
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
