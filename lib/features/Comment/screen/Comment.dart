import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task4/models/CommentModel.dart';

import '../../../Core/Constant/FirebaseConstant/FireBaseConstants.dart';
import '../widget/CommentCard.dart';
import '../../../models/UsersModel.dart';
import '../../../models/mediaModel.dart';
import '../../Auth/auth_controller.dart';
import '../../../Core/Constant/ColorConstant/ColorConstant.dart';
var w;
var h;
class CommentPage extends StatefulWidget {
  List<MediaModel> data;
  int index;

  CommentPage({super.key, required this.index, required this.data,});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  Stream<List<CommentModel>> commentStream() {
    return FirebaseFirestore.instance.collection(FireBaseConstant.mediaCollection).doc(widget.data[widget.index].mid)
        .collection(FireBaseConstant.commentCollection)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => CommentModel.fromJson(
                  doc.data(),
                ))
            .toList());
  }

  bool appbar = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController comment = TextEditingController();
  late CommentModel deletindex;

  AuthController obj = AuthController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    comment.dispose();
  }

  bool select = false;

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.sizeOf(context).width;
    h = MediaQuery.sizeOf(context).height;
    return widget.data[widget.index].uid !=
            FirebaseAuth.instance.currentUser!.uid
        ? Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: ColorConstant().ternary,
            appBar: appbar
                ? AppBar(
                    elevation: 0,
                    backgroundColor: Colors.blue,
                    automaticallyImplyLeading: false,
                    title: const Text("Selected"),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: InkWell(
                            onTap: () async {
                              deletindex.ref!.delete();
                              //  widget.data[widget.index].comment.removeAt(deletindex);
                              //  mediaModel=await(obj.getUserMedia(widget.data[widget.index].mid))  ;
                              //
                              //  var updateData = mediaModel!.copyWith(
                              //      comment: widget.data[widget.index].comment);
                              //  // FirebaseFirestore.instance.collectionGroup(collectionPath)
                              // mediaModel!.ref!.update(
                              //      updateData.toJson());
                              setState(() {
                                appbar = false;
                              });
                              final snackBar = SnackBar(
                                content: Text(
                                  "Comment deleted",
                                  style: TextStyle(color: ColorConstant().secondary),
                                ),
                                backgroundColor: ColorConstant().color,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            },
                            child: const Icon(Icons.delete_outline)),
                      )
                    ],
                  )
                : AppBar(
                    automaticallyImplyLeading: false,
                    elevation: 0,
                    backgroundColor: ColorConstant().ternary,
                    centerTitle: true,
                    title: const Text("Comments"),
                  ),
            body: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Container(
                //   color: Colors.grey.shade900,
                //   width: w,
                //   height: w*0.15,
                //   child: Row(mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Text("Comments",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                //     ],
                //   ),
                // ),
                Expanded(
                  child: StreamBuilder(
                      stream: commentStream(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<CommentModel> commentdata = snapshot.data!;
                          return Container(
                            width: w,
                            height: h * 0.78,
                            decoration: BoxDecoration(
                              color: ColorConstant().ternary,
                            ),
                            child: ListView.builder(
                                itemCount: commentdata.length,
                                itemBuilder: (context, index) {
                                  var id = commentdata[index].uid;

                                  return StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection(
                                              FireBaseConstant.userCollection)
                                          .where("uid", isEqualTo: id)
                                          .snapshots()
                                          .map((snapshot) => snapshot.docs
                                              .map((doc) => UsersModel.fromJson(
                                                    doc.data(),
                                                  ))
                                              .toList()),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          List<UsersModel> data =
                                              snapshot.data!;
                                          if (commentdata[index].uid ==
                                              FirebaseAuth
                                                  .instance.currentUser!.uid) {
                                            return InkWell(
                                              onLongPress: () {
                                                setState(() {
                                                  select = !select;
                                                  appbar = !appbar;
                                                });
                                                if (select) {
                                                  deletindex =
                                                      commentdata[index];
                                                }
                                              },
                                              child: Column(
                                                children: [
                                                  Container(
                                                    child: CommentCard(
                                                      mdata: commentdata,
                                                      udata: data,
                                                      index: index,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: w * 0.02,
                                                  )
                                                ],
                                              ),
                                            );
                                          } else {
                                            return Column(
                                              children: [
                                                Container(
                                                  child: CommentCard(
                                                    mdata: commentdata,
                                                    udata: data,
                                                    index: index,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: w * 0.02,
                                                )
                                              ],
                                            );
                                          }
                                        } else {
                                          return SizedBox(
                                              width: w * 0.025,
                                              height: w * 0.025,
                                              child:
                                                  const CircularProgressIndicator());
                                        }
                                      });
                                }),
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      }),
                ),
                Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: formKey,
                  child: Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: Container(
                      color: ColorConstant().ternary,
                      width: w,
                      height: w * 0.2,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: CircleAvatar(
                              radius: w * 0.055,
                              backgroundImage: CachedNetworkImageProvider(
                                  usersModel!.profile),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: SizedBox(
                              width: w * 0.7,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "";
                                  }
                                  return null;
                                },
                                controller: comment,
                                style: TextStyle(color: ColorConstant().secondary),
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Add a comment...",
                                    hintStyle: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ),
                          InkWell(
                              onTap: () async {
                                final val = formKey.currentState!.validate();
                                if (val) {
                                  var c = CommentModel(
                                      uid: FirebaseAuth
                                          .instance.currentUser!.uid,
                                      cid: "",
                                      comment: comment.text,
                                      commentDate: Timestamp.now());
                                  // Map a = {"uid": FirebaseAuth.instance.currentUser!.uid,
                                  //   "commentDate": Timestamp.now(),
                                  //   "comment": comment.text,
                                  //
                                  // };
                                  // usersModel = (obj.getUser(widget.data[widget.index].uid));
                                  FirebaseFirestore.instance
                                      .collection(
                                          FireBaseConstant.mediaCollection)
                                      .doc(widget.data[widget.index].mid)
                                      .collection(
                                          FireBaseConstant.commentCollection)
                                      .add(c.toJson())
                                      .then((value) async {
                                    commentModel =
                                        await obj.getUserComment(widget.data[widget.index].mid,value.id);
                                    var b = c
                                        .copyWith(cid: value.id, ref: value);
                                    value.update(b.toJson());
                                  });

                                  comment.clear();
                                  setState(() {});
                                }
                              },
                              child: const Icon(
                                Icons.send,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        : Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: ColorConstant().ternary,
            appBar: appbar
                ? AppBar(
                    elevation: 0,
                    backgroundColor: Colors.blue,
                    automaticallyImplyLeading: false,
                    title: const Text("Selected"),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: InkWell(
                            onTap: () async {
                              deletindex.ref!.delete();
                              //  widget.data[widget.index].comment.removeAt(deletindex);
                              //  mediaModel=await(obj.getUserMedia(widget.data[widget.index].mid))  ;
                              //
                              //  var updateData = mediaModel!.copyWith(
                              //      comment: widget.data[widget.index].comment);
                              //  // FirebaseFirestore.instance.collectionGroup(collectionPath)
                              // mediaModel!.ref!.update(
                              //      updateData.toJson());
                              setState(() {
                                appbar = false;
                              });
                              final snackBar = SnackBar(
                                content: const Text("Comment deleted"),
                                backgroundColor: ColorConstant().secondary,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            },
                            child: const Icon(Icons.delete_outline)),
                      )
                    ],
                  )
                : AppBar(
                    automaticallyImplyLeading: false,
                    elevation: 0,
                    backgroundColor: ColorConstant().ternary,
                    centerTitle: true,
                    title: const Text("Comments"),
                  ),
            body: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                // Container(
                //   color: Colors.grey.shade900,
                //   width: w,
                //   height: w*0.15,
                //   child: Row(mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Text("Comments",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                //     ],
                //   ),
                // ),
                Expanded(
                  child: StreamBuilder(
                      stream: commentStream(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<CommentModel> commentdata = snapshot.data!;
                          return Container(
                            width: w,
                            height: h * 0.78,
                            decoration: BoxDecoration(
                              color: ColorConstant().ternary,
                            ),
                            child: ListView.builder(
                                itemCount: commentdata.length,
                                itemBuilder: (context, index) {

                                  var id = commentdata[index].uid;

                                  return StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection(
                                              FireBaseConstant.userCollection)
                                          .where("uid", isEqualTo: id)
                                          .snapshots()
                                          .map((snapshot) => snapshot.docs
                                              .map((doc) => UsersModel.fromJson(
                                                    doc.data(),
                                                  ))
                                              .toList()),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          List<UsersModel> data =
                                              snapshot.data!;

                                          return InkWell(
                                            onLongPress: () {
                                              setState(() {
                                                appbar = !appbar;
                                              });

                                              deletindex = commentdata[index];
                                            },
                                            child: Column(
                                              children: [
                                                Container(
                                                  child: CommentCard(
                                                    mdata: commentdata,
                                                    udata: data,
                                                    index: index,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: w * 0.02,
                                                )
                                              ],
                                            ),
                                          );
                                        } else {
                                          return SizedBox(
                                              width: w * 0.025,
                                              height: w * 0.025,
                                              child:
                                                  const CircularProgressIndicator());
                                        }
                                      });
                                }),
                          );
                        } else {
                          return const Center(child: Text("No Comment yet!"));
                        }
                      }),
                  // child: Container(
                  //
                  //   width: w,
                  //   height: h*0.78,
                  //   decoration: BoxDecoration(
                  //     color: Constant().ternary,
                  //   ),
                  //   child:
                  //
                  //   ListView.builder(
                  //       itemCount: widget.data[widget.index].comment.length,
                  //       itemBuilder: (context, index) {
                  //
                  //
                  //
                  //         var id=widget.data[widget.index].comment[index]["uid"];
                  //
                  //         return StreamBuilder(
                  //
                  //             stream:  FirebaseFirestore.instance
                  //                 .collection(FireBaseConstant.userCollection).where("uid",isEqualTo: id)
                  //                 .snapshots()
                  //                 .map((snapshot) => snapshot.docs
                  //                 .map((doc) => UsersModel.fromJson(
                  //               doc.data(),
                  //             ))
                  //                 .toList()),
                  //
                  //             builder: (context, snapshot) {
                  //
                  //               if (snapshot.hasData) {
                  //
                  //                 List<UsersModel> data = snapshot.data!;
                  //
                  //
                  //                   return InkWell(onLongPress: () {
                  //                     setState(() {
                  //                       appbar=!appbar;
                  //                     });
                  //
                  //                       deletindex=index;
                  //
                  //
                  //                   },
                  //                     child: Column(
                  //                       children: [
                  //                         Container(
                  //
                  //                           child: CommentCard(mdata: widget.data,
                  //                             mindex: widget.index,
                  //                             udata: data,
                  //                             index: index,),
                  //                         ),
                  //                         SizedBox(
                  //                           height: w*0.02,
                  //                         )
                  //                       ],
                  //                     ),
                  //
                  //                   );
                  //
                  //               }
                  //               else {
                  //
                  //                 return Container(
                  //                     width: w*0.025,
                  //                     height: w*0.025,
                  //                     child: CircularProgressIndicator());
                  //               }});
                  //       }
                  //
                  //   ),
                  // ),
                ),
                Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: formKey,
                  child: Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: Container(
                      color: ColorConstant().ternary,
                      width: w,
                      height: w * 0.2,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: CircleAvatar(
                              radius: w * 0.055,
                              backgroundImage: CachedNetworkImageProvider(
                                  usersModel!.profile),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: SizedBox(
                              width: w * 0.7,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "";
                                  }
                                  return null;
                                },
                                controller: comment,
                                style: TextStyle(color: ColorConstant().secondary),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Add a comment...",
                                    hintStyle:
                                        TextStyle(color: ColorConstant().secondary)),
                              ),
                            ),
                          ),
                          InkWell(
                              onTap: () async {
                                final val = formKey.currentState!.validate();
                                if (val) {
                                  var c = CommentModel(
                                      uid: FirebaseAuth
                                          .instance.currentUser!.uid,
                                      cid: "",
                                      comment: comment.text,
                                      commentDate: Timestamp.now());
                                  // Map a = {"uid": FirebaseAuth.instance.currentUser!.uid,
                                  //   "commentDate": Timestamp.now(),
                                  //   "comment": comment.text,
                                  //
                                  // };
                                  // usersModel = (obj.getUser(widget.data[widget.index].uid));
                                  FirebaseFirestore.instance
                                      .collection(
                                          FireBaseConstant.mediaCollection)
                                      .doc(widget.data[widget.index].mid)
                                      .collection(
                                          FireBaseConstant.commentCollection)
                                      .add(c.toJson())
                                      .then((value) async {
                                    commentModel =
                                        await obj.getUserComment(widget.data[widget.index].mid,value.id);
                                    var b = commentModel!
                                        .copyWith(cid: value.id, ref: value);
                                    value.update(b.toJson());
                                  });

                                  comment.clear();
                                  setState(() {});
                                }
                              },
                              child: Icon(
                                Icons.send,
                                color: ColorConstant().secondary,
                              ))
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
