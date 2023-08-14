import 'package:flutter/material.dart';

import 'Homepage.dart';
import 'categoryItems.dart';

class emptywish extends StatefulWidget {
  const emptywish({super.key});

  @override
  State<emptywish> createState() => _emptywishState();
}

class _emptywishState extends State<emptywish> {
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
            const Image(image: AssetImage("assets/images/53.png")
            ),
            Text("Your Wishlist is Empty!",style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold,fontSize: 23),),
            Text("seems like you don't have wishes here",style: TextStyle(color: Colors.grey,fontStyle: FontStyle.italic),),
            Text("Make a wish!",style: TextStyle(color: Colors.white),),
            SizedBox(
              height: 10,
            ),
            InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage(),));
                },
                child: Text("Start Shopping",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,decoration: TextDecoration.underline),))
          ],
        ),
      ),
    );
  }
}
