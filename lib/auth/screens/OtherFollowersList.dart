import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Constant/FireBaseConstants.dart';
import '../../models/UsersModel.dart';
import 'LoginCard.dart';

class OtherFollowerList extends StatefulWidget {
  List <UsersModel> data;
   OtherFollowerList({required this.data});

  @override
  State<OtherFollowerList> createState() => _OtherFollowerListState();
}

class _OtherFollowerListState extends State<OtherFollowerList> {
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
  bool searchtext=true;
  var inx;
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.sizeOf(context).width;
    var h = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            color: Constant().color
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
                              decoration: BoxDecoration(border: Border.all(color: Constant().secondary),borderRadius: BorderRadius.circular(w*0.01)),

                              child: Icon(Icons.search_outlined,size: 30,color: Constant().secondary,)),
                        ): Container(
                          width: w * 0.8,
                          height: w * 0.15,
                          decoration: BoxDecoration(
                              color: Constant().secondary,
                              border: Border.all(color: Constant().color, width: 2),
                              borderRadius: BorderRadius.circular(w * 0.025)),
                          child: TextFormField(
                              onChanged: (value) {
                                setState(() {});
                              },
                              controller: search,
                              cursorColor:Constant().secondary,
                              style: TextStyle(color: Constant().color),
                              decoration: InputDecoration(
                                suffixIcon: InkWell(onTap: () {
                                  setState(() {
                                    searchtext=!searchtext;
                                  });

                                },
                                    child: Icon(Icons.cancel)),
                                border: InputBorder.none,

                                // border: OutlineInputBorder(borderRadius:BorderRadius.all(Radius.zero),borderSide: BorderSide(color: Colors.white)),
                                prefixIcon: Icon(
                                  Icons.search_sharp,
                                  size: w * 0.075,
                                  color: Colors.black,
                                ),
                                prefixIconColor: Constant().color,
                                hintText: "search",
                                hintStyle: TextStyle(
                                    color: Constant().color,
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

                            if (widget.data[0].followers.contains(data[index].uid)) {
                              if(data[index].uid!=FirebaseAuth.instance.currentUser!.uid) {
                                if (search.text.isEmpty) {
                                  return LoginCard(
                                    index: index,
                                    useruid: FirebaseAuth.instance.currentUser!
                                        .uid,
                                    data: data,
                                    inx: inx,);
                                } else if ((data[index].name
                                    .toLowerCase()
                                    .toString())
                                    .contains(search.text)) {
                                  return LoginCard(
                                    index: index,
                                    useruid: FirebaseAuth.instance.currentUser!
                                        .uid,
                                    data: data,
                                    inx: inx,);
                                }
                              }
                              else{
                                return MyLoginCard(index: index, data: data);
                              }
                            }
                            else{
                              return Container(

                              );
                            }

                          }),
                    ),
                  ],
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),

    );
  }
}