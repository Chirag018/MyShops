import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id, title, description;
  final double price;
  final String imaageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imaageUrl,
    this.isFavorite = false,
  });
   
   void toggleFavorite(){
     isFavorite=!isFavorite;
     notifyListeners();
   }

}
