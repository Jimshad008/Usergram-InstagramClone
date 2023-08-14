import 'package:flutter/material.dart';
import 'package:task4/productDetail.dart';

import 'Whitslist.dart';
import 'list.dart';
import 'models/itemModel.dart';
import 'models/wishlistModel.dart';

var w;
var h;

class CategoryItems extends StatefulWidget {
  final Function back;
  final Function fav;
  List<Items> itemList;

  CategoryItems({
    super.key,
    required this.back,
    required this.fav,
    required this.itemList,
  });

  @override
  State<CategoryItems> createState() => _CategoryItemsState();
}

class _CategoryItemsState extends State<CategoryItems> {
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.sizeOf(context).width;
    h = MediaQuery.sizeOf(context).height;
    return ListView.builder(
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(9.0),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProductDetail(
                  itemList: widget.itemList,
                  inx: index,
                  back: widget.back,
                  fav: widget.fav),
            ));
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(w * 0.05),
                  topLeft: Radius.elliptical(w * 0.75, w * 0.525),
                  bottomRight: Radius.circular(w * 0.05),
                  topRight: Radius.circular(w * 0.05)),
            ),
            width: w / 2,
            height: w / 2,
            child: Stack(
              children: [
                Positioned(
                  bottom: w * 0.225,
                  child: Container(
                      width: w * 0.325,
                      height: w * 0.325,
                      child: Image(
                        image: AssetImage(widget.itemList[index].itemImage),
                        fit: BoxFit.fill,
                      )),
                ),
                Positioned(
                  left: w * 0.3875,
                  child: Container(
                      width: w / 11,
                      height: w / 11,
                      decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius:
                              BorderRadius.all(Radius.circular(w * 0.0625))),
                      child: IconButton(
                        onPressed: () {setState(() {


                          if (wishList.isEmpty) {
                            wishList.add(Wishlist(
                                itemImage: widget.itemList[index].itemImage,
                                itemType: widget.itemList[index].itemType,
                                itemPrice: widget.itemList[index].itemPrice,
                                itemName: widget.itemList[index].itemName,
                                id: widget.itemList[index].id,
                                itemQuantity:
                                    widget.itemList[index].itemQuantity));

                            widget.itemList[index].isWishlisted = true;
                            widget.fav(wishList.length);
                          } else {
                            int c = 0;
                            for (int i = 0; i < wishList.length; i++) {
                              if (widget.itemList[index].id == wishList[i].id) {
                                c++;
                                widget.itemList[index].isWishlisted = false;
                                wishList.removeAt(i);
                                widget.fav(wishList.length);
                              }
                            }

                            if (c == 0) {
                              wishList.add(Wishlist(
                                  itemImage: widget.itemList[index].itemImage,
                                  itemType: widget.itemList[index].itemType,
                                  itemPrice: widget.itemList[index].itemPrice,
                                  itemName: widget.itemList[index].itemName,
                                  id: widget.itemList[index].id,
                                  itemQuantity:
                                  widget.itemList[index].itemQuantity));
                              widget.itemList[index].isWishlisted = true;
                              widget.fav(wishList.length);
                            }
                          }
                        });
                        },
                        icon: Icon(Icons.favorite,
                            color: widget.itemList[index].isWishlisted
                                ? Colors.red
                                : Colors.grey),
                      )),
                ),
                Positioned(
                  left: w * 0.05,
                  bottom: w * 0.05,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.itemList[index].itemName,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Text(
                        widget.itemList[index].itemType,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Text(
                        "\$${widget.itemList[index].itemPrice}",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      itemCount: widget.itemList.length,
      padding: EdgeInsets.all(10),
    );
  }
}
