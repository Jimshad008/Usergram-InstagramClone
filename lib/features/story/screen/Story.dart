import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task4/features/story/screen/UserStoryReview.dart';
import 'package:task4/models/StoryModel.dart';

import '../../../Core/Constant/FirebaseConstant/FireBaseConstants.dart';
import '../../../models/UsersModel.dart';
import 'add story.dart';

class StoryPage extends StatefulWidget {
  const StoryPage({super.key});

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {



  Stream<List<StoryModel>> storyStream() {
    return FirebaseFirestore.instance.collectionGroup(FireBaseConstant.storyCollection).orderBy("storyDate",descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => StoryModel.fromJson(
      doc.data(),
    ))
        .toList());
  }
  @override
  Widget build(BuildContext context) {

    var w = MediaQuery
        .sizeOf(context)
        .width;
    var h = MediaQuery
        .sizeOf(context)
        .height;

    return StreamBuilder(
      stream: storyStream(),
      builder: (context, snapshot) {
        print(snapshot.error);
        if(snapshot.hasData){
          // List<StoryModel>?storydataModi=[];
          List storyuid=[FirebaseAuth.instance.currentUser!.uid];
          bool count=false;
          //   StoryModel? a;
          List<StoryModel>?storydata=snapshot.data!;
          // for(int i=0;i<storydata.length;i++){
          //   if(storydata[i].uid==FirebaseAuth.instance.currentUser!.uid){
          //     a=storydata[i];
          //     storydataModi![0]=a!;
          //     storydataModi=storydataModi+storydata;
          //     break;
          //   }
          // }

          // storydata=storydataModi;



          return Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: SizedBox(
              width: w,
              height: h*0.1,
              child:ListView.builder(scrollDirection: Axis.horizontal,itemCount:storydata.length+1,itemBuilder: (context, index) {
                for(int i=0;i<storydata.length;i++){
                  if(storydata[i].uid==FirebaseAuth.instance.currentUser!.uid){
                    count=true;
                    break;
                  }
                }
       if(index==0){
         if(count){
         return Stack(
           children:[
             Column(crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               Row(
                 children: [
                   CircleAvatar(backgroundColor: Colors.red,
                       radius: w * 0.090,

                       child: InkWell(onTap:() {
                         Navigator.push(context, CupertinoPageRoute(builder: (context) => UserStoryReview(data: storydata, index: index),));
                       },
                         child: CircleAvatar(radius: w * 0.086,
                           backgroundImage: CachedNetworkImageProvider(
                               usersModel!.profile),),
                       )),
                   const SizedBox(width: 8,)
                 ],
               ),
               const Text("Your Story",
                 style: TextStyle(color: Colors.white),),
             ],
           ),
             Positioned(top: w*0.12,
                 left:w*0.12,
                 child: InkWell(onTap: () {
                   Navigator.push(context, CupertinoPageRoute(builder: (context) => const AddaStory(),));
                 },
                     child: CircleAvatar(backgroundColor: Colors.black,radius: w*0.035,
                         child: CircleAvatar(radius:w*0.03,backgroundColor: Colors.blue,child: Icon(CupertinoIcons.add,color: Colors.white,size: w*0.03,weight: 2,),)))),
    ]
         );
         }
         else{
          return Column(crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               Row(
                 children: [
                   InkWell(onTap: () {
                     Navigator.push(context, CupertinoPageRoute(builder: (context) => const AddaStory(),));
                   },
                     child: CircleAvatar(backgroundColor: Colors.red,
                         radius: w * 0.090,

                         child: CircleAvatar(radius: w * 0.086,
                           backgroundImage: CachedNetworkImageProvider(
                               usersModel!.profile),
                         child: const Icon(CupertinoIcons.add,color: Colors.white,),)),
                   ),
                   const SizedBox(width: 8,)
                 ],
               ),
               const Text("Your Story",
                 style: TextStyle(color: Colors.white),),
             ],
           );
         }
         }

                // print("2222222222222222222222222222222222222222222");
                // print(storyuid);
                else{
         if(!storyuid.contains(storydata[index-1].uid)) {
           storyuid.add(storydata[index-1].uid);



           return Column(crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               Row(
                 children: [
                   CircleAvatar(backgroundColor: Colors.red,
                       radius: w * 0.090,

                       child: CircleAvatar(radius: w * 0.086,
                         backgroundImage: CachedNetworkImageProvider(
                             storydata[index-1].profile),)),
                   const SizedBox(width: 8,)
                 ],
               ),
               Text(storydata[index-1].name,
                 style: const TextStyle(color: Colors.white),),
             ],
           )
           ;
         }else{
           return Container();
         }

       }
        }
        )));
        }
        else{
          return const CircularProgressIndicator();
        }
      },

    );
  }
}
