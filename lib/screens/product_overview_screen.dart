import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/widgets/app_drawer.dart';
import 'package:shop/widgets/badge.dart'; 
import 'package:shop/screens/cart_screen.dart';
import 'package:shop/provider/products.dart';

import '../widgets/products_grid.dart';
import '../provider/cart.dart';

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
  var _isInit = false;
  var _isLoading = false;

  @override
  void initState() {
    // Provider.of<Products>(context).fetchAndSetProducts();
    // One Method to add products in the screen permanently
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<Products>(context).fetchAndSetProducts();
    // });
    super.initState();
  }

  //2nd method is didChangeDependencies
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

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
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(_showOnlyFavorities),
    );
  }
}
