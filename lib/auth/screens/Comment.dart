import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../Constant/FireBaseConstants.dart';
import '../../models/UsersModel.dart';
import '../../models/mediaModel.dart';
import '../controller/auth_controller.dart';
import 'LoginCard.dart';

class CommentPage extends StatefulWidget {
  List<MediaModel>data;
  int index;
  CommentPage({required this.index,required this.data});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {

  bool appbar=false;
  final formKey=GlobalKey<FormState>();
  TextEditingController comment = TextEditingController();
  int deletindex=0;

  AuthController obj=AuthController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    comment.dispose();
  }

  bool select=false;

  @override
  Widget build(BuildContext context) {

    w = MediaQuery
        .sizeOf(context)
        .width;
    h = MediaQuery
        .sizeOf(context)
        .height;
    return widget.data[widget.index].uid!=FirebaseAuth.instance.currentUser!.uid?Scaffold(
      resizeToAvoidBottomInset: false,

      backgroundColor:Constant().ternary,
      appBar: appbar?AppBar(
        elevation: 0,
      backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
      title: Text("Selected"),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: InkWell(onTap: () async{

            widget.data[widget.index].comment.removeAt(deletindex);
            mediaModel=await(obj.getUserMedia(widget.data[widget.index].mid))  ;

            var updateData = mediaModel!.copyWith(
                comment: widget.data[widget.index].comment);
            // FirebaseFirestore.instance.collectionGroup(collectionPath)
           mediaModel!.ref!.update(
                updateData.toJson());
            setState(() {
              appbar=false;
            });
              final snackBar=SnackBar(content: Text("Comment deleted",style: TextStyle(color: Constant().secondary),),
                backgroundColor: Constant().color,


                );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);


          },child: Icon(Icons.delete_outline)),
        )
      ],
    ):AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Constant().ternary,
      centerTitle: true,
      title: Text("Comments"),
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
            child: Container(

              width: w,
              height: h*0.78,
              decoration: BoxDecoration(
                color: Constant().ternary,
              ),
              child:

                          ListView.builder(
                              itemCount: widget.data[widget.index].comment.length,
                              itemBuilder: (context, index) {


                                var id=widget.data[widget.index].comment[index]["uid"];

    return StreamBuilder(

    stream:  FirebaseFirestore.instance
        .collection(FireBaseConstant.userCollection).where("uid",isEqualTo: id)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => UsersModel.fromJson(
      doc.data(),
    ))
        .toList()),

    builder: (context, snapshot) {



                 if (snapshot.hasData) {

               List<UsersModel> data = snapshot.data!;
                        if(widget.data[widget.index].comment[index]["uid"]==FirebaseAuth.instance.currentUser!.uid) {



                          return InkWell(

                            onLongPress: () {
                              setState(() {
                                select=!select;
                                appbar=!appbar;
                              });
                              if(select){
                                deletindex=index;
                              }
                            },
                            child: Column(
                              children: [
                                Container(


                                  child: CommentCard(mdata: widget.data,
                                    mindex: widget.index,
                                    udata: data,
                                    index: index,),
                                ),
                                SizedBox(
                                  height: w*0.02,
                                )
                              ],
                            ),
                          );
                        }
                        else{
                          return  Container(

                            child: CommentCard(mdata: widget.data,
                              mindex: widget.index,
                              udata: data,
                              index: index,),
                          );
                        }
                    }
                                 else {

                                return Container(
                                  width: w*0.025,
                                    height: w*0.025,
                                    child: CircularProgressIndicator());
                                }});
                                }

                          ),
            ),
          ),
          Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formKey,
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                color: Constant().ternary,
                width: w,
                height: w*0.2,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: CircleAvatar(
                        radius: w*0.055,
                        backgroundImage: CachedNetworkImageProvider(usersModel!.profile),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(

                        width: w*0.7,
                        child: TextFormField(
                          validator: (value) {
                            if(value!.isEmpty){
                              return "";

                            }
                            return null;
                          },
                          controller: comment,
                          style: TextStyle(color: Constant().secondary),
                          decoration: InputDecoration(
                            border: InputBorder.none,

                            hintText: "Add a comment...",
                            hintStyle: TextStyle(color: Colors.white)
                          ),
                        ),
                      ),
                    ),
                    InkWell(onTap: () async{
                      final val=formKey.currentState!.validate();
                      if(val) {
                        Map a = {"uid": FirebaseAuth.instance.currentUser!.uid,
                          "commentDate": Timestamp.now(),
                          "comment": comment.text,

                        };
                        // usersModel = (obj.getUser(widget.data[widget.index].uid));
                        widget.data[widget.index].comment.add(a);


                        mediaModel = await(obj.getUserMedia(widget.data[widget
                            .index].mid));

                        var updateData = mediaModel!.copyWith(
                            comment: widget.data[widget.index].comment);
                        // FirebaseFirestore.instance.collectionGroup(collectionPath)
                        mediaModel!.ref!.update(
                            updateData.toJson());


                        comment = TextEditingController(text: "");
                        setState(() {

                        });
                      }
                    },
                        child: Icon(Icons.send,color: Colors.white,))
                  ],
                ),
              ),
            ),
          )

        ],
      ),
    ):Scaffold(
      resizeToAvoidBottomInset: false,

      backgroundColor:Constant().ternary,
      appBar: appbar?AppBar(
        elevation: 0,
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        title: Text("Selected"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: InkWell(onTap: () async{
              widget.data[widget.index].comment.removeAt(deletindex);
              mediaModel=await(obj.getUserMedia(widget.data[widget.index].mid))  ;

              var updateData = mediaModel!.copyWith(
                  comment: widget.data[widget.index].comment);
              // FirebaseFirestore.instance.collectionGroup(collectionPath)
             mediaModel!.ref!.update(
                  updateData.toJson());
              setState(() {
                appbar=false;
              });
              final snackBar=SnackBar(content: Text("Comment deleted"),
                backgroundColor: Constant().secondary,


              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);


            },child: Icon(Icons.delete_outline)),
          )
        ],
      ):AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Constant().ternary,
        centerTitle: true,
        title: Text("Comments"),
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
            child: Container(

              width: w,
              height: h*0.78,
              decoration: BoxDecoration(
                color: Constant().ternary,
              ),
              child:

              ListView.builder(
                  itemCount: widget.data[widget.index].comment.length,
                  itemBuilder: (context, index) {



                    var id=widget.data[widget.index].comment[index]["uid"];

                    return StreamBuilder(

                        stream:  FirebaseFirestore.instance
                            .collection(FireBaseConstant.userCollection).where("uid",isEqualTo: id)
                            .snapshots()
                            .map((snapshot) => snapshot.docs
                            .map((doc) => UsersModel.fromJson(
                          doc.data(),
                        ))
                            .toList()),

                        builder: (context, snapshot) {

                          if (snapshot.hasData) {

                            List<UsersModel> data = snapshot.data!;


                              return InkWell(onLongPress: () {
                                setState(() {
                                  appbar=!appbar;
                                });
                                if(select){
                                  deletindex=index;
                                }

                              },
                                child: Container(

                                  child: CommentCard(mdata: widget.data,
                                    mindex: widget.index,
                                    udata: data,
                                    index: index,),
                                ),

                              );

                          }
                          else {

                            return Container(
                                width: w*0.025,
                                height: w*0.025,
                                child: CircularProgressIndicator());
                          }});
                  }

              ),
            ),
          ),
          Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formKey,
            child: Padding(
              padding:MediaQuery.of(context).viewInsets,
              child: Container(
                color: Constant().ternary,
                width: w,
                height: w*0.2,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: CircleAvatar(
                        radius: w*0.055,
                        backgroundImage: CachedNetworkImageProvider(usersModel!.profile),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(

                        width: w*0.7,
                        child: TextFormField(
                          validator: (value) {
                            if(value!.isEmpty){
                              return "";

                            }
                            return null;
                          },
                          controller: comment,
                          style: TextStyle(color: Constant().secondary),
                          decoration: InputDecoration(
                              border: InputBorder.none,

                              hintText: "Add a comment...",
                              hintStyle: TextStyle(color: Constant().secondary)
                          ),
                        ),
                      ),
                    ),
                    InkWell(onTap: () async{
                      final val=formKey.currentState!.validate();
                      if(val) {
                        Map a = {"uid": FirebaseAuth.instance.currentUser!.uid,
                          "commentDate": Timestamp.now(),
                          "comment": comment.text,

                        };
                        // usersModel = (obj.getUser(widget.data[widget.index].uid));
                        widget.data[widget.index].comment.add(a);


                        mediaModel = await(obj.getUserMedia(widget.data[widget
                            .index].mid));

                        var updateData = mediaModel!.copyWith(
                            comment: widget.data[widget.index].comment);
                        // FirebaseFirestore.instance.collectionGroup(collectionPath)
                       mediaModel!.ref!.update(
                            updateData.toJson());


                        comment = TextEditingController(text: "");
                        setState(() {

                        });
                      }
                    },
                        child: Icon(Icons.send,color: Constant().secondary,))
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
