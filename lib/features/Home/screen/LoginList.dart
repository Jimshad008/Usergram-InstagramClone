import 'dart:async';
import '../../../Core/Constant/ColorConstant/ColorConstant.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task4/features/Post/screen/AddToPost.dart';
import 'package:task4/features/story/screen/add%20story.dart';
import 'package:task4/features/UserProfile/screen/MyProfile.dart';
import 'package:task4/features/UserProfile/screen/ProfileEdit.dart';
import 'package:task4/features/Auth/auth_controller.dart';
import 'package:task4/features/Post/screen/SavedPost.dart';
import 'package:task4/features/story/screen/Story.dart';
import 'package:task4/features/Social/screen/UsergramUsers.dart';
import 'package:task4/features/Home/widget/feedViewContainer.dart';
import 'package:task4/models/UsersModel.dart';
import 'package:task4/models/mediaModel.dart';

import '../../../Core/Constant/FirebaseConstant/FireBaseConstants.dart';
import '../../../root.dart';

class Loginlist extends StatefulWidget {

  const Loginlist({super.key});


  @override
  State<Loginlist> createState() => _LoginlistState();
}

class _LoginlistState extends State<Loginlist> {
  void showCupertinoActionSheet(BuildContext context) {
    showCupertinoModalPopup(

      context: context,
      builder: (BuildContext context) { var w=MediaQuery.sizeOf(context).width;
      var h=MediaQuery.sizeOf(context).height;


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
                setState(() {

                });
                // Add your action logic here
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => const AddaStory()),
                );
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


  void alert(){
    showDialog(context: context, builder: (context) =>AlertDialog(
      backgroundColor: ColorConstant().ternary,
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: Text('Are you sure to Logout',style: TextStyle(color: ColorConstant().secondary),),
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

                    obj.signOut(context);
                  },
                  child: const Text('Logout'),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }


  var profileofuser;
  var nameofuser;
  var emailofuser;



  // Future<void> _loadUserData() async {
  //   String uid = FirebaseAuth.instance.currentUser!.uid;
  //    {
  //     DocumentSnapshot userSnapshot =
  //     await FirebaseFirestore.instance.collection('users').doc(uid).get();
  //     if (userSnapshot.exists) {
  //       Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
  //
  //       setState(() {
  //         user_Name = userData['name'];
  //         user_Email = userData['email'];
  //         user_profile=userData['profile'];
  //       });
  //     }
  //   }
  //   }

getUserdetail(){

  FirebaseFirestore.instance.collection(FireBaseConstant.userCollection).doc(currentUserid).snapshots().listen((event) {
 if(event.data()!=null){

   setState(() {
     usersModel = UsersModel.fromJson(event.data()!);
   });

 }

});
      }


  getUserdetailPost(uid)async{

    var snapshot=await FirebaseFirestore.instance.collection(FireBaseConstant.userCollection).doc(uid).get();
    if(snapshot.exists){
      usersModel2= UsersModel.fromJson(snapshot.data()!);
    }

  }

  // getUserdetailPostName(uid)async{
  //
  //   var snapshot=await FirebaseFirestore.instance.collection(FireBaseConstant.userCollection).doc(uid).get();
  //   if(snapshot.exists){
  //     usersModel2= UsersModel.fromJson(snapshot.data()!);
  //   }
  //   return usersModel2!.name;
  // }

  AuthController obj=AuthController();

  var userUid=FirebaseAuth.instance.currentUser!.uid;

  TextEditingController search = TextEditingController();
  // refresh(){
  //   setState(() {
  //     profileofuser =usersModel!.profile;
  //     nameofuser = usersModel!.name;
  //     emailofuser = usersModel!.email;
  //   });
  // }
  Stream<List<MediaModel>> userStream() {
    return FirebaseFirestore.instance
        .collection(FireBaseConstant.mediaCollection).orderBy("postDate",descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => MediaModel.fromJson(
      doc.data(),
    ))
        .toList());
  }
  // getdata() async {
  //   usersModel=await obj.getUser(FirebaseAuth.instance.currentUser!.uid);
  // }
  getUserNow() {
    FirebaseFirestore.instance.collection(FireBaseConstant.userCollection).get().then((value) {
      for (var element in value.docs) {
        element.reference.update({"ref": element.reference});
      }
    });
  }
  getMediaNow() {
    FirebaseFirestore.instance.collection(FireBaseConstant.mediaCollection).get().then((value) {
      for (var element in value.docs) {
        element.reference.update({"ref": element.reference});
      }
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    getUserdetail();
  }
@override
  void initState() {
  // getdata();
    // TODO: implement initState
    super.initState();

    setState(() {
      getUserdetail();
    });
    setState(() {

    });
    getUserNow();
    getMediaNow();
  }
  // getdpostUserImage(uid) async {
  //   usersModel2=await obj.getUser(uid);
  //   String img=usersModel2!.profile;
  //   print("!!!!!!!!!!!!!!!!!!!!!!");
  //   print(img);
  //   return img;
  // }
  // getdpostUsername(uid) async {
  //   usersModel2=await obj.getUser(uid);
  //   String name=usersModel2!.name;
  //   return name;
  // }

  @override
  Widget build(BuildContext context) {
    // FirebaseFirestore.instance.collection(FireBaseConstant.userCollection).snapshots().listen((event) {
    //   for(var a in event.docs ) {
    //
    //     if(a["uid"]==FirebaseAuth.instance.currentUser!.uid){
    //
    //       usersModel=UsersModel.fromJson(a.data());
    //
    //
    //     }
    //
    //   }
    //
    // });
    // setState(() {
    //   profileofuser =usersModel!.profile;
    //   nameofuser = usersModel!.name;
    //   emailofuser = usersModel!.email;
    // });


    var w = MediaQuery
        .sizeOf(context)
        .width;
    var h = MediaQuery
        .sizeOf(context)
        .height;


      return SafeArea(

          child: Scaffold(
            backgroundColor: ColorConstant().color,
            drawer: Drawer(

                width: 220,
                backgroundColor: ColorConstant().color, child: ListView(
              children: [
                InkWell(onTap: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => const Myprofile(),));
                },
                  child: DrawerHeader(
                    decoration: BoxDecoration(color: ColorConstant().color
                    ,
                    border: Border(bottom: BorderSide(color: ColorConstant().secondary),)),

                    child: Column(mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: ColorConstant().secondary,
                          radius: w * 0.12,
                          child: CircleAvatar(
                            radius: w * 0.11,
                            backgroundImage: NetworkImage(usersModel!.profile),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(mainAxisAlignment: MainAxisAlignment
                              .center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(usersModel!.name, style: TextStyle(
                                  fontSize: w * 0.05, color: ColorConstant().secondary),),
                              Text(usersModel!.email,
                                  style: TextStyle(color: ColorConstant().secondary))

                            ],
                          ),
                        )
                      ],
                    ),),
                ),
                // ListTile(
                //   title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       const Text('MyProfile'),
                //       Icon(CupertinoIcons.profile_circled)
                //     ],
                //   ),
                //   onTap: () {
                //     Navigator.push(context, MaterialPageRoute(builder: (context) =>Myprofile() ,));
                //     // Update the state of the app.
                //     // ...
                //   },
                // ),
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text('Edit Profile',style: TextStyle(color: ColorConstant().secondary),),
                      Icon(Icons.edit,color: ColorConstant().secondary,)
                    ],
                  ),
                  onTap: () {
                    Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => const ProfileEdit()),);
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Add a Content',style: TextStyle(color: ColorConstant().secondary)),
                      Icon(Icons.add,color: ColorConstant().secondary,)
                    ],
                  ),

                  onTap: () {
                    showCupertinoActionSheet(context);
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text('Saved',style: TextStyle(color: ColorConstant().secondary),),
                      Icon(CupertinoIcons.bookmark,color: ColorConstant().secondary,)
                    ],
                  ),
                  onTap: () {
                    Navigator.push(context,
                      CupertinoPageRoute(builder: (context) =>const Savedpost()),);
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  title: dark?Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Light Mode',style: TextStyle(color: ColorConstant().secondary),),
                      Icon(CupertinoIcons.brightness,color: ColorConstant().secondary,)
                    ],
                  ):Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Dark Mode',style: TextStyle(color: ColorConstant().secondary),),
                    Icon(Icons.dark_mode_outlined,color: ColorConstant().secondary,)
                  ],
                ),
                  onTap: () {
                    setState(() {
                      dark=!dark;
                    });

                  },
                ),

                ListTile(
                  title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Logout',style: TextStyle(color: ColorConstant().secondary)),
                      Icon(Icons.logout_outlined,color: ColorConstant().secondary,)
                    ],
                  ),
                  onTap: () {
                     alert();
                    // Update the state of the app.
                    // ...
                  },
                ),
              ],
            )),
            // appBar: AppBar(iconTheme: IconThemeData(color: Constant().secondary),
            //   backgroundColor: Constant().color,
            //   title: Text(
            //     "Usergram", style: TextStyle(color: Constant().secondary),),
            //   actions: [
            //     Padding(
            //       padding: const EdgeInsets.only(right: 10.0),
            //       child: InkWell(onTap: () {
            //         Navigator.push(context,
            //             CupertinoPageRoute(builder: (context) => AddToPost(),));
            //       },
            //           child: Icon(CupertinoIcons.add,)),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.only(right: 10.0),
            //       child: InkWell(onTap: () {
            //         Navigator.push(context,
            //             CupertinoPageRoute(builder: (context) => Users(),));
            //       },
            //           child: Icon(Icons.supervised_user_circle_sharp,)),
            //     )
            //   ],
            // bottom: PreferredSize(child: StoryPage(), preferredSize: Size.fromHeight(h*0.1))),


            body: NestedScrollView(
    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      return [

        SliverAppBar(
          iconTheme: IconThemeData(color: ColorConstant().secondary),
          backgroundColor: ColorConstant().color,
          // Set your desired background color
          title: Text(
            "Usergram",
            style: TextStyle(color: ColorConstant().secondary),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: InkWell(
                onTap: () {

                  showCupertinoActionSheet(context);
                },
                child: const Icon(Icons.add),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Users()),
                  );
                },
                child: const Icon(Icons.supervised_user_circle_sharp),
              ),
            )
          ],
          // bottom: PreferredSize(
          //   child: StoryPage(),
          //   preferredSize: Size.fromHeight(h * 0.1),
          // ),
          floating: true,
          pinned: false,
          // The app bar will "float" above the content
          snap: true,
      excludeHeaderSemantics: true,
         // App bar will snap into view when scrolling up
        ),
        SliverToBoxAdapter(child:SizedBox(
          width: w,
          height: h*0.13,
          child: const StoryPage(),
        ) ,)
      ];
    }, body: Container(
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: BoxDecoration(
                  color: ColorConstant().color
              ),
              child: StreamBuilder(
                  stream: userStream(),
                  builder: (context, snapshot) {

                    if (snapshot.hasData) {
                      List<MediaModel> data = snapshot.data!;

                      return Column(
                        children: [

                          Expanded(
                            child: ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  getUserdetailPost(data[index].uid);

                                  return FeedviewContainer(
                                      index: index, data: data);
                                }
                            ),
                          ),
                        ],
                      );
                    }
                    else {
                      return
                        const CircularProgressIndicator();
                    }
                  }),
            ), ),
          )
      );
    }
  }




