import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/badge.dart';
import 'package:shop/cart_screen.dart';
import 'package:shop/provider/products.dart';

import 'products_grid.dart';
import 'provider/cart.dart';

enum Filters {
  Favorities,
  SameScreen,
}

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showOnlyFavorities = false;
  @override
  Widget build(BuildContext context) {
    // final productsContainer = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: [
          PopupMenuButton(
            onSelected: (Filters selectedValue) {
              setState(() {
                if (selectedValue == Filters.Favorities) {
                  _showOnlyFavorities = true;
                  // productsContainer.showFavoritiesOnly();
                } else {
                  _showOnlyFavorities = false;
                  // productsContainer.showOnly();
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Favorities'),
                value: Filters.Favorities,
              ),
              PopupMenuItem(
                child: Text('Same screen'),
                value: Filters.SameScreen,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: (){
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ),
          ),
        ],
      ),
      body: ProductsGrid(_showOnlyFavorities),
    );
  }
}
