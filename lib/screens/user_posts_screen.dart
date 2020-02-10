import '../providers/post_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../widgets/user_post_item.dart';
import '../widgets/app_drawer.dart';
import './edit_post_screen.dart';
//import './edit_product_screen.dart';

class UserPostsScreen extends StatelessWidget {
  static const routeName = '/user-posts';

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<PostProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Posts'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditPostScreen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productsData.posts.length,
          itemBuilder: (_, i) => Column(
            children: [
              UserPostItem(
                productsData.posts[i].id,
                productsData.posts[i].title,
                productsData.posts[i].overview,
                productsData.posts[i].thumbnail,
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
