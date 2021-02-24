import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/provider/products.dart';
import 'package:shop/screens/edit_product_screen.dart';
import 'package:shop/widgets/app_drawer.dart';
import 'package:shop/widgets/user_production_item.dart';

class UserProductionScreen extends StatelessWidget {
  static const routeName='/user-product';
  @override
  Widget build(BuildContext context) {
    final productionData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
          drawer:AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: productionData.items.length,
          itemBuilder: (_, i) => Column(
            children: [
              UserProductionItem(
                productionData.items[i].title,
                productionData.items[i].imageUrl,
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
