
import 'package:flutter/material.dart';
import 'package:task4/models/UsersModel.dart';
import '../../../Core/Constant/ColorConstant/ColorConstant.dart';
var w;
var h;
class MyLoginCard extends StatefulWidget {
  int index;
  List<UsersModel> data;
  MyLoginCard({super.key, required this.index,required this.data});

  @override
  State<MyLoginCard> createState() => _MyLoginCardState();
}

class _MyLoginCardState extends State<MyLoginCard> {
  @override
  Widget build(BuildContext context) {
    w=MediaQuery.sizeOf(context).width;
    h=MediaQuery.sizeOf(context).height;

    return Container(
      width: w * 0.8,
      height: w * 0.265,
      decoration: BoxDecoration(
          border: Border(bottom:BorderSide(color:ColorConstant().secondary))



      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0,bottom:20 ),
            child: Center(
              child: Text(".",
                style: TextStyle(
                    fontWeight: FontWeight.bold,fontSize: 50,color: ColorConstant().secondary),),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: CircleAvatar(
              backgroundColor: ColorConstant().secondary,
              radius: w * 0.085,
              child: CircleAvatar(
                backgroundColor: Colors.blue,

                radius: w * 0.08,
                backgroundImage: NetworkImage(
                    widget.data[widget.index].profile),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: SizedBox(
              width: w * 0.45,
              child: Column(
                mainAxisAlignment: MainAxisAlignment
                    .center,
                crossAxisAlignment: CrossAxisAlignment
                    .start,
                children: [
                  Text(widget.data[widget.index].name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,color: ColorConstant().secondary),),
                  Text(widget.data[widget.index].email,
                    style: TextStyle(color: ColorConstant().secondary,
                        fontSize: w * 0.027),)
                ],
              ),
            ),
          ),


        ],),
    );


  }
}