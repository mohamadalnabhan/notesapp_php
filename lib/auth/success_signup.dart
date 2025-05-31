import 'package:flutter/material.dart';

class SuccessSignup extends StatefulWidget {
  const SuccessSignup({super.key});

  @override
  State<SuccessSignup> createState() => _SuccessSignupState();
}

class _SuccessSignupState extends State<SuccessSignup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: const Text(
              "Signup completed successfully",
              style: TextStyle(fontSize: 21),
            ),
          ),
          const SizedBox(height: 30),
          MaterialButton(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 12),
            textColor: Colors.white,
            color: Colors.deepPurple,
            onPressed: () {
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil("login", (route) => false);
            },
            child: Text("go to login page"),
          ),
        ],
      ),
    );
  }
}
