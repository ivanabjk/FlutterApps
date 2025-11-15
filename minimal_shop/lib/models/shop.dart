import 'package:flutter/cupertino.dart';
import 'package:minimal_shop/models/product.dart';

class Shop extends ChangeNotifier{
  // products for sale

  final List<Product> _shop = [
    Product(
      name: "Product 1",
      price: 99.99,
      description: "Item description to describe the product more into here will look like this.",
      imagePath: "assets/jacket.jpg",
    ),
    Product(
      name: "Product 2",
      price: 99.99,
      description: "Item description...",
      imagePath: "assets/jeans.jpg",
    ),
    Product(
      name: "Product 3",
      price: 99.99,
      description: "Item description...",
      imagePath: "assets/boots.jpg",

    ),
    Product(
      name: "Product 4",
      price: 99.99,
      description: "Item description...",
      imagePath: "assets/sweater.jpg",

    ),
  ];

  // user cart

  List<Product> _cart = [];

  // get product list

  List<Product> get shop => _shop;

  // get user cart
  List<Product> get cart => _cart;

  // add item to cart
  void addToCart(Product item){
    _cart.add(item);
    notifyListeners();
  }

  // remove item from cart
  void removeFromCart(Product item){
    _cart.remove(item);
    notifyListeners();
  }
}