import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final void Function()? ontap;
  final String title;
  final String content;

  const CustomCard({
    super.key,
    required this.ontap,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Card(
        child: Row(
          children: [
            Image.asset(
              "assets/images/notepic.PNG",
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
                title: Text(title),
                subtitle: Text(content),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
