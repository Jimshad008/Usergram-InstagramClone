


import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task4/auth/screens/Comment.dart';

import 'package:task4/auth/screens/LikeAnimation.dart';
import 'package:task4/auth/screens/LikesPage.dart';
import 'package:task4/auth/screens/MyProfile.dart';
import 'package:task4/auth/screens/Otheruser_Profile.dart';
import 'package:task4/auth/screens/UsergramUsers.dart';

import 'package:task4/root.dart';

import '../../Constant/FireBaseConstants.dart';
import '../../categoryItems.dart';
import '../../models/UsersModel.dart';
import '../../models/mediaModel.dart';
import '../controller/auth_controller.dart';

class FeedviewContainer extends StatefulWidget {
  List <MediaModel> data;
  int index;
 FeedviewContainer({required this.index,required this.data});

  @override
  State<FeedviewContainer> createState() => _FeedviewContainerState();
}

class _FeedviewContainerState extends State<FeedviewContainer> {
  String getTimeAgo(DateTime dateTime) {
    Duration difference = DateTime.now().difference(dateTime);

    if (difference.inDays >= 1) {
      return "${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago";
    } else if (difference.inHours >= 1) {
      return "${difference.inHours} hr${difference.inHours > 1 ? 's' : ''} ago";
    } else if (difference.inMinutes >= 1) {
      return "${difference.inMinutes} min${difference.inMinutes > 1 ? 's' : ''} ago";
    } else {
      return "Just now";
    }
  }
  bool _isExpanded = false;

