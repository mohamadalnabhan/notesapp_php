import 'package:flutter/material.dart';
import 'package:php_app/main.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: const Text('Home Screen'),  // Fixed: Using Text instead of Home()
        backgroundColor: Colors.deepPurple,
        actions: [IconButton(onPressed: (){
              sharedPreferences.clear();
               Navigator.of(context).pushNamedAndRemoveUntil("login", (route) => false);

        }, icon: Icon(Icons.exit_to_app))],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: (){

      },child: Icon(Icons.add),),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              InkWell(
                onTap: () {
                  // Add your onTap functionality here
                },
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
                            color: Colors.grey,
                            child: const Icon(Icons.error),
                          );
                        },
                      ),
                      const Expanded(
                        child: ListTile(
                          title: Text("title1"),
                          subtitle: Text("lorem loreemmmm"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}