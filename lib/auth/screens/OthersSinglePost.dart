import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../Constant/FireBaseConstants.dart';
import '../../models/UsersModel.dart';
import '../../models/mediaModel.dart';
import 'feedViewContainer.dart';

class OtherSinglePost extends StatefulWidget {
  String image;
  String description;
  Timestamp postDate;
  List <MediaModel> data;
  int index;
  OtherSinglePost({required this.data,required this.index,required this.description,required this.image,required this.postDate});

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
        backgroundColor:Constant().color,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(child:
          FeedviewContainer(index: widget.index, data: widget.data),),

      ),
    );
  }
}
