import 'dart:ui';
import '../../../Core/Constant/ColorConstant/ColorConstant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task4/features/Social/screen/FollowFollowing.dart';
import 'package:task4/features/Social/screen/Followfollowers.dart';
import 'package:task4/features/UserProfile/screen/MyPosts.dart';
import 'package:task4/features/UserProfile/screen/ProfileEdit.dart';

import '../../../ShakesProject/categoryItems.dart';
import '../../../models/UsersModel.dart';
import '../../Post/screen/AddToPost.dart';

class Myprofile extends StatefulWidget {
  const Myprofile({super.key});

  @override
  State<Myprofile> createState() => _MyprofileState();
}

class _MyprofileState extends State<Myprofile> with SingleTickerProviderStateMixin{
  void showCupertinoActionSheet(BuildContext context) {
    showCupertinoModalPopup(

      context: context,
      builder: (BuildContext context) {

        return CupertinoActionSheet(
          title: const Text('Create',style: TextStyle(color: Colors.black),),
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: Row(
                children: [
                  const Icon(Icons.filter_tilt_shift_sharp),
                  SizedBox(width: w*0.05,),
                  const Text('Story',style: TextStyle(color: Colors.black),),
                ],
              ),
              onPressed: () {
                // Add your action logic here
                Navigator.pop(context);
              },
            ),
            CupertinoActionSheetAction(
              child: Row(
                children: [
                  const Icon(Icons.grid_on),
                  SizedBox(width: w*0.05,),
                  const Text('Post',style: TextStyle(color: Colors.black)),
                ],
              ),
              onPressed: () {
                // Add your action logic here
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => const AddToPost()),
                );
              },
            ),
            // Add more actions as needed
          ],
          cancelButton: CupertinoActionSheetAction(
            child: const Text('Cancel',style: TextStyle(color: Colors.black),),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }


  int postCount=0;
  postcount ()async {
    var post = FirebaseFirestore.instance.collection('media').
    where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots().listen((event) {
      postCount = event.size;
      setState(() {

      });
    });
  }
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
          backgroundImage: NetworkImage(usersModel!.profile),
            ),
  ),
    ),
])
    );
  }
  late TabController _tabController;

  @override
  void initState() {
    _tabController=TabController(length: 1, vsync: this);
    super.initState();
    _tabController.addListener(() {
    });
    postcount();

  }
  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.sizeOf(context).width;
    var h=MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: ColorConstant().color,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: ColorConstant().secondary),
        backgroundColor: ColorConstant().color,
        title: Text("MyProfile",style: TextStyle(color: ColorConstant().secondary),),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: InkWell(onTap: () {
              showCupertinoActionSheet(context);
            },
                child: Icon(Icons.add_box_outlined,size: w*0.08,)),
          )
        ],
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
                        backgroundColor: ColorConstant().secondary,

                        child: CircleAvatar(
                          radius: w*0.101,
                          backgroundImage:NetworkImage(usersModel!.profile),


                          // :

                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(usersModel!.name,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: ColorConstant().secondary),),
                  ),
                ],
              ),
              const SizedBox(width: 10,),
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
                        labelColor: ColorConstant().color,

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
                        Navigator.push(context, CupertinoPageRoute(builder: (context) => const Followfollower(),));
                      },
                      child: SizedBox(
                        width: w*0.17,
                        child: Column(
                          children: [
                            Text("${usersModel!.followers.length}",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: ColorConstant().secondary),),
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
                      Navigator.push(context, CupertinoPageRoute(builder: (context) => const FollowFollowing(),));
                    },
                      child: SizedBox(
                        width: w*0.17,
                        child: Column(
                          children: [
                            Text("${usersModel!.following.length}",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: ColorConstant().secondary),),
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
              InkWell(onTap: () {
                Navigator.push(context, CupertinoPageRoute(builder: (context) => const ProfileEdit(),));
              },
                child: Container(
                  width: w*0.4,
                  height: w*0.1,
                  decoration: BoxDecoration(
                    color: ColorConstant().ternary,borderRadius: BorderRadius.circular(w*0.01),

                  ),
                  child: Center(
                    child: Text("Edit profile",style: TextStyle(color: ColorConstant().secondary,
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
                children:const [
                  MyPosts()

            ] ),
          ),


        ],
      ),

    );
  }
}
