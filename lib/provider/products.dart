import 'dart:convert';
//import 'dart:html';
//import 'dart:html';

import 'package:flutter/material.dart';
// import 'package:shop/widgets/product_item.dart';
import 'package:http/http.dart' as http;
import 'package:shop/models/http_exception.dart';
import 'product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];
  // var _showFavoritesOnly=false;
  List<Product> get items {
    // if(_showFavoritesOnly)
    // return _items.where((prodItem) => prodItem.isFavorite).toList();
    return [..._items];
  }

  List<Product> get favoriteItem {
    return _items.where((ProductItem) => ProductItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  // void showFavoritiesOnly(){}
  //   _showFavoritesOnly=true;
  //   notifyListeners();
  // }
  // void showOnly(){
  //   _showFavoritesOnly=false;
  //   notifyListeners();
  // }

  Future<void> fetchAndSetProducts() async {
    const url =
        'https://sampleapp-583bf-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.get(url);
      print(json.decode(response.body));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      if(extractedData==null)
      return;
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(
          Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            isFavorite: prodData['isFavorite'],
            imaageUrl: prodData['imaageUrl'],
          ),
        );
      });

      _items = loadedProducts;
      notifyListeners();
      // print(json.decode(response.body));

      // print('hii');
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addProduct(Product product) async {
    const url =
        'https://sampleapp-583bf-default-rtdb.firebaseio.com/products.json';
    try {
      print("before await");
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imaageUrl': product.imaageUrl,
          'price': product.price,
          'isFavorite': product.isFavorite,
        }),
      );
      print("after wait");
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imaageUrl: product.imaageUrl,
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
    // .then((response) {

    // })
    // .catchError((error){

    // });

    // _items.add(value);
  }

  Future<void> updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url =
          'https://sampleapp-583bf-default-rtdb.firebaseio.com/products/$id.json';
      http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imaageUrl': newProduct.imaageUrl,
            'price': newProduct.price
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('........');
    }
  }

  Future<void> deleteProducts(String id) async {
    final url =
        'https://sampleapp-583bf-default-rtdb.firebaseio.com/products/$id.json';
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HTTPException('Could not delete product!');
    }
    existingProduct = null;
    // }).catchError((_) {
  }
}
