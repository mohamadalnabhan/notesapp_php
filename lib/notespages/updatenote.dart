
import 'package:flutter/material.dart';
import 'package:php_app/customWidgets/custom_text_form.dart';

class Updatenote extends StatefulWidget {
  const Updatenote({super.key});

  @override
  State<Updatenote> createState() => _UpdatenoteState();
}

class _UpdatenoteState extends State<Updatenote> {
  @override
    GlobalKey<FormState> formState = GlobalKey();

  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(title: Text("Add note")),
      body: Container(
        child: Form(
          key: formState,
          child: ListView(
            children: [
              CustomTextForm(
                textHint: "enter title ",
                controller: title,
                valid: (val) {},
              ),
              const SizedBox(height: 20),
              CustomTextForm(
                textHint: "enter content ",
                controller: content,
                valid: (val) {},
              ),
              const SizedBox(height: 40,),
              MaterialButton(onPressed: (){

              } , child: Text("add"),)
            ],
          ),
        ),
      ),
    );
  }
}
