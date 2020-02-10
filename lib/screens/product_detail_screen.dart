import 'package:blog/providers/post_provider.dart';
import 'package:blog/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  // final String title;
  // final double price;

  // ProductDetailScreen(this.title, this.price);
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productId =
        // ModalRoute.of(context).settings.arguments as String;
        ModalRoute.of(context).settings.arguments as int; // is the id!
    final loadedProduct = Provider.of<PostProvider>(
      context,
      listen: false,
    ).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                "${loadedProduct.thumbnail}",
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Text(
              dateFormatter(loadedProduct.timestamp),
              style: TextStyle(
                color: Colors.grey,
                fontSize: 10,
              ),
            ),
            SizedBox(height: 5),
            Text(
              '${loadedProduct.title}',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                loadedProduct.overview,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
