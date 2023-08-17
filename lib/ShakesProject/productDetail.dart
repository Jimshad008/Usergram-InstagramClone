import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task4/ShakesProject/Cart.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:task4/ShakesProject/list.dart';
import 'package:task4/models/cartModel.dart';
import 'package:task4/models/itemModel.dart';
import 'package:task4/models/wishlistModel.dart';

import 'emptycart.dart';
import '../main.dart';

double totalprice = 0;
double ratingVar = 0;

class ProductDetail extends StatefulWidget {
  final Function back;

  final Function fav;

  List<Items> itemList;
  int inx;

  ProductDetail(
      {super.key, required this.itemList, required this.inx, required this.back,required this.fav}) {
    totalprice = itemList[inx].itemPrice;
  }

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    String t = "Add to Cart";

    return SafeArea(
      child: Scaffold(
          body: Container(
              width: w,
              height: h,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  Colors.brown.shade800,
                  const Color.fromARGB(255, 170, 20, 20)
                ],
              )),
              child: Stack(
                children: [
                  Positioned(
                    left: w * 0.025,
                    top: w * 0.025,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          width: w / 11,
                          height: h / 22,
                          decoration: BoxDecoration(
                              color: Colors.red.shade500.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(w * 0.025)),
                          child: Icon(
                            Icons.navigate_before_sharp,
                            color: Colors.white,
                            size: w * 0.075,
                          )),
                    ),
                  ),
                  Positioned(
                    right: w * 0.025,
                    top: w * 0.025,
                    child: GestureDetector(
                      onTap: () {
                        if (cartList.isEmpty) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const emptycart(),
                              ));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CartPage(back: widget.back,),
                              ));
                        }
                      },
                      child: Container(
                          width: w / 11,
                          height: h / 22,
                          decoration: BoxDecoration(
                              color: Colors.red.shade500.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(w * 0.025)),
                          child: const Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.white,
                            size: 25,
                          )),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(w * 0.05),
                              topLeft: Radius.circular(w * 0.05))),
                      width: w,
                      height: h * 0.6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "${widget.itemList[widget.inx].itemName} ${widget.itemList[widget.inx].itemType}",
                                  style: TextStyle(
                                      fontSize: w / 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                Center(
                                  child: IconButton(
                                    onPressed: () {setState(() {

                                  if (wishList.isEmpty) {
                                      wishList.add(Wishlist(
                                          itemImage: widget
                                              .itemList[widget.inx].itemImage,
                                          itemType: widget
                                              .itemList[widget.inx].itemType,
                                          itemPrice: widget
                                              .itemList[widget.inx].itemPrice,
                                          itemName: widget
                                              .itemList[widget.inx].itemName,
                                          itemQuantity: widget.itemList[widget.inx].itemQuantity,

                                          id: widget.itemList[widget.inx].id));
                                      widget.itemList[widget.inx].isWishlisted = true;
                                      widget.fav(wishList.length);

                                    } else {
                                      int c = 0;
                                      for (int i = 0; i < wishList.length; i++) {
                                        if (widget.itemList[widget.inx].id ==
                                            wishList[i].id) {
                                          c++;
                                          widget.itemList[widget.inx].isWishlisted = false;
                                          wishList.removeAt(i);
                                          widget.fav(wishList.length);
                                        }
                                      }
                                      if (c == 0) {
                                        wishList.add(Wishlist(
                                            itemImage: widget
                                                .itemList[widget.inx].itemImage,
                                            itemType: widget
                                                .itemList[widget.inx].itemType,
                                            itemPrice: widget
                                                .itemList[widget.inx].itemPrice,
                                            itemName: widget
                                                .itemList[widget.inx].itemName,
                                            itemQuantity: widget.itemList[widget.inx].itemQuantity,

                                            id: widget.itemList[widget.inx].id));
                                        widget.itemList[widget.inx].isWishlisted = true;
                                        widget.fav(wishList.length);

                                      }
                                    }
                                    });

                                    },
                                    icon: Icon(
                                      Icons.favorite,
                                      color: widget
                                              .itemList[widget.inx].isWishlisted
                                          ? Colors.red
                                          : Colors.grey,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                RatingBar.builder(
                                  itemSize: w * 0.0875,
                                  initialRating: 0,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding:
                                      const EdgeInsets.symmetric(horizontal: 4.0),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    setState(() {
                                      ratingVar = rating;
                                    });
                                  },
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  width: w * 0.2,
                                  height: w * 0.1,
                                  decoration: BoxDecoration(
                                      color: Colors.red.shade900,
                                      borderRadius:
                                          BorderRadius.circular(w * 0.045)),
                                  child: Center(
                                      child: Text(
                                    "${ratingVar.toString()}/5",
                                    style: TextStyle(
                                        fontSize: w * 0.055,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 28.0),
                            child: Row(
                              children: [
                                Text(
                                  "Price \$$totalprice",
                                  style: TextStyle(
                                      fontSize: w * 0.0625,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 28.0),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      widget
                                          .itemList[widget.inx].itemQuantity--;
                                      totalprice = widget
                                              .itemList[widget.inx].itemPrice *
                                          (widget.itemList[widget.inx]
                                              .itemQuantity);
                                      if (widget.itemList[widget.inx]
                                              .itemQuantity <
                                          1) {
                                        widget.itemList[widget.inx]
                                            .itemQuantity = 1;
                                        totalprice = widget.itemList[widget.inx]
                                                .itemPrice *
                                            (widget.itemList[widget.inx]
                                                .itemQuantity);
                                      }
                                    });
                                  },
                                  child: Container(
                                    width: w / 13,
                                    height: w / 13,
                                    decoration: BoxDecoration(
                                        color: Colors.red.shade900,
                                        borderRadius:
                                            BorderRadius.circular(w * 0.0125)),
                                    child: const Icon(
                                      CupertinoIcons.minus,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8.0,
                                  ),
                                  child: Text(
                                    widget.itemList[widget.inx].itemQuantity
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: w * 0.05,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        widget.itemList[widget.inx]
                                            .itemQuantity++;
                                        totalprice = widget.itemList[widget.inx]
                                                .itemPrice *
                                            (widget.itemList[widget.inx]
                                                .itemQuantity);
                                      });
                                    },
                                    child: Container(
                                      width: w / 13,
                                      height: w / 13,
                                      decoration: BoxDecoration(
                                          color: Colors.red.shade900,
                                          borderRadius: BorderRadius.circular(
                                              w * 0.0125)),
                                      child: const Icon(
                                        CupertinoIcons.add,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 28.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Cold,creamy,thick ${widget.itemList[widget.inx].itemName}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  "${widget.itemList[widget.inx].itemType} filled with",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  "juicy ${widget.itemList[widget.inx].itemName}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (cartList.isEmpty) {
                                    cartList.add(Cart(
                                        itemImage: widget
                                            .itemList[widget.inx].itemImage,
                                        itemType: widget
                                            .itemList[widget.inx].itemType,
                                        itemPrice: widget
                                            .itemList[widget.inx].itemPrice,
                                        itemName: widget
                                            .itemList[widget.inx].itemName,
                                        itemQuantity: widget
                                            .itemList[widget.inx].itemQuantity,
                                        id: widget.itemList[widget.inx].id));

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CartPage(back: widget.back,),
                                        ));
                                    widget.back(cartList.length);
                                    wishList[widget.inx].isCarted=true;
                                  } else {
                                    int c = 0;
                                    for (int i = 0; i < cartList.length; i++) {
                                      if (widget.itemList[widget.inx].id ==
                                          cartList[i].id) {
                                        c++;
                                      }
                                    }
                                    if (c == 0) {
                                      cartList.add(Cart(
                                          itemImage: widget
                                              .itemList[widget.inx].itemImage,
                                          itemType: widget
                                              .itemList[widget.inx].itemType,
                                          itemPrice: widget
                                              .itemList[widget.inx].itemPrice,
                                          itemName: widget
                                              .itemList[widget.inx].itemName,
                                          itemQuantity: widget
                                              .itemList[widget.inx]
                                              .itemQuantity,
                                          id: widget.itemList[widget.inx].id));

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => CartPage(back: widget.back),
                                          ));
                                      widget.back(cartList.length);
                                      wishList[widget.inx].isCarted=true;
                                    }
                                    else{
                                      final snackBar=SnackBar(content: const Text("Item Already in Cart"),
                                      backgroundColor: Colors.red,
                                      action: SnackBarAction(label: "OK", onPressed:(){}),);
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    }
                                  }
                                });
                              },
                              child: Container(
                                width: w * 0.8,
                                height: w * 0.13,
                                decoration: BoxDecoration(
                                    color: Colors.red.shade900,
                                    borderRadius:
                                        BorderRadius.circular(w * 0.0625)),
                                child: Center(
                                    child: Text(
                                  "Add to Cart",
                                  style: TextStyle(
                                      fontSize: w * 0.0625,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      left: w * 0.1,
                      child: SizedBox(
                          height: h * 0.45,
                          width: w * 0.8,
                          child: Image(
                            image: AssetImage(
                                widget.itemList[widget.inx].itemImage),
                            fit: BoxFit.fill,
                          )))
                ],
              ))),
    );
  }
}
