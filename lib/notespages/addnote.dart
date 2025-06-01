import 'package:flutter/material.dart';
import 'package:php_app/constant/crud.dart';
import 'package:php_app/customWidgets/custom_text_form.dart';
import 'package:php_app/constant/links.dart';
import 'package:php_app/customWidgets/custom_validator.dart';
import 'package:php_app/main.dart';
class Addnote extends StatefulWidget {
  const Addnote({super.key});

  @override
  State<Addnote> createState() => _AddnoteState();
}

class _AddnoteState extends State<Addnote> {
  Crud crud = Crud();
  GlobalKey<FormState> formState = GlobalKey();

  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  bool isLoading = false ;
  addNotes()async{    
    if(formState.currentState!.validate()){
      isLoading = true ;
      setState(() {
        
      });
      var response = await crud.PostRequest(LinkAddNotes, {
        "id" : sharedPreferences.getString('id'),
        "title" : title.text ,
        "content" : content.text
      });
      isLoading = false;
      setState(() {
        
      });
      if(response['status']=="success"){
        Navigator.of(context).pushReplacementNamed("home");
      }else{
        print("errpr happened");
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add note"),backgroundColor: Colors.deepPurple,),
      body:isLoading == true ? Center(child: CircularProgressIndicator(),) : Container(
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
              const SizedBox(height: 40,),
             Container(
              padding: EdgeInsets.symmetric(horizontal: 100),
              child:  MaterialButton(
                color: Colors.deepPurple,
                textColor: Colors.white,
                onPressed: ()async{
                    await addNotes();
              } , child: Text("add"),),
             )
            ],
          ),
        ),
      ),
    );
  }
}
