import 'package:flutter/foundation.dart';

class Products {
  final String id, title, description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Products({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite=false,   
  });
} 
