import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task4/features/OthersProfile/screen/OthersSinglePost.dart';
import '../../../Core/Constant/ColorConstant/ColorConstant.dart';
import '../../../Core/Constant/FirebaseConstant/FireBaseConstants.dart';
import '../../../models/UsersModel.dart';
import '../../../models/mediaModel.dart';


class OthersPost extends StatefulWidget {
  List<UsersModel>data;
  OthersPost({super.key, required this.data});

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
            color: ColorConstant().color,
            border: Border(top: BorderSide(color: ColorConstant().secondary))
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
                  const CircularProgressIndicator();
              }
            }),
      ),


    );
  }
}
