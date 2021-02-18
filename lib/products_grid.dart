import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/product.dart';

import 'product_item.dart';
import 'provider/products.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFav;

  const ProductsGrid(this.showFav);
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showFav?productsData.favoriteItem : productsData.items;
    return GridView.builder(
        // padding: EdgeInsets.all(10),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 3 / 2,
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (ctx, i) {
          return ChangeNotifierProvider(
            create: (c) => products[i],
            child: ProductItem(
                // products[i].id,
                // products[i].title,
                // products[i].imageUrl,
            ),
          );
        });
  }
}
