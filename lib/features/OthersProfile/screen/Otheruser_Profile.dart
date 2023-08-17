import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task4/features/Auth/auth_controller.dart';
import 'package:task4/features/Social/screen/OthersFollowfollowers.dart';
import 'package:task4/features/OthersProfile/screen/OthersPost.dart';
import 'package:task4/features/Social/screen/OthersFollowFollowing.dart';
import '../../../Core/Constant/ColorConstant/ColorConstant.dart';

import '../../../ShakesProject/categoryItems.dart';
import '../../../models/UsersModel.dart';


class OtherUserProfile extends StatefulWidget {
  List <UsersModel> data;
  OtherUserProfile({super.key, required this.data});

  @override
  State<OtherUserProfile> createState() => _OtherUserProfileState();
}

class _OtherUserProfileState extends State<OtherUserProfile> with SingleTickerProviderStateMixin{
  int postCount=0;
  postcount ()async {
    var post = FirebaseFirestore.instance.collection('media').
    where('uid', isEqualTo: widget.data[0].uid).snapshots().listen((event) {
      postCount = event.size;
      setState(() {

      });
    });
  }
  bool followUnfollow=false;
  void alert(){
    showDialog(
        context: context, builder: (context) =>


    // RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    Stack(
        children: [  BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
          child: Container(
            color: ColorConstant().color.withOpacity(0.1),
          ),
        ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: CircleAvatar(
                radius: w*0.2,
                backgroundImage: NetworkImage(widget.data[0].profile),
              ),
            ),
          ),
        ])
    );
  }
  late TabController _tabController;
  AuthController obj=AuthController();
  getusermodel() async {
    usersModel = (await obj.getUser(FirebaseAuth.instance.currentUser!.uid));
  }
  @override
  void initState() {

    // TODO: implement initState
    _tabController=TabController(length: 1, vsync: this);
    super.initState();
    _tabController.addListener(() {
      setState(() {
        // postLength=postLength;
      });
    });
    getusermodel();
    postcount();

  }

  @override
  Widget build(BuildContext context) {
    bool followUnfollow=usersModel!.following.contains(widget.data[0].uid);
    var w=MediaQuery.sizeOf(context).width;
    var h=MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: ColorConstant().color,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: ColorConstant().secondary),
        backgroundColor: ColorConstant().color,
        title: Text(widget.data[0].name,style: TextStyle(color: ColorConstant().secondary),),
      ),
      body: Column(
        children: [Container(

          color: ColorConstant().color,
          child: Row(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(onTap: () {
                      alert();
                    },
                      child: CircleAvatar(

                        radius: w*0.11,
                        backgroundColor:ColorConstant().secondary,

                        child: CircleAvatar(
                          radius: w*0.101,
                          backgroundImage:NetworkImage(widget.data[0].profile),


                          // :

                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.data[0].name,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: ColorConstant().secondary),),
                  ),
                ],
              ),

              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8,top:4),
                    child: SizedBox(
                      width: w*0.2,
                      height: w*0.125,
                      child: TabBar(
                          indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(25)
                          ),
                          unselectedLabelColor: ColorConstant().color,
                          labelColor:ColorConstant().color,

                          controller: _tabController,
                          tabs:[ Column(
                            children: [
                              Text("$postCount",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: ColorConstant().secondary),),
                              Text("Posts",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: ColorConstant().secondary),)
                            ],
                          ),
                          ]),
                    ),
                  ),Padding(
                    padding: const EdgeInsets.only(left: 8.0,bottom: 8),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, CupertinoPageRoute(builder: (context) => OthersFollowFollowers(data: widget.data),));
                      },
                      child: SizedBox(
                        width: w*0.17,
                        child: Column(
                          children: [
                            Text("${widget.data[0].followers.length}",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: ColorConstant().secondary),),
                            Text("Followers",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: ColorConstant().secondary),)
                          ],
                        ),
                      ),
                    ),

                  ),
                  const SizedBox(width: 18,),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0,bottom: 8),
                    child: InkWell(onTap: () {
                      Navigator.push(context, CupertinoPageRoute(builder: (context) => OthersFollowFollowing(data: widget.data),));
                    },
                      child: SizedBox(
                        width: w*0.17,
                        child: Column(
                          children: [
                            Text("${widget.data[0].following.length}",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: ColorConstant().secondary),),
                            Text("Following",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: ColorConstant().secondary),)
                          ],
                        ),
                      ),
                    ),

                  ),
                ],
              ),





            ],
          ),
        ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 8.0),
          //   child: Container(
          //     width: w,
          //     height: h*0.06,
          //     child:TabBar(
          //       unselectedLabelColor: Colors.grey,
          //       labelColor: Colors.blue,
          //       controller: _tabController,
          //         tabs: [
          //       Tab(child: Text("Posts",style: TextStyle(fontSize: w*0.04),),),
          //       Tab(
          //         child: Text("Followers",style: TextStyle(fontSize:w*.04),),),
          //       Tab(child: Text("Following",style: TextStyle(fontSize: w*.04),),),
          //     ]),
          //
          //   ),
          // ),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(onTap: () async{


                // if (followUnfollow == true) {
                  if (!widget.data[0].followers.contains(
                      usersModel!.uid))  {


                    // usersModel = (obj.getUser(widget.data[widget.index].uid));
                    widget.data[0].followers.add(usersModel!.uid);
                    List updatefollower = widget.data[0].followers;

                    usersModel=await(obj.getUser(widget.data[0].uid))  ;

                    var updateData = usersModel!.copyWith(
                        followers: updatefollower);
                   usersModel!.ref!.update(
                        updateData.toJson());
                    usersModel=await(obj.getUser(FirebaseAuth.instance.currentUser!.uid))  ;


                  if (!usersModel!.following.contains(
                      widget.data[0].uid))  {


                    // usersModel = (obj.getUser(widget.data[widget.index].uid));
                    usersModel!.following.add(widget.data[0].uid);
                    List updatefollower = usersModel!.following;

                    usersModel=await(obj.getUser(usersModel!.uid))  ;

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


                  // if (widget.data[0].followers.contains(
                  //     usersModel!.uid)) {
                    widget.data[0].followers.remove(usersModel!.uid);
                    usersModel = (await obj.getUser(widget.data[0].uid));
                var updateData = usersModel!.copyWith(
                followers: widget.data[0].followers);
                usersModel!.ref!.update(
                updateData.toJson());
                usersModel=await(obj.getUser(FirebaseAuth.instance.currentUser!.uid))  ;
                if (usersModel!.following.contains(
                widget.data[0].uid) ) {
                usersModel = (await obj.getUser(usersModel!.uid));
              usersModel!.following.remove(widget.data[0].uid);
                var updateData = usersModel!.copyWith(
                following: usersModel!.following
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
                  width: w*0.4,
                  height: w*0.1,
                  decoration: BoxDecoration(
                    color: ColorConstant().ternary,borderRadius: BorderRadius.circular(w*0.01),

                  ),
                  child: Center(
                    child: followUnfollow?Text("Unfollow",style: TextStyle(color: ColorConstant().secondary,
                        fontWeight: FontWeight.bold
                    ),):Text("follow",style: TextStyle(color: ColorConstant().secondary,
                        fontWeight: FontWeight.bold
                    ),),
                  ),

                ),
              ),
              SizedBox(width: w*0.06,),
              Container(
                width: w*0.4,
                height: w*0.1,
                decoration: BoxDecoration(
                  color: ColorConstant().ternary,borderRadius: BorderRadius.circular(w*0.01),

                ),
                child: Center(
                  child: Text(" Share profile",style: TextStyle(color: ColorConstant().secondary,
                      fontWeight: FontWeight.bold
                  ),),
                ),

              ),
            ],
          ),
          SizedBox(
            height: w*0.05,
          ),

          Expanded(
            child: TabBarView(controller: _tabController,
                children:[
                  OthersPost(data: widget.data)

                ] ),
          ),


        ],
      ),

    );
  }
}
