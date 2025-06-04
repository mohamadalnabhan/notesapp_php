import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:php_app/constant/crud.dart';
import 'package:php_app/constant/links.dart';
import 'package:php_app/customWidgets/custom_text_form.dart';
import 'package:php_app/customWidgets/custom_validator.dart';

class Updatenote extends StatefulWidget {
  final notes;
  const Updatenote({super.key, this.notes});

  @override
  State<Updatenote> createState() => _UpdatenoteState();
}

class _UpdatenoteState extends State<Updatenote> {
  @override
  File? myfile ; 
  Crud crud = Crud();
  GlobalKey<FormState> formState = GlobalKey();
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  bool isLoading = false;

  updateNotes() async {
    if (formState.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response ;
      if(myfile == null){
             response  = await crud.PostRequest(LinkUpdateNotes, {
        "title": title.text,
        "content": content.text,
        "id": widget.notes['note_id'].toString(),
        "imageName" : widget.notes['note_image'].toString()
      });
      }else{
         response  = await crud.PostRequestWithFiles(LinkUpdateNotes, {
        "title": title.text,
        "content": content.text,
        "id": widget.notes['note_id'].toString(),
        "imageName" : widget.notes['note_image'].toString()
      } , myfile! );

      }
 
      isLoading = false;
      setState(() {});
      if (response['status'] == "success") {
        Navigator.of(context).pushReplacementNamed("home");
      } else {
        print("errOr happened");
      }
    }
  }

  void initState() {
    title.text = widget.notes['note_title'];
    content.text = widget.notes['note_content'];

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add note", style: TextStyle(color: Colors.white)),
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
                          return validateForm(val!, 3, 50);
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomTextForm(
                        textHint: "enter content ",
                        controller: content,
                        valid: (val) {
                          return validateForm(val!, 3, 50);
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
                      const SizedBox(height: 20, ),
                      MaterialButton(
                        color: Colors.deepPurple,
                        onPressed: () async {
                          await updateNotes();
                        },
                        child: Text(
                          "edit",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }
}
