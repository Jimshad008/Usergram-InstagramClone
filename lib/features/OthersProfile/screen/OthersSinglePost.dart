import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../Core/Constant/ColorConstant/ColorConstant.dart';
import '../../../models/mediaModel.dart';
import '../../Home/widget/feedViewContainer.dart';

class OtherSinglePost extends StatefulWidget {
  String image;
  String description;
  Timestamp postDate;
  List <MediaModel> data;
  int index;
  OtherSinglePost({super.key, required this.data,required this.index,required this.description,required this.image,required this.postDate});

  @override
  State<OtherSinglePost> createState() => _OtherSinglePostState();
}

class _OtherSinglePostState extends State<OtherSinglePost> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery
        .sizeOf(context)
        .width;
    var h = MediaQuery
        .sizeOf(context)
        .height;
    return SafeArea(
      child: Scaffold(
        backgroundColor:ColorConstant().color,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(child:
          FeedviewContainer(index: widget.index, data: widget.data),),

      ),
    );
  }
}
