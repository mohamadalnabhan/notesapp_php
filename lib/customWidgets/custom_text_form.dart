
import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
 TextEditingController? controller;
 final String textHint ; 
  CustomTextForm({super.key, required this.textHint , required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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