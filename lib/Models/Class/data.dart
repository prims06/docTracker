import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class AppData {
  static List<Product> productList = [
    Product(
        id: 1,
        name: 'Nike Air Max 200',
        price: 240.00,
        isSelected: true,
        isliked: false,
        image: 'assets/shooe_tilt_1.png',
        category: "Trending Now"),
    Product(
        id: 2,
        name: 'Nike Air Max 97',
        price: 220.00,
        isliked: false,
        image: 'assets/shoe_tilt_2.png',
        category: "Trending Now"),
  ];
  static List<Product> cartList = [
    Product(
        id: 1,
        name: 'Nike Air Max 200',
        price: 240.00,
        isSelected: true,
        isliked: false,
        image: 'assets/small_tilt_shoe_1.png',
        category: "Trending Now"),
    Product(
        id: 2,
        name: 'Nike Air Max 97',
        price: 190.00,
        isliked: false,
        image: 'assets/small_tilt_shoe_2.png',
        category: "Trending Now"),
    Product(
        id: 1,
        name: 'Nike Air Max 92607',
        price: 220.00,
        isliked: false,
        image: 'assets/small_tilt_shoe_3.png',
        category: "Trending Now"),
    Product(
        id: 2,
        name: 'Nike Air Max 200',
        price: 240.00,
        isSelected: true,
        isliked: false,
        image: 'assets/small_tilt_shoe_1.png',
        category: "Trending Now"),
    // Product(
    //     id:1,
    //     name: 'Nike Air Max 97',
    //     price: 190.00,
    //     isliked: false,
    //     image: 'assets/small_tilt_shoe_2.png',
    //     category: "Trending Now"),
  ];
  static List<Category> categoryList = [
    Category(
        id: 1,
        name: 'id_card'.i18n(),
        fieldName: 'id_card',
        asset: 'assets/icons/id-card.svg'),
    Category(
        id: 2,
        name: 'birth_certificate'.i18n(),
        fieldName: 'birth_certificate',
        asset: 'assets/icons/docs.svg'),
    Category(
        id: 3,
        name: 'driver_id'.i18n(),
        fieldName: 'driver_id',
        asset: 'assets/icons/driver.svg'),
    Category(
        id: 4,
        name: 'diploma'.i18n(),
        fieldName: 'diploma',
        asset: 'assets/icons/diploma.svg'),
    Category(
        id: 5,
        name: 'passport'.i18n(),
        fieldName: 'passport',
        asset: 'assets/icons/passport.svg'),
    Category(
        id: 6,
        name: 'others'.i18n(),
        fieldName: 'others',
        asset: 'assets/icons/driver.svg'),
  ];
  static List<String> showThumbnailList = [
    "assets/shoe_thumb_5.png",
    "assets/shoe_thumb_1.png",
    "assets/shoe_thumb_4.png",
    "assets/shoe_thumb_3.png",
  ];
  static String description =
      "Clean lines, versatile and timeless—the people shoe returns with the Nike Air Max 90. Featuring the same iconic Waffle sole, stitched overlays and classic TPU accents you come to love, it lets you walk among the pantheon of Air. ßNothing as fly, nothing as comfortable, nothing as proven. The Nike Air Max 90 stays true to its OG running roots with the iconic Waffle sole, stitched overlays and classic TPU details. Classic colours celebrate your fresh look while Max Air cushioning adds comfort to the journey.";
}

class Category {
  int id;
  String name;
  String fieldName;
  String asset;
  Category({required this.id, required this.name,required this.fieldName, required this.asset});
}

class Product {
  int id;
  String name;
  String category;
  String image;
  double price;
  bool isliked;
  bool isSelected;
  Product(
      {required this.id,
      required this.name,
      required this.category,
      required this.price,
      required this.isliked,
      this.isSelected = false,
      required this.image});
}
