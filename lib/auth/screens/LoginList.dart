import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task4/auth/screens/AddToPost.dart';
import 'package:task4/auth/screens/LoginCard.dart';
import 'package:task4/auth/screens/MyProfile.dart';
import 'package:task4/auth/screens/ProfileEdit.dart';
import 'package:task4/auth/controller/auth_controller.dart';
import 'package:task4/auth/screens/SavedPost.dart';
import 'package:task4/auth/screens/Story.dart';
import 'package:task4/auth/screens/UsergramUsers.dart';
import 'package:task4/auth/screens/feedViewContainer.dart';
import 'package:task4/models/UsersModel.dart';
import 'package:task4/models/mediaModel.dart';

import '../../Constant/FireBaseConstants.dart';
import '../../root.dart';

class Loginlist extends StatefulWidget {

  const Loginlist({super.key});


  @override
  State<Loginlist> createState() => _LoginlistState();
}

class _LoginlistState extends State<Loginlist> {

  void alert(){
    showDialog(context: context, builder: (context) =>AlertDialog(
      backgroundColor: Constant().ternary,
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: Text('Are you sure to Logout',style: TextStyle(color: Constant().secondary),),
      content: Container(
        height: MediaQuery.of(context).size.height / 7,
        child: SingleChildScrollView(
          child: Row(
            children: [
              Container(
                width: 105,
                child: ElevatedButton(

                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey.shade800, // Background color
                  ),

                  onPressed: () {
                    Navigator.pop(context);

                  },
                  child: Text('Cancel'),
                ),
              ),
              SizedBox(width: 10,),
              Container(
                width: 105,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey.shade800, // Background color
                  ),
                  //if user click this button. user can upload image from camera
                  onPressed: () {

                    obj.signOut(context);
                  },
                  child: Text('Logout'),
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
      value.docs.forEach((element) {
        element.reference.update({"ref": element.reference});
      });
    });
  }
  getMediaNow() {
    FirebaseFirestore.instance.collection(FireBaseConstant.mediaCollection).get().then((value) {
      value.docs.forEach((element) {
        element.reference.update({"ref": element.reference});
      });
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
            backgroundColor: Constant().color,
            drawer: Drawer(

                width: 220,
                backgroundColor: Constant().color, child: ListView(
              children: [
                InkWell(onTap: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => Myprofile(),));
                },
                  child: DrawerHeader(
                    decoration: BoxDecoration(color: Constant().color
                    ,
                    border: Border(bottom: BorderSide(color: Constant().secondary),)),

                    child: Column(mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: Constant().secondary,
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
                                  fontSize: w * 0.05, color: Constant().secondary),),
                              Text(usersModel!.email,
                                  style: TextStyle(color: Constant().secondary))

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
                       Text('Edit Profile',style: TextStyle(color: Constant().secondary),),
                      Icon(Icons.edit,color: Constant().secondary,)
                    ],
                  ),
                  onTap: () {
                    Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => ProfileEdit()),);
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Add a Post',style: TextStyle(color: Constant().secondary)),
                      Icon(Icons.add,color: Constant().secondary,)
                    ],
                  ),

                  onTap: () {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) => AddToPost(),));
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text('Saved',style: TextStyle(color: Constant().secondary),),
                      Icon(CupertinoIcons.bookmark,color: Constant().secondary,)
                    ],
                  ),
                  onTap: () {
                    Navigator.push(context,
                      CupertinoPageRoute(builder: (context) =>Savedpost()),);
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  title: dark?Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Light Mode',style: TextStyle(color: Constant().secondary),),
                      Icon(CupertinoIcons.brightness,color: Constant().secondary,)
                    ],
                  ):Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Dark Mode',style: TextStyle(color: Constant().secondary),),
                    Icon(Icons.dark_mode_outlined,color: Constant().secondary,)
                  ],
                ),
                  onTap: () {
                    setState(() {
                      // dark=!dark;
                    });

                  },
                ),

                ListTile(
                  title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Logout',style: TextStyle(color: Constant().secondary)),
                      Icon(Icons.logout_outlined,color: Constant().secondary,)
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


            body: CustomScrollView(scrollDirection: Axis.vertical,slivers: [
              SliverAppBar(
                iconTheme: IconThemeData(color: Constant().secondary),
                backgroundColor: Constant().color,// Set your desired background color
                title: Text(
                  "Usergram",
                  style: TextStyle(color: Constant().secondary),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddToPost()),
                        );
                      },
                      child: Icon(Icons.add),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Users()),
                        );
                      },
                      child: Icon(Icons.supervised_user_circle_sharp),
                    ),
                  )
                ],
                // bottom: PreferredSize(
                //   child: StoryPage(),
                //   preferredSize: Size.fromHeight(h * 0.1),
                // ),
                floating: true, // The app bar will "float" above the content
                snap: true, // App bar will snap into view when scrolling up
              ),
              SliverFillRemaining(
                child: Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  decoration: BoxDecoration(
                      color: Constant().color
                  ),
                  child: StreamBuilder(
                      stream: userStream(),
                      builder: (context, snapshot) {
                        print(snapshot);
                        if (snapshot.hasData) {
                          List<MediaModel> data = snapshot.data!;

                          return Column(
                            children: [

                              Expanded(
                                child: ListView.builder(
                                    itemCount: data.length,
                                    itemBuilder: (context, index) {
                                      getUserdetailPost(data[index].uid);




                                      return FeedviewContainer(index: index, data: data);
                                    }
                                ),
                              ),
                            ],
                          );
                        }
                        else {
                          return
                            CircularProgressIndicator();
                        }
                      }),
                ),
              ),
            ],

            ),
          )
      );
    }
  }




