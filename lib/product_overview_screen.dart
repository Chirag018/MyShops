import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/provider/products.dart';

import 'products_grid.dart';

enum Filters {
  Favorities,
  SameScreen,
}

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showOnlyFavorities=false;
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
                _showOnlyFavorities=true;
                // productsContainer.showFavoritiesOnly();
              } else {
                _showOnlyFavorities=false;
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
        ],
      ),
      body: ProductsGrid(_showOnlyFavorities),
    );
  }
}
