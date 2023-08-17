import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task4/Core/Constant/FirebaseConstant/FireBaseConstants.dart';
import 'package:task4/models/UsersModel.dart';
import '../../../Core/Constant/ColorConstant/ColorConstant.dart';
import '../widget/LoginCard.dart';



class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  Map userDetail={
    "name":"",
    "email":"",
    "profile":""
  };
  bool searchtext=true;
var inx;
  Stream<List<UsersModel>> userStream() {
    return FirebaseFirestore.instance
        .collection(FireBaseConstant.userCollection)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => UsersModel.fromJson(
                  doc.data(),
                ))
            .toList());
  }

  TextEditingController search = TextEditingController();
  var userUid = FirebaseAuth.instance.currentUser!.uid;
  var userName = FirebaseAuth.instance.currentUser!.displayName;
  var userdp = FirebaseAuth.instance.currentUser!.photoURL;
  var userEmail = FirebaseAuth.instance.currentUser!.email;
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.sizeOf(context).width;
    var h = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Social",style: TextStyle(color: ColorConstant().secondary),),
        iconTheme: IconThemeData(color: ColorConstant().secondary),
        backgroundColor: ColorConstant().color,
      ),
      body: Container(
        decoration: BoxDecoration(
       color: ColorConstant().color
        ),
        child: StreamBuilder(
          stream: userStream(),
          builder: (context, snapshot) {

            if (snapshot.hasData) {
              
              List<UsersModel> data = snapshot.data!;

              return Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Column(
                  children: [
                    InkWell(onTap: () {
                      setState(() {
                        searchtext=!searchtext;
                      });




                    },
                        child: searchtext?Padding(
                          padding: const EdgeInsets.only(left: 300.0),
                          child: Container(
                            width: 40,
                              height: 40,
                              decoration: BoxDecoration(border: Border.all(color: ColorConstant().secondary),borderRadius: BorderRadius.circular(w*0.01)),
                              
                              child: Icon(Icons.search_outlined,size: 30,color: ColorConstant().secondary,)),
                        ): Container(
                          width: w * 0.8,
                          height: w * 0.15,
                          decoration: BoxDecoration(
                              color:ColorConstant().secondary,
                              border: Border.all(color: ColorConstant().color, width: 2),
                              borderRadius: BorderRadius.circular(w * 0.025)),
                          child: TextFormField(
                              onChanged: (value) {
                                setState(() {});
                              },
                              controller: search,
                              cursorColor: ColorConstant().color,
                              style: TextStyle(color: ColorConstant().color),
                              decoration: InputDecoration(
                                suffixIcon: InkWell(onTap: () {
                                  setState(() {
                                    searchtext=!searchtext;
                                  });

                                },
                                    child: const Icon(Icons.cancel)),
                                border: InputBorder.none,

                                // border: OutlineInputBorder(borderRadius:BorderRadius.all(Radius.zero),borderSide: BorderSide(color: Colors.white)),
                                prefixIcon: Icon(
                                  Icons.search_sharp,
                                  size: w * 0.075,
                                  color: Colors.black,
                                ),
                                prefixIconColor: ColorConstant().color,
                                hintText: "search",
                                hintStyle: TextStyle(
                                    color: ColorConstant().color,
                                    fontSize: w * 0.05,
                                    fontStyle: FontStyle.italic),
                              )),
                        )
                    ),

                    Expanded(
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            for(int i=0;i<data.length;i++){
                              if(data[i].uid==FirebaseAuth.instance.currentUser!.uid){
                                inx=i;

                                break;
                              }
                            }
                            if (data[index].uid !=
                                FirebaseAuth.instance.currentUser!.uid) {
                              if (search.text.isEmpty) {
                                return LoginCard(
                                    index: index, useruid: userUid, data: data,inx: inx,);
                              } else if ((data[index].name
                                      .toLowerCase()
                                      .toString())
                                  .contains(search.text)) {
                                return LoginCard(
                                    index: index, useruid: userUid, data: data,inx: inx,);
                              }

                            } else {
                              userDetail["name"] = data[index].name;
                              userDetail["profile"] = data[index].profile;
                              userDetail["email"] = data[index].email;

                              userDetail["createdDate"] =
                                  data[index].createdDate;
                              userDetail["loginDate"] = data[index].loginDate;

                              userDetail["phoneNumber"] =
                                  data[index].phoneNumber;
                              userDetail["followers"] = data[index].followers;
                              userDetail["following"] = data[index].following;
                              return Container();
                            }
                            return null;
                          }),
                    ),
                  ],
                ),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
