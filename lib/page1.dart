import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  TextEditingController text = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: TextFormField(
              controller: text,

            ),
          ),
          ElevatedButton(onPressed: ()async {
            if(text.text.isNotEmpty){
            final SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString("name", text.text);
            }
          }, child: Text("Submit"))
        ],
      ),
    );
  }
}
