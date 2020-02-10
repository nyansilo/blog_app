import '../widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blog/providers/post_provider.dart';

import '../widgets/products_grid.dart';

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  // var _isInit = true;

/*
  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<PostProvider>(context).getAllPosts();
    }
    _isInit = false;
    super.didChangeDependencies();
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyBlog'),
      ),
      body: ProductsGrid(),
      drawer: AppDrawer(),
    );
  }
}
