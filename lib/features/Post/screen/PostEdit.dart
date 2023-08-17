import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task4/features/UserProfile/screen/MyProfile.dart';
import '../../../Core/Constant/ColorConstant/ColorConstant.dart';
import '../../../Core/Constant/FirebaseConstant/FireBaseConstants.dart';
import '../../../ShakesProject/categoryItems.dart';
import '../../../models/UsersModel.dart';
import '../../../models/mediaModel.dart';
import '../../Auth/auth_controller.dart';
import 'LikeAnimation.dart';

class PostEdit extends StatefulWidget {
  List <MediaModel> data;
  int index;
PostEdit({super.key, required this.index,required this.data});

  @override
  State<PostEdit> createState() => _PostEditState();
}

class _PostEditState extends State<PostEdit> {
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
  bool like=false;
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
  TextEditingController description = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    description =TextEditingController(text:(widget.data[widget.index].description) );
  }
  @override
  Widget build(BuildContext context) {
    w = MediaQuery
        .sizeOf(context)
        .width;
    h = MediaQuery
        .sizeOf(context)
        .height;
    return  Scaffold(
      backgroundColor: ColorConstant().color,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: ColorConstant().secondary),
        backgroundColor: ColorConstant().color,
        title:Text( "Edit info",style: TextStyle(color: ColorConstant().secondary),),
        leading: InkWell(onTap: () {
          Navigator.pop(context);
        },
            child: const Icon(Icons.clear)),
        actions: [

          InkWell(onTap: () async{
            mediaModel=await obj.getUserMedia(widget.data[widget.index].mid);
            var update=mediaModel!.copyWith(description: description.text);
           mediaModel!.ref!.update(update.toJson());
            Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => const Myprofile(),), (route) => false);
          },
              child: const Icon(Icons.check)),
          SizedBox(width: w*0.05,)
          ,
        ],
      ),

      body: StreamBuilder(
          stream: userStream(),
          builder: (context, snapshot) {

            if (snapshot.hasData) {
              // bool like=false;
              // bool like=widget.data[widget.index].likes.contains(FirebaseAuth.instance.currentUser!.uid);
              List<UsersModel> data = snapshot.data!;
              return Column(
                children: [
                  Container(
                    width: w,

                    decoration: BoxDecoration(
                      color: ColorConstant().secondary,


                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .start,
                      children: [
                        Container(
                          width: w,
                          height: w * 0.1,
                          color: ColorConstant().secondary,
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
                                    data[0].name,style: TextStyle(color: ColorConstant().secondary)
                                )
                              ],
                            ),
                          ),

                        ),
                        InkWell(
                          onDoubleTap: () {
                            setState(() {
                              like=!like;
                            });
                            // LikeAnimation();
                            // if(like == true){
                            //   if (!widget.data[widget.index].likes.contains(
                            //       loginId))  {
                            //
                            //
                            //     // usersModel = (obj.getUser(widget.data[widget.index].uid));
                            //     widget.data[widget.index].likes.add(loginId);
                            //
                            //
                            //     usersModel=await(obj.getUser(widget.data[widget.index].uid))  ;
                            //
                            //     var updateData = usersModel!.copyWith(
                            //         followers: updatefollower);
                            //     FirebaseFirestore.instance.collection(
                            //         FireBaseConstant.userCollection).doc(
                            //         widget.data[widget.index].uid).update(
                            //         updateData.toJson());
                            //     usersModel=await(obj.getUser(FirebaseAuth.instance.currentUser!.uid))  ;
                            //
                            //   }
                            // }
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
                          color: ColorConstant().color,

                          child: Padding(
                            padding: const EdgeInsets
                                .all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment
                                  .start,
                              children: [
                                Row(
                                  children: [
                                    InkWell(onTap: () {
                                      setState(() {
                                        like=!like;
                                      });
                                      // LikeAnimation();
                                    },
                                        child:like?const Icon(Icons
                                            .favorite,color: Colors.red,size: 30,): Icon(Icons
                                            .favorite_border_outlined,color: ColorConstant().secondary,size: 30,)
                                    ),
                                    SizedBox(
                                      width: w * 0.04,
                                    ),
                                    FaIcon(FontAwesomeIcons.comment,color: ColorConstant().secondary,size: 28,),
                                    SizedBox(
                                      width: w * 0.04,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: FaIcon(FontAwesomeIcons.paperPlane,color: ColorConstant().secondary,size: 25,),
                                    )
                                  ],
                                ), Row(
                                  children: [
                                    Text(
                                      data[0].name,
                                      style: TextStyle(
                                          fontWeight: FontWeight
                                              .bold,color:ColorConstant().secondary),),
                                    Padding(
                                      padding: const EdgeInsets
                                          .all(8.0),
                                      child: SizedBox(
                                        width: w*0.6,
                                        child: TextFormField(
                                          controller: description,
                                          style: TextStyle(color: ColorConstant().secondary),
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                           hintText: "",
                                          ),
                                        ),
                                      )
                                      // Text(
                                      //     widget.data[widget.index]
                                      //         .description,style: TextStyle(color: Colors.white)),
                                    ),
                                  ],
                                ),
                                Padding(
                                    padding: const EdgeInsets
                                        .only(top: 10.0),
                                    child: Text(
                                      getTimeAgo(widget.data[widget.index].postDate.toDate()),
                                      style: TextStyle(color: ColorConstant().secondary),
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
              return const CircularProgressIndicator();
            }
          }
      ),
    );
  }
}
