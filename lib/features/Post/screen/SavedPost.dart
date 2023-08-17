import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task4/models/UsersModel.dart';
import '../../../Core/Constant/ColorConstant/ColorConstant.dart';
import '../../../Core/Constant/FirebaseConstant/FireBaseConstants.dart';
import '../../../models/mediaModel.dart';
import '../../Auth/auth_controller.dart';
import '../../OthersProfile/screen/OthersSinglePost.dart';

class Savedpost extends StatefulWidget {
  const Savedpost({super.key});

  @override
  State<Savedpost> createState() => _SavedpostState();
}

class _SavedpostState extends State<Savedpost> {
  AuthController obj=AuthController();
  getusermodel() async {
    usersModel = (await obj.getUser(FirebaseAuth.instance.currentUser!.uid));
  }


  // Stream<List<UsersModel>> userStream() {
  //   return FirebaseFirestore.instance
  //       .collection(FireBaseConstant.userCollection).where("uid",isEqualTo: FirebaseAuth.instance.currentUser!.uid)
  //       .snapshots()
  //       .map((snapshot) => snapshot.docs
  //       .map((doc) =>UsersModel.fromJson(
  //     doc.data(),
  //   ))
  //       .toList());
  // }
  // var mediaId;
  // Stream<List<MediaModel>> mediaStream() {
  //   return FirebaseFirestore.instance
  //       .collection(FireBaseConstant.mediaCollection).where("mid",isEqualTo: mediaId)
  //       .snapshots()
  //       .map((snapshot) => snapshot.docs
  //       .map((doc) =>MediaModel.fromJson(
  //     doc.data(),
  //   ))
  //       .toList());
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
getusermodel();
  }
  @override
  Widget build(BuildContext context) {var w = MediaQuery
      .sizeOf(context)
      .width;
  var h = MediaQuery
      .sizeOf(context)
      .height;


  return Scaffold(
    appBar: AppBar(
      elevation: 0,
      iconTheme: IconThemeData(color: ColorConstant().secondary),
      backgroundColor: ColorConstant().color,
      title: Text("Saved",style: TextStyle(color: ColorConstant().secondary),),
    ),
    body:  Container(
      width: double.maxFinite,
      height: double.maxFinite,
      decoration: BoxDecoration(
          color: ColorConstant().color,
          border: Border(top: BorderSide(color: ColorConstant().secondary))
      ),

      child:
      // StreamBuilder(
      //     stream: userStream(),
      //     builder: (context, snapshot) {
      //
      //       print(snapshot);
      //       if (snapshot.hasData) {
      //
      //
      //         List<UsersModel> data = snapshot.data!;
              Column(
                  children: [

                    Expanded(
                        child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: w*0.01,mainAxisSpacing: w*0.01), itemBuilder: (context, index) {

                          var mediaId=usersModel!.saved[index];


                            return StreamBuilder(
                              stream:FirebaseFirestore.instance
        .collection(FireBaseConstant.mediaCollection).where("mid",isEqualTo: mediaId)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) =>MediaModel.fromJson(
    doc.data(),
    ))
        .toList()),
                              builder: (context, snapshot) {
                                 if (snapshot.hasData) {


                                   List<MediaModel> Mdata = snapshot.data!;
                                      return InkWell(onTap: () {
                             Navigator.push(context, CupertinoPageRoute(
                                        builder: (context) =>
                                    OtherSinglePost(image: Mdata[0].image,
                                           postDate: Mdata[0].postDate,
                                         description: Mdata[0].description,
                                          data: Mdata,
                                       index: 0),));
                                             },
                                       child: Container(
                                        child: CachedNetworkImage(
                                      imageUrl: Mdata[0].image,
                                     fit: BoxFit.fill,),
                                 ),
                                       );
                              }else{
                                return
                                const CircularProgressIndicator();
                                 }
                              }

                            );



                        },itemCount: usersModel!.saved.length,)


  )
  ]),
    ),


  );
  }
}
