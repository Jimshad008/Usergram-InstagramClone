import 'package:flutter/material.dart';
import 'package:task4/auth/screens/FollowerList.dart';
import 'package:task4/auth/screens/FollowingList.dart';

import '../../Constant/FireBaseConstants.dart';
import '../../models/UsersModel.dart';

class Followfollower extends StatefulWidget {
  const Followfollower({super.key});

  @override
  State<Followfollower> createState() => _FollowfollowerState();
}

class _FollowfollowerState extends State<Followfollower>with SingleTickerProviderStateMixin {
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
            color: Constant().color

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
                        child: Icon(Icons.arrow_back_outlined,color: Constant().secondary,weight:3,)),
                  ),
                  SizedBox(width: 20,),
                  Text(usersModel!.name,style: TextStyle(color: Constant().secondary,fontWeight: FontWeight.bold),)
                ],
              ),
            ),
              Container(
                width: w ,
                height: w*0.1,
                child: TabBar(
                  labelColor: Constant().secondary,
                  indicatorColor: Constant().secondary,
                    controller:_tabController,tabs: [
                  Tab(child: Text("Followers",style: TextStyle(fontSize: w*0.03,fontWeight: FontWeight.bold),),),
                  Tab(
                    child: Text("Following",style: TextStyle(fontSize:w*.03,fontWeight: FontWeight.bold ),),),

                ]),
              ),
              Expanded(
                child: TabBarView(controller: _tabController,
                    children: [
                  FollowersList(),FollowingList()
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
