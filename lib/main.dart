import 'package:flutter/material.dart';
import 'package:shop/product_details_screen.dart';
import 'package:shop/product_overview_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.deepOrange,
        fontFamily: 'Lato',
      ),
      home: ProductOverviewScreen(),
      routes: {
        ProductDetailsScreen.routeName:(ctx)=>ProductDetailsScreen(), 
      },
    );
  }
}

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Shops'),
//       ),
//       body: Text('Welcome....'),
//     );
//   }
// }
