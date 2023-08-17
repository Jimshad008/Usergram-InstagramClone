import 'package:flutter/material.dart';
import 'package:task4/features/Social/screen/OtherFollowersList.dart';
import '../../../Core/Constant/ColorConstant/ColorConstant.dart';

import '../../../models/UsersModel.dart';

import 'OtherFollowingList.dart';

class OthersFollowFollowers extends StatefulWidget {
  List <UsersModel> data;
OthersFollowFollowers({super.key, required this.data});

  @override
  State<OthersFollowFollowers> createState() => _OthersFollowFollowersState();
}

class _OthersFollowFollowersState extends State<OthersFollowFollowers> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController=TabController(length: 2, vsync: this,initialIndex: 0);
    // TODO: implement initState
    super.initState();
    _tabController.addListener(() {
      setState(() {

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.sizeOf(context).width;
    var h=MediaQuery.sizeOf(context).height;
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              color: ColorConstant().color

          ),
          child: Column(
            children: [Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: InkWell(onTap: (){
                      Navigator.pop(context);
                    },
                        child: Icon(Icons.arrow_back_outlined,color: ColorConstant().secondary,weight:3,)),
                  ),
                  const SizedBox(width: 20,),
                  Text(widget.data[0].name,style: TextStyle(color: ColorConstant().secondary,fontWeight: FontWeight.bold),)
                ],
              ),
            ),
              SizedBox(
                width: w ,
                height: w*0.1,
                child: TabBar(
                    labelColor: ColorConstant().secondary,
                    indicatorColor: ColorConstant().secondary,
                    controller:_tabController,tabs: [
                  Tab(child: Text("Followers",style: TextStyle(fontSize: w*0.03,fontWeight: FontWeight.bold),),),
                  Tab(
                    child: Text("Following",style: TextStyle(fontSize:w*.03,fontWeight: FontWeight.bold ),),),

                ]),
              ),
              Expanded(
                child: TabBarView(controller: _tabController,
                    children: [
                      OtherFollowerList(data: widget.data),OtherFollowingList(data:widget.data,)
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
