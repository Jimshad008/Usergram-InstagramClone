import 'package:flutter/material.dart';

import 'Homepage.dart';

class checkout extends StatefulWidget {
  const checkout({super.key});

  @override
  State<checkout> createState() => _checkoutState();
}

class _checkoutState extends State<checkout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Center(child: Image(image: AssetImage("assets/images/50.gif")),),
          InkWell( onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const Homepage(),));
          },
              child: const Text("Continue Shopping",style: TextStyle(fontWeight: FontWeight.bold,decoration: TextDecoration.underline),))
        ],
      ),
    );
  }
}
