import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task4/models/UsersModel.dart';

import '../../Constant/FireBaseConstants.dart';
import '../../models/mediaModel.dart';
import '../controller/auth_controller.dart';
var w;
var h;
class LoginCard extends StatefulWidget {
 int index;
 var inx;
 List<UsersModel> data;
 var useruid;
  LoginCard({required this.index,required this.useruid,required this.data,required this.inx});

  @override
  State<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  AuthController obj=AuthController();
  bool followUnfollow=false;


  @override
  Widget build(BuildContext context) {

    followUnfollow=widget.data[widget.index].followers.contains(widget.useruid);

    w=MediaQuery.sizeOf(context).width;
    h=MediaQuery.sizeOf(context).height;

  return Container(
    width: w * 0.8,
    height: w * 0.265,
    decoration: BoxDecoration(
      border: Border(bottom:BorderSide(color:Constant().secondary))



    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0,bottom:20 ),
          child: Center(
            child: Text(".",
              style: TextStyle(
                  fontWeight: FontWeight.bold,fontSize: 50,color: Constant().secondary),),
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: CircleAvatar(
            backgroundColor: Constant().secondary,
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
          child: Container(
            width: w * 0.45,
            child: Column(
              mainAxisAlignment: MainAxisAlignment
                  .center,
              crossAxisAlignment: CrossAxisAlignment
                  .start,
              children: [
                Text(widget.data[widget.index].name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,color: Constant().secondary),),
                Text(widget.data[widget.index].email,
                  style: TextStyle(color: Constant().secondary,
                      fontSize: w * 0.027),)
              ],
            ),
          ),
        ),
        InkWell(onTap: () async {


          usersModel=await(obj.getUser(FirebaseAuth.instance.currentUser!.uid))  ;
            if (!widget.data[widget.index].followers.contains(
                widget.useruid))  {


              // usersModel = (obj.getUser(widget.data[widget.index].uid));
              widget.data[widget.index].followers.add(widget.useruid);
              List updatefollower = widget.data[widget.index].followers;

              usersModel=await(obj.getUser(widget.data[widget.index].uid))  ;

              var updateData = usersModel!.copyWith(
                  followers: updatefollower);
              usersModel!.ref!.update(
                  updateData.toJson());
              usersModel=await(obj.getUser(FirebaseAuth.instance.currentUser!.uid))  ;


            if (!widget.data[widget.inx].following.contains(
                widget.data[widget.index].uid))  {

              usersModel=await(obj.getUser(widget.data[widget.inx].uid))  ;
              // usersModel = (obj.getUser(widget.data[widget.index].uid));
              widget.data[widget.inx].following.add(widget.data[widget.index].uid);
              List updatefollower = widget.data[widget.inx].following;



              var updateData = usersModel!.copyWith(
                  following: updatefollower);
              usersModel!.ref!.update(
                  updateData.toJson());
              usersModel=await(obj.getUser(FirebaseAuth.instance.currentUser!.uid))  ;

            }

              setState(() {
                followUnfollow = true;
              });

            }

          else {



  usersModel = (await obj.getUser(widget.data[widget.index].uid));
  widget.data[widget.index].followers.remove(widget.useruid);
  var updateData = usersModel!.copyWith(
  followers: widget.data[widget.index].followers);
 usersModel!.ref!.update(
  updateData.toJson());
  usersModel=await(obj.getUser(FirebaseAuth.instance.currentUser!.uid))  ;
            if (widget.data[widget.inx].following.contains(
                widget.data[widget.index].uid) ) {
              usersModel = (await obj.getUser(widget.data[widget.inx].uid));
              widget.data[widget.inx].following.remove(widget.data[widget.index].uid);
              var updateData = usersModel!.copyWith(
                  following: widget.data[widget.inx].following
              );
             usersModel!.ref!.update(
                  updateData.toJson());
            }
  usersModel=await(obj.getUser(FirebaseAuth.instance.currentUser!.uid))  ;
  setState(() {
    followUnfollow = false;
  });
          }





        },
          child: Container(
            width: w * 0.22,
            height: w * 0.08,
            decoration: BoxDecoration(
              color: Constant().secondary,

              borderRadius: BorderRadius.circular(
                  w * 0.01),

            ),
            child: Center(
              child: followUnfollow ? Text("Unfollow",style: TextStyle(color: Constant().color),) : Text("Follow",style: TextStyle(color: Constant().color)),
            ),

          ),
        )

      ],),
  );

  }
}
class MyLoginCard extends StatefulWidget {
  int index;
  List<UsersModel> data;
  MyLoginCard({required this.index,required this.data});

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
          border: Border(bottom:BorderSide(color:Constant().secondary))



      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0,bottom:20 ),
            child: Center(
              child: Text(".",
                style: TextStyle(
                    fontWeight: FontWeight.bold,fontSize: 50,color: Constant().secondary),),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: CircleAvatar(
              backgroundColor: Constant().secondary,
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
            child: Container(
              width: w * 0.45,
              child: Column(
                mainAxisAlignment: MainAxisAlignment
                    .center,
                crossAxisAlignment: CrossAxisAlignment
                    .start,
                children: [
                  Text(widget.data[widget.index].name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,color: Constant().secondary),),
                  Text(widget.data[widget.index].email,
                    style: TextStyle(color: Constant().secondary,
                        fontSize: w * 0.027),)
                ],
              ),
            ),
          ),


        ],),
    );


  }
}
class CommentCard extends StatefulWidget {
  List<MediaModel>mdata;
  int mindex;
  int index;
  List<UsersModel>udata;



  CommentCard({required this.mdata,required this.mindex,required this.udata,required this.index,});

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

    return Container(

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
            child: Container(
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
                            color: Constant().secondary),),
                      SizedBox(width: w*0.025,),
                      Text(getTimeAgo(widget.mdata[widget.mindex].comment[widget.index]["commentDate"]),style: TextStyle(
                         color: Colors.grey),)
                    ],
                  ),
                  Text(widget.mdata[widget.mindex].comment[widget.index]["comment"],
                    style: TextStyle(color: Constant().secondary,
                        fontSize: w * 0.045),)
                ],
              ),
            ),
          ),


        ],),
    );
  }
}

