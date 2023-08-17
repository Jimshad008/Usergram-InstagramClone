import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:task4/models/UsersModel.dart';

import '../../../Core/Constant/ColorConstant/ColorConstant.dart';
import '../../../models/CommentModel.dart';
var w;
var h;
class CommentCard extends StatefulWidget {
  List<CommentModel>mdata;

  int index;
  List<UsersModel>udata;



  CommentCard({super.key, required this.mdata,required this.udata,required this.index,});

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  bool select=false;
  String getTimeAgo(Timestamp a) {
    DateTime dateTime=a.toDate();
    Duration difference = DateTime.now().difference(dateTime);

    if (difference.inDays >= 1) {
      return "${difference.inDays}d";
    } else if (difference.inHours >= 1) {
      return "${difference.inHours}h";
    } else if (difference.inMinutes >= 1) {
      return "${difference.inMinutes}m";
    } else {
      return "Just now";
    }
  }
  @override
  Widget build(BuildContext context) {

    return SizedBox(

      width: w,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: CircleAvatar(
              backgroundColor: Colors.blue,

              radius: w * 0.055,
              backgroundImage: NetworkImage(
                  widget.udata[0].profile ),),
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
                  Row(
                    children: [
                      Text(widget.udata[0].name,
                        style: TextStyle(
                            color: ColorConstant().secondary),),
                      SizedBox(width: w*0.025,),
                      Text(getTimeAgo(widget.mdata[widget.index].commentDate),style: const TextStyle(
                          color: Colors.grey),)
                    ],
                  ),
                  Text(widget.mdata[widget.index].comment,
                    style: TextStyle(color: ColorConstant().secondary,
                        fontSize: w * 0.045),)
                ],
              ),
            ),
          ),


        ],),
    );
  }
}

