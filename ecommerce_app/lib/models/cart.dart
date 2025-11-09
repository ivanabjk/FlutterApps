import 'package:ecommerce_app/models/shoe.dart';
import 'package:flutter/material.dart';

class Cart extends ChangeNotifier{
  // list of shoes for sale
  List<Shoe> shoeShop = [
    Shoe(
      name: "Zoom Freak",
      price: "236",
      description: "The forward-thinking design of his latest signature shoe.",
      imagePath: "lib/images/sneakers1.jpeg",
    ),
    Shoe(
      name: "Air Jordans",
      price: "220",
      description: "The forward-thinking design of his latest signature shoe.",
      imagePath: "lib/images/sneakers2.jpeg",
    ),
    Shoe(
      name: "KD Treys",
      price: "240",
      description: "The forward-thinking design of his latest signature shoe.",
      imagePath: "lib/images/sneakers3.jpeg",
    ),
    Shoe(
      name: "Kyrie 6",
      price: "190",
      description: "The forward-thinking design of his latest signature shoe.",
      imagePath: "lib/images/sneakers4.jpeg",
    ),
  ];

  // list of items in user cart

  List<Shoe> userCart = [];

  // get list of shoes for sale

  List<Shoe> getShoeList() {
    return shoeShop;
  }

  // get cart
  List<Shoe> getUserCart() {
    return userCart;
  }

  // add items to cart
  void addItemToCart(Shoe shoe) {
    userCart.add(shoe);
    notifyListeners();
  }

  // remove items from cart
  void removeItemFromCart(Shoe shoe) {
    userCart.remove(shoe);
    notifyListeners();
  }
}
