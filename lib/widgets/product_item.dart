import 'package:blog/models/built_post.dart';
import 'package:blog/providers/post_provider.dart';
import 'package:blog/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  final Color bgColor = Color(0xffF3F3F3);
  final Color primaryColor = Color(0xffE70F0B);

  final titleTextStyle = TextStyle(
    color: Colors.black87,
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
  );
  final teamNameTextStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
    color: Colors.grey.shade800,
  );

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
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      ProductDetailScreen.routeName,
                      arguments: post.id,
                    );
                  },
                  child: Container(
                    height: 200.0,
                    child: post.thumbnail != null
                        ? CachedNetworkImage(
                            imageUrl: "http://via.placeholder.com/200x150",
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                ),
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    "${post.thumbnail}",
                                  ),
                                  fit: BoxFit.cover,
                                  // colorFilter: ColorFilter.mode(
                                  //   Colors.red,
                                  //   BlendMode.colorBurn,
                                  // ),
                                ),
                              ),
                            ),
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          )
                        : new Container(
                            decoration: new BoxDecoration(color: Colors.amber),
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "${post.title}",
                    style: titleTextStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        dateFormatter(post.timestamp),
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "category",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
              ],
            ),
            Positioned(
              top: 190,
              left: 20.0,
              child: Container(
                color: Colors.green,
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  "LIVE",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
