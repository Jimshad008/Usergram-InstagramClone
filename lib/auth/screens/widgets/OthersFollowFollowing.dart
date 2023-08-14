import 'package:flutter/material.dart';
import 'package:task4/Constant/FireBaseConstants.dart';

import '../../../models/UsersModel.dart';
import '../OtherFollowersList.dart';
import '../OtherFollowingList.dart';

class OthersFollowFollowing extends StatefulWidget {
  List<UsersModel> data;
  OthersFollowFollowing({required this.data});

  @override
  State<OthersFollowFollowing> createState() => _OthersFollowFollowingState();
}

class _OthersFollowFollowingState extends State<OthersFollowFollowing> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {

    _tabController=TabController(length: 2, vsync: this,initialIndex: 1);
    // TODO: implement initState
    super.initState();
    _tabController.addListener(() {
      setState(() {

      });
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.sizeOf(context).width;
    var h=MediaQuery.sizeOf(context).height;
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              color:Constant().color,

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
                  Text(widget.data[0].name,style: TextStyle(color: Constant().secondary,fontWeight: FontWeight.bold),)
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
