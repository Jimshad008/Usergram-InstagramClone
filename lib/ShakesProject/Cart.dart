import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task4/ShakesProject/checkout.dart';
import 'package:task4/ShakesProject/list.dart';
import 'package:task4/main.dart';

import 'emptycart.dart';

class CartPage extends StatefulWidget {
  final Function back;

  const CartPage({super.key, required this.back});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {


  @override
  Widget build(BuildContext context) {
    double damt=4.00;
    double gt=0;
    setState(() {
      for(int i=0;i<cartList.length;i++){

        gt=gt+(cartList[i].itemPrice*cartList[i].itemQuantity);

      }
      if(gt>=500){
        damt=0.00;
      }
    });

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: w,
          height: h,
            decoration: BoxDecoration(
            gradient: LinearGradient(
            colors: [Colors.brown.shade800, const Color.fromARGB(255, 170, 20, 20)],

        )

        ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                    child: Icon(Icons.keyboard_backspace,color: Colors.white,size: w*0.075,)),
              ),
              SizedBox(
                width: w,
                height:w*0.550 ,
                child: ListView.builder(itemBuilder: (context, index) => Column(
                  children: [
                    Container(
      width: w*0.95,
      height: w*0.275,
      decoration: BoxDecoration(
          color: Colors.white60,
          borderRadius: BorderRadius.circular(w*0.05)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: w*0.1,
            height: w*0.250,
            decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(w*0.01),
                    border: Border.all(
                        color: Colors.grey
                    )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                    InkWell(
                        onTap: (){
                          setState(() {
                            cartList[index].itemQuantity++;
                          });
                        },
                        child: const SizedBox(
                            width: 30,
                            height: 30,
                            child: Icon(Icons.add))),
                    Text("${cartList[index].itemQuantity}"),
                    InkWell(onTap: (){

                      setState(() {
                        cartList[index].itemQuantity --;

                      });
                      if(cartList[index].itemQuantity<1){

                        cartList.removeAt(index);
                        if(cartList.isEmpty){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const emptycart(),));
                        }
                      }
                    },
                        child: const SizedBox(
                            width: 30,
                            height: 30,
                            child: Icon(CupertinoIcons.minus)))
              ],
            ),
          ),


          SizedBox(
            width: w*0.250,
            height: w*0.250,
            child: Image(image: AssetImage(cartList[index].itemImage)),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(cartList[index].itemName,style: const TextStyle(fontWeight: FontWeight.bold),),
              Text("\$${cartList[index].itemPrice*(cartList[index].itemQuantity)}",style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.blueAccent)),
              Text(cartList[index].itemType,style: const TextStyle(color: Colors.grey))
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: InkWell(
              onTap: (){
                setState(() {wishList[index].isCarted=false;
                  cartList.removeAt(index);



                  if(cartList.isEmpty){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const emptycart(),));
                  }


                });

              },
              child: Container(
                width: w*0.05,
                height: w*0.05,
                decoration: BoxDecoration(
                      border: Border.all(color: Colors.white.withOpacity(0.6),

                      ),
                      color: Colors.red.withOpacity(0.2),

                ),
                child: Center(child: Icon(Icons.clear_rounded,size: w*0.04,)),

              ),
            ),
          )

        ],
      ),
    ),
                    SizedBox(
                      height: w*0.025,
                    )
                  ],
                ),


     itemCount: cartList.length,)
              ),

              SizedBox(
                height: w*0.05,             ),
              Center(
                child: Container(
                  width:w*0.90 ,
                  height: w*0.15
                  ,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(w*0.05)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                    Container(
                      width: w*0.43,
                      height: w*0.16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(w*0.05)
                      ),
                      child: TextField(

                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            enabled: mounted,


                            // border: OutlineInputBorder(borderRadius:BorderRadius.all(Radius.zero),borderSide: BorderSide(color: Colors.white)),

                            hintText: "Promo Code",
                            hintStyle: TextStyle(color: Colors.grey,fontSize: w*0.05,fontStyle: FontStyle.italic),

                          )

                      ),
                    ),
                  Container(
                    width: w*0.3,
                    height: w*0.10,
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(w*0.04),color:Colors.red.withOpacity(0.6)
                   ),
                    child: Center(child: Text("Apply",style: TextStyle(fontSize: w*0.05,fontWeight:FontWeight.bold,color: Colors.white),)),
                  )
                  ],


                  ),
                ),
              ),
              SizedBox(
                height: w*0.05,             ),
              Center(
                child: Container(
                  width: w*0.95,
                  height: h*0.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(w*0.05),
                    color: Colors.white.withOpacity(0.6)
                  ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(

                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text("Cart Total",style: TextStyle(
                            fontSize: 25,color: Colors.grey.shade700
                          ),),
                        ),Padding(
                          padding: const EdgeInsets.only(right: 10.0),

                          child: Text("\$${double.parse(gt.toStringAsFixed(2))}",style: TextStyle(
                            fontSize: 25,color: Colors.grey.shade700,fontWeight: FontWeight.bold
                          ),),
                        )],
                      ),
                      Row(

                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text("Tax",style: TextStyle(
                              fontSize: 25,color: Colors.grey.shade700
                          ),),
                        ),Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Text("\$${(gt*4.6/100).toStringAsFixed(2)}",style: TextStyle(
                              fontSize: 25,color: Colors.grey.shade700,fontWeight: FontWeight.bold
                          ),),
                        )],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text("Delivery Charge",style: TextStyle(
                              fontSize: 25,color: Colors.grey.shade700
                          ),),
                        ),Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Text("\$$damt",style: TextStyle(
                              fontSize: 25,color: Colors.grey.shade700,fontWeight: FontWeight.bold
                          ),),
                        )],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text("Promo Discount",style: TextStyle(
                              fontSize: 25,color: Colors.grey.shade700
                          ),),
                        ),Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Text("-\$0.00",style: TextStyle(
                              fontSize: 25,color: Colors.grey.shade700,fontWeight: FontWeight.bold
                          ),),
                        )],
                      ),
                      Container(
                        height:w*0.007,
                        width: w*0.95,
                        color: Colors.grey,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text("Sub Total",style: TextStyle(
                              fontSize: 25,color: Colors.grey.shade700
                          ),),
                        ),Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Text("\$${((gt)+(gt*4.6/100)+damt).toStringAsFixed(2)}",style: TextStyle(
                              fontSize: 30,color: Colors.grey.shade700,fontWeight: FontWeight.bold
                          ),),
                        )],
                      ),


                    ],
                  ),
                ),
              ),
              SizedBox(
                height: w*0.05,
              ),
              Center(
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const checkout(),));
                   cartList=[];
                  },
                  child: Container(
                    width: w*0.9,
                    height: w*0.125,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(w*0.025),
                        color: Colors.red.withOpacity(0.3)
                    ),
                    child: Center(child: Text("Proceed to Checkout",style: TextStyle(color: Colors.white.withOpacity(0.7),fontWeight: FontWeight.bold,fontSize: w*0.05),)),
                  ),
                ),
              )

          ],
        ),

        ),
      ),
    );

  }
}
