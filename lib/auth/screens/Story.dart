import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StoryPage extends StatefulWidget {
  const StoryPage({super.key});

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  @override
  Widget build(BuildContext context) {

    var w = MediaQuery
        .sizeOf(context)
        .width;
    var h = MediaQuery
        .sizeOf(context)
        .height;

    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Container(
        width: w,
        height: h*0.1,
        child:ListView.builder(scrollDirection: Axis.horizontal,itemCount: 8,itemBuilder: (context, index) => Row(
          children: [
            CircleAvatar(radius:35,backgroundColor: Colors.blue,),
            SizedBox(width: 8,)
          ],
        ),),
      ),
    );
  }
}
