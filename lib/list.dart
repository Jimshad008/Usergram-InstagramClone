import 'package:task4/models/wishlistModel.dart';

import 'Cart.dart';
import 'models/cartModel.dart';
import 'models/itemModel.dart';

List <Items> shakesList=[
  Items(itemName: "Strawberry ",itemType: "Smoothie" , itemImage: "assets/images/13.png", itemPrice: 10, itemQuantity: 1,isWishlisted: false,id: 101),
  Items(itemName: "Mango" ,itemType: "Smoothie" , itemImage: "assets/images/12.png", itemPrice: 15, itemQuantity: 1,isWishlisted: false,id: 102),
  Items(itemName: "Kiwi ",itemType: "Smoothie" , itemImage: "assets/images/11.png", itemPrice: 30, itemQuantity: 1,isWishlisted: false,id: 103),
  Items(itemName: "Chocolate" ,itemType: "Smoothie" , itemImage: "assets/images/15.png", itemPrice: 20, itemQuantity: 1,isWishlisted: false,id: 104)
];
List <Items> cocktailList=[
  Items(itemName: "Mango", itemType: "Cocktail" , itemImage: "assets/images/7.png", itemPrice: 40, itemQuantity: 1,isWishlisted: false,id: 205),
  Items(itemName: "Kiwi", itemType: "Cocktail", itemImage: "assets/images/10.png", itemPrice: 75, itemQuantity: 1,isWishlisted: false,id: 206),
  Items(itemName: "Blue ", itemType: "Cocktail", itemImage: "assets/images/9.png", itemPrice: 60, itemQuantity: 1,isWishlisted: false,id: 207),
  Items(itemName: "Strawberry ", itemType: "Cocktail", itemImage: "assets/images/8.png", itemPrice: 45, itemQuantity: 1,isWishlisted: false,id: 208)
];
List <Items> mocktailList=[
  Items(itemName: "Mixed Fruit",itemType: "Mocktail" , itemImage: "assets/images/16.png", itemPrice: 100, itemQuantity: 1,isWishlisted: false,id: 301),
  Items(itemName: "Lemon",itemType: "Mocktail" , itemImage: "assets/images/17.png", itemPrice: 70, itemQuantity: 1,isWishlisted: false,id: 302),
  Items(itemName: "Special",itemType: "Mocktail" , itemImage: "assets/images/18.png", itemPrice: 90, itemQuantity: 1,isWishlisted: false,id: 303),
  Items(itemName: "Strawberry",itemType: "Mocktail" , itemImage: "assets/images/19.png", itemPrice: 105, itemQuantity: 1,isWishlisted: false,id: 304)
];
List <Items> coffeeList=[
  Items(itemName: "Cappuccino",itemType: "Coffee" , itemImage: "assets/images/20.png", itemPrice: 50, itemQuantity: 1,isWishlisted: false,id: 405),
  Items(itemName: "Normal",itemType: "Coffee" , itemImage: "assets/images/22.png", itemPrice: 15, itemQuantity: 1,isWishlisted: false,id: 406),
  Items(itemName: "Smokii",itemType: "Coffee" , itemImage: "assets/images/23.png", itemPrice: 120, itemQuantity: 1,isWishlisted: false,id: 407),
  Items(itemName: "Black",itemType: "Coffee" , itemImage: "assets/images/24.png", itemPrice: 20, itemQuantity: 1,isWishlisted: false,id: 408)
];
List<Cart>cartList=[];
List<Wishlist>wishList=[];
