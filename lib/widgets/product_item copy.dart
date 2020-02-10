import 'package:blog/models/built_post.dart';
import 'package:blog/providers/post_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  final BuiltPost post;

  //final String slug;
  //final String title;
  //final String overview;

  ProductItem(
    this.post,
    //this.title,
  ); //this.overview);

  @override
  Widget build(BuildContext context) {
    //final post = Provider.of<BuiltPost>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: post.id,
            );
          },
          //child: Image.network(
          //imageUrl,
          //fit: BoxFit.cover,
          //),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            icon: Icon(Icons.favorite),
            color: Theme.of(context).accentColor,
            onPressed: () {},
          ),
          title: Text(
            "${post.title}",
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {},
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
