import 'package:flutter/material.dart';
import 'package:php_app/constant/links.dart';
import 'package:php_app/model/note_model.dart';

class CustomCard extends StatelessWidget {
  final void Function()? ontap;

  final NoteModel noteModel ;
  final void Function()? onDelete;
  const CustomCard({
    super.key,
    required this.ontap,
    
    required this.onDelete,  required this.noteModel,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Card(
        child: Row(
          children: [
            Image.network(
              "$ImgRoute/${noteModel.noteImage}",
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey[300],
                  child: const Icon(Icons.error),
                );
              },
            ),
            Expanded(
              child: ListTile(
                title: Text("${noteModel.noteTitle}"),
                subtitle: Text("${noteModel.noteContent}"),
                trailing: IconButton(
                  onPressed: onDelete,
                  icon: Icon(Icons.delete, color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
