import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../models/StoryModel.dart';

class UserStoryReview extends StatefulWidget {
  List<StoryModel>data;
  int index;
UserStoryReview({super.key, required this.data,required this.index});

  @override
  State<UserStoryReview> createState() => _UserStoryReviewState();
}

class _UserStoryReviewState extends State<UserStoryReview> {
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
    var w = MediaQuery
        .sizeOf(context)
        .width;
    var h = MediaQuery
        .sizeOf(context)
        .height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(

          children: [
            SizedBox(
              width: double.maxFinite,
              height: double.maxFinite,
              child: Image(image: CachedNetworkImageProvider(widget.data[widget.index].image),)
            ),
            Positioned(
              top: w*0.025,
              left: w*0.025,
              child: SizedBox(
                width: w/2,

                child: Row(
                  children: [
                    CircleAvatar(
                      radius: w*0.035,
                      backgroundImage:CachedNetworkImageProvider(widget.data[widget.index].profile)),
                    SizedBox(width: w*0.025,),
                    Text(widget.data[widget.index].name,style: const TextStyle(color: Colors.white),),
                    SizedBox(width: w*0.025,),
                    Text(getTimeAgo(widget.data[widget.index].storyDate),style: const TextStyle(color: Colors.grey),)
  ]
                    ),

      ),
            )

          ],
        ),
      ),
    );
  }
}
