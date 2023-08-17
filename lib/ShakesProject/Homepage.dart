import 'package:flutter/material.dart';
import 'package:task4/ShakesProject/Cart.dart';
import 'package:task4/features/Auth/auth_controller.dart';

import 'package:task4/ShakesProject/categoryItems.dart';
import 'package:task4/ShakesProject/Whitslist.dart';
import 'package:task4/ShakesProject/emptycart.dart';
import 'package:task4/ShakesProject/emptywish.dart';
import 'package:task4/ShakesProject/list.dart';


List wish=[];


class Homepage extends StatefulWidget {

  const Homepage({super.key});
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with SingleTickerProviderStateMixin {
  int n=0;
  int f=0;
  back(int a){
    setState(() {
      n=a;
    });
  }
  fav(int a){
    setState(() {
      f=a;
    });
  }

  late TabController _tabController;

  String tabName='Shakes';


  @override
  void initState() {
    _tabController=TabController(length: 4, vsync: this,initialIndex: 3);
    super.initState();

    _tabController.addListener(() {
      setState(() {

      });
    });


  }
final AuthController _auth=AuthController();
  @override
  Widget build(BuildContext context) {


    var w=MediaQuery.sizeOf(context).width;
    var h=MediaQuery.sizeOf(context).height;
    return SafeArea(
      child: Scaffold(

        body: SingleChildScrollView(
          child: Container(
          width: w,
          height: h,
          decoration: BoxDecoration(
          gradient: LinearGradient(
          colors: [Colors.brown.shade800, const Color.fromARGB(255, 170, 20, 20)],

          )
          ),child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,



                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text("Welcome!",style: TextStyle(color: Colors.white,fontSize: w*0.1,fontWeight: FontWeight.bold ),),

                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            if(wishList.isEmpty){
                              Navigator.push( context, MaterialPageRoute(builder: (context) => const emptywish(),));
                            }
                            else{
                              Navigator.push( context, MaterialPageRoute(builder: (context) => favourite(back: back, fav: fav,),));
                            }

                          },
                          child: Badge(
                            backgroundColor: Colors.blue,
                            label: Text("$f"),
                            isLabelVisible: true,

                            child: Container(

                              width: w/11,
                                height: h/22,
                                decoration: BoxDecoration(
                                  color: Colors.red.shade500,
                                  borderRadius: BorderRadius.circular(10)
                                ),

                                child: Icon(Icons.favorite,color: Colors.white,size: w*0.06,)),
                          ),
                        ),
                        SizedBox(
                          width: w*0.025,
                        ),
                        InkWell(
                          onTap: (){
                            if(cartList.isEmpty){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const emptycart(),));
                            }
                            else{
                              Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage(back: back,),));
                            }

                          },
                          child: Badge(backgroundColor: Colors.blue,


                            label: Text("$n"),
                            isLabelVisible: true,
                            child: Container(

                                width: w/11,
                                height: h/22,
                                decoration: BoxDecoration(
                                    color: Colors.red.shade500,
                                    borderRadius: BorderRadius.circular(10)
                                ),

                                child: Icon(Icons.shopping_cart,color: Colors.white,size: w*0.06,)),
                          ),
                        ), SizedBox(
                          width: w*0.025,
                        ),

                        InkWell(
                          onTap: (){
                            _auth.signOut(context);




                          },
                          child: Container(

                              width: w/11,
                              height: h/22,
                              decoration: BoxDecoration(
                                  color: Colors.red.shade500,
                                  borderRadius: BorderRadius.circular(10)
                              ),

                              child: Icon(Icons.logout_sharp,color: Colors.white,size: w*0.06,)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(tabName,style: TextStyle(color: Colors.white,fontSize: w*0.07,fontWeight: FontWeight.bold),),
              ),
              Center(
                child: Container(
                  width: w*0.9,
                  height: w*0.1,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(w*0.025)
                  ),
                  child: TextFormField(
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,

                     // border: OutlineInputBorder(borderRadius:BorderRadius.all(Radius.zero),borderSide: BorderSide(color: Colors.white)),
                      prefixIcon: Icon(Icons.search_sharp,size: w*0.075,),
                      prefixIconColor: Colors.black,
                      hintText: "search",
                      hintStyle: TextStyle(color: Colors.grey,fontSize: w*0.05,fontStyle: FontStyle.italic),

                    )

                  ),
                ),
              ),
          SizedBox(
            height: w*0.025,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RotatedBox(
                quarterTurns: 3,
                child: SizedBox(
                  width: w*0.9,
                  height: w*0.125,
                  child: TabBar(
                    controller: _tabController,
                      onTap: (ind) {
                      if(ind==0){
                        tabName='Cocktail';
                      } else if(ind==1){
                        tabName='Mocktail';
                      } else if(ind==2){
                        tabName='Coffee';
                      } else {
                        tabName='Shakes';
                      }
                      },
                      indicator:BoxDecoration(

                        borderRadius: BorderRadius.all(Radius.circular(w*0.0225)),
                        color: Colors.red.shade300.withOpacity(0.2) ),


                      tabs:[
                   Tab(child: Text("Cocktail",style: TextStyle(fontSize: w*0.03),),),
                    Tab(
                      child: Text("Mocktail",style: TextStyle(fontSize:w*.03 ),),),
                    Tab(child: Text("Coffee",style: TextStyle(fontSize: w*.03),),),
                    Tab(child: Text("Shakes",style: TextStyle(fontSize: w*.03),),),


                  ],

                  ),


                ),
              ),
             Padding(
               padding: const EdgeInsets.only(top: 15.0),
               child: Container(width: 2,
               height: w*0.875,
               color: Colors.grey,),
             ),
              Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Column(

                  children:[ SizedBox(
                    width: w*0.6,
                    height: h*0.7,
                    child: TabBarView(

                      controller: _tabController,
                        children: [
                          CategoryItems(itemList:cocktailList ,back: back,fav: fav),
                          CategoryItems(itemList:mocktailList ,back: back,fav: fav),
                          CategoryItems(itemList:coffeeList ,back: back,fav: fav),
                      CategoryItems(itemList:shakesList ,back: back,fav: fav),
                     ]
                    ),
                  ),
  ]),
              )
            ],
          ),



            ],
          ),

      ),
        )

      ),
    );
  }


}
