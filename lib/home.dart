import 'package:flutter/material.dart';
import 'package:php_app/constant/links.dart';
import 'package:php_app/constant/crud.dart';

import 'package:php_app/customWidgets/custom_card.dart';
import 'package:php_app/main.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Crud crud = Crud();
  getNotes() async {
    var id = sharedPreferences.getString('id');
    print("📤 Sending user ID: $id");

    var response = await crud.PostRequest(LinkViewNotes, {"id": id});

    print("📥 Backend Response: $response");

    return response;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'), // Fixed: Using Text instead of Home()
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            onPressed: () {
              sharedPreferences.clear();
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil("login", (route) => false);
            },
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          Navigator.of(context).pushNamed("addnote");
        },
        child: Icon(Icons.add,color: Colors.white,),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              FutureBuilder(
                future: getNotes(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasData) {
                    // Check for success status
                    if (snapshot.data['status'] == 'success') {
                      List notes = snapshot.data['data'] ?? [];

                      if (notes.isEmpty) {
                        return const Center(child: Text("No notes found."));
                      }

                      return ListView.builder(
                        itemCount: notes.length,
                        shrinkWrap: true, // important!
                        physics:
                            const NeverScrollableScrollPhysics(), // prevents scroll conflict
                        itemBuilder: (context, index) {
                          var note = notes[index];
                          return CustomCard(
                            ontap: () {},
                            title: note['note_title'] ?? '',
                            content: note['note_content'] ?? '',
                          );
                          
                        },
                      );
                    } else {
                      return const Center(child: Text("Failed to load notes."));
                    }
                  }

                  return const Center(
                    child: Text("Unexpected error occurred."),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
