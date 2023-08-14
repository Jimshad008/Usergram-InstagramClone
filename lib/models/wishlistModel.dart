class Wishlist{
  String itemName;
  String itemType;
  double itemPrice;
  String itemImage;
  int id;
  int itemQuantity;
  bool isCarted=false;
  Wishlist({required this.itemImage,required this.itemType,required this.itemPrice,required this.itemName,required this.id,required this.itemQuantity});
}