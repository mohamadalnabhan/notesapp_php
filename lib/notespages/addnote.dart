import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:php_app/constant/crud.dart';
import 'package:php_app/customWidgets/custom_text_form.dart';
import 'package:php_app/constant/links.dart';
import 'package:php_app/customWidgets/custom_validator.dart';
import 'package:php_app/main.dart';
// ignore: depend_on_referenced_packages
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Addnote extends StatefulWidget {
  const Addnote({super.key});

  @override
  State<Addnote> createState() => _AddnoteState();
}

class _AddnoteState extends State<Addnote> {
  File? myfile;
  Crud crud = Crud();
  GlobalKey<FormState> formState = GlobalKey();

  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  bool isLoading = false;
  addNotes() async {
    if (myfile == null)
      return AwesomeDialog(
        context: context,
        title: "alert",
        body: Text("you have to add a pic to complete your request "),
      )..show();
    if (formState.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await crud.PostRequestWithFiles(LinkAddNotes, {
        "id": sharedPreferences.getString('id'),
        "title": title.text,
        "content": content.text,
      }, myfile!);
      isLoading = false;
      setState(() {});
      if (response['status'] == "success") {
        Navigator.of(context).pushReplacementNamed("home");
      } else {
        print("errOr happened");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add note"),
        backgroundColor: Colors.deepPurple,
      ),
      body:
          isLoading == true
              ? Center(child: CircularProgressIndicator())
              : Container(
                padding: EdgeInsets.all(9),
                child: Form(
                  key: formState,
                  child: ListView(
                    children: [
                      CustomTextForm(
                        textHint: "enter title ",
                        controller: title,
                        valid: (val) {
                          return validateForm(val!, 2, 30);
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomTextForm(
                        textHint: "enter content ",
                        controller: content,
                        valid: (val) {
                          return validateForm(val!, 2, 30);
                        },
                      ),
                      const SizedBox(height: 40),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 100),
                        child: MaterialButton(
                          color: Colors.deepPurple,
                          textColor: Colors.white,
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder:
                                  (context) => Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 5,
                                    ),
                                    height: 140,
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("choose a picture from"),
                                        InkWell(
                                          onTap: () async {
                                            final XFile? xFile =
                                                await ImagePicker().pickImage(
                                                  source: ImageSource.camera,
                                                );
                                            if (xFile != null) {
                                              setState(() {
                                                myfile = File(xFile.path);
                                              });
                                            }

                                            print(
                                              "Selected file path: ${myfile?.path}",
                                            );
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.all(10),
                                            child: Text(
                                              "camera",
                                              style: TextStyle(fontSize: 17),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            final XFile? xFile =
                                                await ImagePicker().pickImage(
                                                  source: ImageSource.gallery,
                                                );
                                            if (xFile != null) {
                                              setState(() {
                                                myfile = File(xFile.path);
                                              });
                                            }

                                            print(
                                              "Selected file path: ${myfile?.path}",
                                            );
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.all(10),
                                            child: Text(
                                              "Gallery",
                                              style: TextStyle(fontSize: 17),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            );
                          },
                          child: Text("add Image"),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 100),
                        child: MaterialButton(
                          color: Colors.deepPurple,
                          textColor: Colors.white,
                          onPressed: () async {
                            await addNotes();
                          },
                          child: Text("add"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }
}