  void _toggleSheet() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _onDragEnd(DragEndDetails details) {
    if (details.velocity.pixelsPerSecond.dy > 0) {
      // User dragged down, so close the sheet
      _toggleSheet();
    } else if (details.velocity.pixelsPerSecond.dy < 0) {
      // User dragged up, so expand the sheet
      _toggleSheet();
    }
  }
  void bottomsheet(){

    showModalBottomSheet(isScrollControlled: false,backgroundColor: Constant().ternary,useRootNavigator: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(h*0.03)),
      ),
      showDragHandle: true,
      enableDrag: true,
      context: context, builder: (context) =>CommentPage(index: widget.index, data: widget.data),);
  }
  void bottomsheet1(){

    showModalBottomSheet(backgroundColor: Constant().ternary,useRootNavigator: true,
      isScrollControlled:true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(h*0.03)),
      ),
      showDragHandle: true,
      enableDrag: true,
      context: context, builder: (context) =>CommentPage(index: widget.index, data: widget.data),);
  }

  bool like=false;
  bool saved=false;
  Stream<List<UsersModel>> userStream() {
    return FirebaseFirestore.instance
        .collection(FireBaseConstant.userCollection).where("uid",isEqualTo: widget.data[widget.index].uid)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => UsersModel.fromJson(
      doc.data(),
    ))
        .toList());
  }
  AuthController obj=AuthController();
  // getUserdetailPost() async {
  //   usersModel2 = (await obj.getUser(widget.data[widget.index].uid));
  // }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
     w = MediaQuery
        .sizeOf(context)
        .width;
    h = MediaQuery
        .sizeOf(context)
        .height;
    return StreamBuilder(
        stream: userStream(),
    builder: (context, snapshot) {

      if (snapshot.hasData) {
        // bool like=false;
        bool like=widget.data[widget.index].likes.contains(FirebaseAuth.instance.currentUser!.uid);
         saved=usersModel!.saved.contains(widget.data[widget.index].mid);
        List<UsersModel> data = snapshot.data!;
        return Column(
          children: [
            Container(
              width: w,

              decoration: BoxDecoration(
                color: Colors.white,


              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment
                    .start,
                children: [
                  InkWell(onTap: () {
                    if(data[0].uid!=FirebaseAuth.instance.currentUser!.uid) {
                      Navigator.push(context, CupertinoPageRoute(
                        builder: (context) => OtherUserProfile(data: data),));
                    }
                    else{
                      Navigator.push(context, CupertinoPageRoute(
                        builder: (context) =>Myprofile(),));
                    }
                  },
                    child: Container(
                      width: w,
                      height: w * 0.1,
                      color: Constant().color,
                      child: Padding(
                        padding: const EdgeInsets
                            .only(left: 10.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: CachedNetworkImageProvider(
                                 data[0].profile
                              ),
                              radius: w * 0.04,
                            ),
                            SizedBox(
                              width: w*0.025,
                            ),
                            Text(
                               data[0].name,style: TextStyle(color: Constant().secondary)
                            )
                          ],
                        ),
                      ),

                    ),
                  ),
                  InkWell(
                    onDoubleTap: () async{

                      // LikeAnimation();
                      // if(like == true){
                        if (!widget.data[widget.index].likes.contains(
                            loginId))  {


                          // usersModel = (obj.getUser(widget.data[widget.index].uid));
                          widget.data[widget.index].likes.add(loginId);


                          mediaModel=await(obj.getUserMedia(widget.data[widget.index].mid))  ;

                          var updateData = mediaModel!.copyWith(
                              likes: widget.data[widget.index].likes );
                          // FirebaseFirestore.instance.collectionGroup(collectionPath)
                          mediaModel!.ref!.update(
                              updateData.toJson());
                          setState(() {
                            like=true;
                          });
                        }

                      else{
                        // if (widget.data[widget.index].likes.contains(
                        //     loginId))  {


                          // usersModel = (obj.getUser(widget.data[widget.index].uid));
                          widget.data[widget.index].likes.remove(loginId);


                          mediaModel=await(obj.getUserMedia(widget.data[widget.index].mid))  ;

                          var updateData = mediaModel!.copyWith(
                              likes: widget.data[widget.index].likes );
                          // FirebaseFirestore.instance.collectionGroup(collectionPath)
                         mediaModel!.ref!.update(
                              updateData.toJson());
                          setState(() {
                            like=false;
                          });
                        }

                    },
                    child: Stack(
                      children: [
                        Container(
                          child: InteractiveViewer(
                            child: CachedNetworkImage(
                                imageUrl: widget.data[widget.index]
                                    .image),
                          ),
                        ),
                        if (like)
                          Positioned.fill(
                            child: Align(
                        alignment: Alignment.center,
                              child: LikeIcon(like: like),
                            ),
                          ),
                          // Align(
                          //   alignment: Alignment.center,
                          //   child: LikeAnimation(like: like,
                          //   ),
                          // )
                      ],
                    ),
                  ),
                  Container(
                    width: w,
                      color: Constant().color,

                    child: Padding(
                      padding: const EdgeInsets
                          .all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment
                            .start,
                        children: [
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  InkWell(onTap: () async{
                                    if (!widget.data[widget.index].likes.contains(
                                        loginId))  {


                                      // usersModel = (obj.getUser(widget.data[widget.index].uid));
                                      widget.data[widget.index].likes.add(loginId);


                                      mediaModel=await(obj.getUserMedia(widget.data[widget.index].mid))  ;

                                      var updateData = mediaModel!.copyWith(
                                          likes: widget.data[widget.index].likes );
                                      // FirebaseFirestore.instance.collectionGroup(collectionPath)
                                    mediaModel!.ref!.update(
                                          updateData.toJson());
                                      setState(() {
                                        like=true;
                                      });
                                    }

                                    else{
                                      // if (widget.data[widget.index].likes.contains(
                                      //     loginId))  {


                                      // usersModel = (obj.getUser(widget.data[widget.index].uid));
                                      widget.data[widget.index].likes.remove(loginId);


                                      mediaModel=await(obj.getUserMedia(widget.data[widget.index].mid))  ;

                                      var updateData = mediaModel!.copyWith(
                                          likes: widget.data[widget.index].likes );
                                      // FirebaseFirestore.instance.collectionGroup(collectionPath)
                                      mediaModel!.ref!.update(
                                          updateData.toJson());
                                      setState(() {
                                        like=false;
                                      });
                                    }

                                    // LikeAnimation();
                                  },
                                    child:like?Icon(Icons
                                        .favorite,color: Colors.red,size: 30,): Icon(Icons
                      .favorite_border_outlined,color: Constant().secondary,size: 30,)
                                  ),
                                  SizedBox(
                                    width: w * 0.04,
                                  ),
                                  InkWell(onTap:() {
                                    bottomsheet1();
                                  },child: FaIcon(FontAwesomeIcons.comment,color: Constant().secondary,size: 28,)),
                                  SizedBox(
                                    width: w * 0.04,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: FaIcon(FontAwesomeIcons.paperPlane,color: Constant().secondary,size: 25,),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: InkWell(onTap: () async {
                                  // setState(() {
                                  //   saved=!saved;
                                  // });
                                  // if(saved){
                                    if(!usersModel!.saved.contains(widget.data[widget.index].mid)) {
                                      usersModel = await obj.getUser(
                                          FirebaseAuth.instance.currentUser!
                                              .uid);
                                      usersModel!.saved.add(
                                          widget.data[widget.index].mid);
                                      var update = usersModel!.copyWith(
                                          saved: usersModel!.saved);
                                      mediaModel!.ref!.update(
                                          update.toJson());
                                      setState(() {
                                        saved = true;
                                      });
                                    }

                                  // }
                                  else {
                                    // if (usersModel!.saved.contains(
                                    //     widget.data[widget.index].mid)) {
                                      usersModel = await obj.getUser(
                                          FirebaseAuth.instance.currentUser!
                                              .uid);
                                      usersModel!.saved.remove(
                                          widget.data[widget.index].mid);
                                      var update = usersModel!.copyWith(
                                          saved: usersModel!.saved);
                                      usersModel!.ref!.update(
                                          update.toJson());
                                    }setState(() {
                                      saved =false;
                                    });

                                },
                                    child: saved?Icon(CupertinoIcons.bookmark_fill,color: Constant().secondary,size: 28,):Icon(CupertinoIcons.bookmark,color: Colors.white,size: 28,))
                              )
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, CupertinoPageRoute(builder: (context) => Likes(data: widget.data, index: widget.index),));
                            },
                            child: Container(
                              child: Row(
                                children: [
                                  Text("${widget.data[widget.index].likes.length} ",style: TextStyle(color: Constant().secondary,fontWeight: FontWeight.bold),),
                                  Text("Likes",style: TextStyle(color: Constant().secondary,fontWeight: FontWeight.bold))
                                ],
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              InkWell(onTap: () {
                                Navigator.push(context, CupertinoPageRoute(builder: (context) => OtherUserProfile(data:data),));
                              },
                                child: Text(
                                  data[0].name,
                                  style: TextStyle(
                                      fontWeight: FontWeight
                                          .bold,color: Constant().secondary),),
                              ),
                              Padding(
                                padding: const EdgeInsets
                                    .all(8.0),
                                child: Text(
                                    widget.data[widget.index]
                                        .description,style: TextStyle(color: Constant().secondary)),
                              ),
                            ],
                          ),
                          InkWell(onTap: () {
                            bottomsheet();
                          },child: widget.data[widget.index].comment.length!=0?Text("View all ${widget.data[widget.index].comment.length} Comments",style: TextStyle(color: Colors.grey),):Text("")),
                          Padding(
                            padding: const EdgeInsets
                                .only(top: 10.0),
                            child: Text(
                              "${getTimeAgo(widget.data[widget.index].postDate.toDate())}",
                              style: TextStyle(color: Constant().secondary),
                            )
                          )
                        ],
                      ),
                    ),
                  ),


                ],
              ),
            ),
          ],
        );
      }
      else{
        return CircularProgressIndicator();
      }
    }
    );
  }
}
