import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task4/auth/screens/FollowFollowing.dart';
import 'package:task4/auth/screens/FollowerList.dart';
import 'package:task4/auth/screens/Followfollowers.dart';
import 'package:task4/auth/screens/FollowingList.dart';
import 'package:task4/auth/screens/MyPosts.dart';
import 'package:task4/auth/screens/ProfileEdit.dart';
import 'package:task4/auth/screens/UsergramUsers.dart';

import '../../Constant/FireBaseConstants.dart';
import '../../categoryItems.dart';
import '../../models/UsersModel.dart';

class Myprofile extends StatefulWidget {
  const Myprofile({super.key});

  @override
  State<Myprofile> createState() => _MyprofileState();
}

class _MyprofileState extends State<Myprofile> with SingleTickerProviderStateMixin{

  int postCount=0;
  postcount ()async {
    var post = await FirebaseFirestore.instance.collection('media').
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
      color: Constant().color.withOpacity(0.1),
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
      backgroundColor: Constant().color,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Constant().secondary),
        backgroundColor: Constant().color,
        title: Text("MyProfile",style: TextStyle(color: Constant().secondary),),
      ),
      body: Column(
        children: [Container(

          color: Constant().color,
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
                        backgroundColor: Constant().secondary,

                        child: CircleAvatar(
                          radius: w*0.101,
                          backgroundImage:NetworkImage(usersModel!.profile),


                          // :

                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(usersModel!.name,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Constant().secondary),),
                  ),
                ],
              ),
              SizedBox(width: 10,),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8,top:4),
                    child: Container(
                              width: w*0.2,
                      height: w*0.125,
                      child: TabBar(
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(25)
                        ),
                          unselectedLabelColor: Constant().color,
                        labelColor: Constant().color,

                        controller: _tabController,
                          tabs:[ Column(
                               children: [
                                 Text("${postCount}",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Constant().secondary),),
                                 Text("Posts",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Constant().secondary),)
                               ],
                        ),
                      ]),
                    ),
                  ),Padding(
                    padding: const EdgeInsets.only(left: 8.0,bottom: 8),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, CupertinoPageRoute(builder: (context) => Followfollower(),));
                      },
                      child: Container(
                        width: w*0.17,
                        child: Column(
                          children: [
                            Text("${usersModel!.followers.length}",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Constant().secondary),),
                            Text("Followers",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Constant().secondary),)
                          ],
                        ),
                      ),
                    ),

                  ),
                  SizedBox(width: 18,),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0,bottom: 8),
                    child: InkWell(onTap: () {
                      Navigator.push(context, CupertinoPageRoute(builder: (context) => FollowFollowing(),));
                    },
                      child: Container(
                        width: w*0.17,
                        child: Column(
                          children: [
                            Text("${usersModel!.following.length}",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Constant().secondary),),
                            Text("Following",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Constant().secondary),)
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
                Navigator.push(context, CupertinoPageRoute(builder: (context) => ProfileEdit(),));
              },
                child: Container(
                  width: w*0.4,
                  height: w*0.1,
                  decoration: BoxDecoration(
                    color: Constant().ternary,borderRadius: BorderRadius.circular(w*0.01),

                  ),
                  child: Center(
                    child: Text("Edit profile",style: TextStyle(color: Constant().secondary,
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
                  color: Constant().ternary,borderRadius: BorderRadius.circular(w*0.01),

                ),
                child: Center(
                  child: Text(" Share profile",style: TextStyle(color: Constant().secondary,
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
                  MyPosts()

            ] ),
          ),


        ],
      ),

    );
  }
}
