
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task4/models/UsersModel.dart';
import '../../../Core/Constant/ColorConstant/ColorConstant.dart';

import '../../Auth/auth_controller.dart';
var w;
var h;
class LoginCard extends StatefulWidget {
 int index;
 var inx;
 List<UsersModel> data;
 var useruid;
  LoginCard({super.key, required this.index,required this.useruid,required this.data,required this.inx});

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
              color: ColorConstant().secondary,

              borderRadius: BorderRadius.circular(
                  w * 0.01),

            ),
            child: Center(
              child: followUnfollow ? Text("Unfollow",style: TextStyle(color: ColorConstant().color),) : Text("Follow",style: TextStyle(color: ColorConstant().color)),
            ),

          ),
        )

      ],),
  );

  }
}

