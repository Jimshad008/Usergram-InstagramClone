import 'package:flutter/material.dart';
import 'package:task4/Homepage.dart';

class emptycart extends StatefulWidget {
  const emptycart({super.key});

  @override
  State<emptycart> createState() => _emptycartState();
}

class _emptycartState extends State<emptycart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(91, 47, 43, 100),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration:  BoxDecoration(
    gradient: LinearGradient(
    colors: [Colors.brown.shade800, Color.fromARGB(255, 170, 20, 20)],

    )),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage("assets/images/51.png")
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage(),));
              },
                child: Text("Continue Shopping",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,decoration: TextDecoration.underline),))
          ],
        ),
      ),
    );
  }
}
