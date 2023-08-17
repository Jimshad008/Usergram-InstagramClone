
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:task4/features/UserProfile/screen/MyProfile.dart';
import 'package:task4/features/Post/screen/PostEdit.dart';
import 'package:task4/features/Home/widget/feedViewContainer.dart';
import '../../../Core/Constant/ColorConstant/ColorConstant.dart';

import '../../../models/mediaModel.dart';

class SinglePostPage extends StatefulWidget {
  String image;
  String description;
  Timestamp postDate;
  List <MediaModel> data;
  int index;
 SinglePostPage({super.key, required this.image,required this.postDate,required this.description,required this.data,required this.index});

  @override
  State<SinglePostPage> createState() => _SinglePostPageState();
}

class _SinglePostPageState extends State<SinglePostPage> {
  void alert(){
    showDialog(context: context, builder: (context) =>AlertDialog(
      backgroundColor: ColorConstant().ternary,
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: Text('Are you sure to delete the post',style: TextStyle(color: ColorConstant().secondary),),
      content: SizedBox(
        height: MediaQuery.of(context).size.height / 7,
        child: SingleChildScrollView(
          child: Row(
            children: [
              SizedBox(
                width: 105,
                child: ElevatedButton(

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade800, // Background color
                  ),

                  onPressed: () {
                  Navigator.pop(context);

                  },
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 10,),
              SizedBox(
                width: 105,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade800, // Background color
                  ),
                  //if user click this button. user can upload image from camera
                  onPressed: () {
              widget.data[widget.index].ref!.delete();
                        Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => const Myprofile(),), (route) => false);
                  },
                  child: const Text('Delete'),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery
        .sizeOf(context)
        .width;
    var h = MediaQuery
        .sizeOf(context)
        .height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant().color,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(child: Stack(children:[
          FeedviewContainer(index: widget.index, data: widget.data),Positioned(right: 5,top: 0,
              child: InkWell(onTap: () {
                showModalBottomSheet(backgroundColor: ColorConstant().ternary,useRootNavigator: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(h*0.03)),
                  ),
                  showDragHandle: true,
                  enableDrag: true,
                  context: context, builder: (context) => Column(
                    mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(onTap: () {
                      Navigator.push(context, CupertinoPageRoute(builder: (context) => PostEdit(index: widget.index, data: widget.data),));
                    },
                      child: SizedBox(
                        height: w*0.1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Row(
                            children: [
                              Icon(Icons.edit,color: ColorConstant().secondary,size: w*0.045,),
                              SizedBox(width: w*0.03,),
                              Text("Edit",style: TextStyle(color: ColorConstant().secondary,fontWeight: FontWeight.bold,fontSize: w*0.045))
                            ],
                          ),
                        ),
                      ),
                    ),InkWell(onTap: () {
                           alert();
                    },
                      child: SizedBox(
                        height: w*0.1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Row(
                            children: [
                              Icon(Icons.delete_outlined,color:ColorConstant().secondary,size: w*0.045,),
                              SizedBox(width: w*0.03,),
                              Text("Delete",style: TextStyle(color:ColorConstant().secondary,fontWeight: FontWeight.bold,fontSize: w*0.045),)
                            ],
                          ),
                        ),
                      ),
                    )

                  ],
                ),);
              },
                child: SizedBox(
                  width: w*0.1,
                    height: w*0.1,
                    child: Icon(Icons.more_vert,color: ColorConstant().secondary,size: w*0.08,)),
              )),])),

      ),
    );
  }
}
