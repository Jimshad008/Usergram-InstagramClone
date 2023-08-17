import 'package:flutter/material.dart';
import 'package:task4/ShakesProject/emptywish.dart';
import 'package:task4/ShakesProject/list.dart';

import '../models/cartModel.dart';

String addcart="Add to Cart";

class favourite extends StatefulWidget {
  final Function back;
  final Function fav;

  const favourite({super.key, required this.back, required this.fav,});

  @override
  State<favourite> createState() => _favouriteState();
}

class _favouriteState extends State<favourite> {
  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.sizeOf(context).width;
    var h=MediaQuery.sizeOf(context).height;
    return Scaffold(
    backgroundColor:const Color.fromRGBO(91, 47, 43, 100) ,
      appBar:
    AppBar(
          backgroundColor: const Color.fromRGBO(91, 47, 43, 100),
          title: const Text("Wishlist"),
        ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.brown.shade800, const Color.fromARGB(255, 170, 20, 20)],

          )
        ),
        child:
        GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: w*0.02,mainAxisSpacing: w*0.02), itemBuilder:(context, index) => Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(w*0.025),
            color: Colors.white,
    ),
 child: Padding(
   padding: const EdgeInsets.only(left: 8.0),
   child: Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     children: [
         SizedBox(
           width: w*0.4,
             height: w*0.25,
             child: Image(image: AssetImage(wishList[index].itemImage))),
         Text(wishList[index].itemName,style: TextStyle(fontWeight: FontWeight.bold,fontSize: w*0.04),),
         Text(wishList[index].itemType,style: TextStyle(fontWeight: FontWeight.bold,fontSize: w*0.04)),
       Text("\$${wishList[index].itemPrice}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: w*0.04)),
         Padding(
           padding: const EdgeInsets.only(top: 8.0),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               GestureDetector(
                 onTap: ()
           {
           int c = 0;
           setState(() {
             if (cartList.isEmpty) {
               cartList.add(Cart(
                   itemImage: wishList[index].itemImage,
                   itemType: wishList[index].itemType,
                   itemPrice: wishList[index].itemPrice,
                   itemName:wishList[index].itemName,
                   itemQuantity: wishList[index].itemQuantity,
                   id: wishList[index].id));
               widget.back(cartList.length);
               addcart="Added";
               wishList[index].isCarted=true;

             } else {
               int c = 0;
               for (int i = 0; i < cartList.length; i++) {
                 if (wishList[index].id ==
                     cartList[i].id) {
                   c++;
                 }
               }
               if (c == 0) {
                 cartList.add(Cart(
                     itemImage:wishList[index].itemImage,
                     itemType: wishList[index].itemType,
                     itemPrice: wishList[index].itemPrice,
                     itemName: wishList[index].itemName,
                     itemQuantity: wishList[index]
                         .itemQuantity,
                     id: wishList[index].id));
                 widget.back(cartList.length);
                 wishList[index].isCarted=true;


               }
             }
           });
           },
                   child:
                   Container(
                     width: w * 0.35,
                     height: w * 0.07,
                     decoration: BoxDecoration(
                         color: const Color.fromRGBO(91, 47, 43, 100),
                         borderRadius: BorderRadius.circular(w * 0.018)
                     ),
                     child: Center(child: Text(wishList[index].isCarted?"Added":"Add to Cart",
                       style: const TextStyle(fontWeight: FontWeight.bold),)),
                   )
                 ),
               Padding(
                 padding: const EdgeInsets.only(right: 8.0),
                 child: InkWell(
                   onTap: () {
                     setState(() {

                       wishList.removeAt(index);
                       widget.fav(wishList.length);



                       if(wishList.isEmpty){
                         Navigator.push( context, MaterialPageRoute(builder: (context) => const emptywish(),));
                       }
                     });
                   },
                   child: Container(
                     width: w*0.07,
                     height: w*0.07,
                   decoration: BoxDecoration(
                     color: const Color.fromRGBO(91, 47, 43, 100),
                     borderRadius: BorderRadius.circular(w*0.018)
                   ),
                     child: const Icon(Icons.delete_forever_outlined),
                   ),
                 ),
               )
             ],
           ),
         )

     ],
   ),
 ),
         // width: w*0.48,
         // height: w*0.50,
        ),
        itemCount: wishList.length,),
      ),

    );

  }
}
