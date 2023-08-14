import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task4/auth/screens/OthersSinglePost.dart';

import '../../Constant/FireBaseConstants.dart';
import '../../models/UsersModel.dart';
import '../../models/mediaModel.dart';
import 'SinglePost.dart';

class OthersPost extends StatefulWidget {
  List<UsersModel>data;
  OthersPost({required this.data});

  @override
  State<OthersPost> createState() => _OthersPostState();
}

class _OthersPostState extends State<OthersPost> {
  int? otherpost;
  var inx;
  Stream<List<MediaModel>> userStream() {
    return FirebaseFirestore.instance
        .collection(FireBaseConstant.mediaCollection).where("uid",isEqualTo: widget.data[0].uid)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => MediaModel.fromJson(
      doc.data(),
    ))
        .toList());
  }
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      otherpost=otherpost;
    });
  }
  @override
  Widget build(BuildContext context) {
   var w = MediaQuery
        .sizeOf(context)
        .width;
    var h = MediaQuery
        .sizeOf(context)
        .height;

    return Scaffold(
      body:  Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: BoxDecoration(
            color: Constant().color,
            border: Border(top: BorderSide(color: Constant().secondary))
        ),

        child: StreamBuilder(
            stream: userStream(),
            builder: (context, snapshot) {

              print(snapshot);
              if (snapshot.hasData) {


                List<MediaModel> data = snapshot.data!;
                otherpost=data.length;
                return Column(
                    children: [

                      Expanded(
                          child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,crossAxisSpacing: w*0.01,mainAxisSpacing: w*0.01), itemBuilder: (context, index) {

                            return InkWell(onTap: () {
                              Navigator.push(context, CupertinoPageRoute(builder: (context) =>OtherSinglePost(image: data[index].image, postDate: data[index].postDate, description: data[index].description,data:data,index: index),));
                            },
                              child: Container(
                                child: CachedNetworkImage(
                                  imageUrl: data[index].image, fit: BoxFit.fill,),
                              ),
                            );


                          },itemCount: data.length,)

                      )]); }
              else {
                return
                  CircularProgressIndicator();
              }
            }),
      ),


    );
  }
}
