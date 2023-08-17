import 'dart:async';
import 'package:flutter/material.dart';

import '../../../Core/Constant/ColorConstant/ColorConstant.dart';
import '../../../ShakesProject/categoryItems.dart';

class LikeIcon extends StatefulWidget {
  final bool like;
  const LikeIcon({Key? key, required this.like}) : super(key: key);

  @override
  _LikeIconState createState() => _LikeIconState();
}

class _LikeIconState extends State<LikeIcon> {
  bool like = true;

  @override
  void initState() {

    super.initState();
    if (widget.like) {
      // Start a timer to set like to false after 3 seconds
      Timer(const Duration(milliseconds:400 ,), () {
        setState(() {
          like = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    w=MediaQuery.sizeOf(context).width;
    h=MediaQuery.sizeOf(context).height;


    return like == true
        ? Icon(
      Icons.favorite,
      size: w*0.3,
      color: ColorConstant().secondary,
    )
        : const SizedBox();
  }
}
