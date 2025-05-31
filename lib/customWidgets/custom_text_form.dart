
import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
 TextEditingController? controller;
 final String textHint ; 
 String? Function(String?) valid ;
  CustomTextForm({super.key, required this.textHint , required this.controller , required this.valid});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator:valid ,
        controller: controller ,
        decoration: InputDecoration(
          hintText: textHint ,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
            borderSide: BorderSide(color: Colors.black)
          )
        ),
    );
  }
}