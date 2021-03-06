import 'package:blog/models/built_post.dart';
import 'package:blog/providers/post_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import './product_item.dart';

class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final postData = Provider.of<PostProvider>(context);
    //final posts = postData.posts;

    return FutureBuilder(
      future: Provider.of<PostProvider>(context, listen: false).getAllPosts(),
      builder: (ctx, dataSnapshot) {
        if (dataSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          if (dataSnapshot.error != null) {
            // ...
            // Do error handling stuff
            return Center(
              child: Text('An error occurred!'),
            );
          } else {
            return Consumer<PostProvider>(
              builder: (ctx, orderData, child) => ListView.builder(
                padding: const EdgeInsets.only(left: 10, right: 10),
                itemCount: orderData.posts.length,
                itemBuilder: (ctx, i) => ProductItem(orderData.posts[i]),
              ),
            );
          }
        }
      },
    );
  }
}
