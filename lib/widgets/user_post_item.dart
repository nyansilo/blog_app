import 'package:blog/providers/post_provider.dart';
import 'package:blog/screens/edit_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//import '../screens/edit_product_screen.dart';
import '../providers/products.dart';

class UserPostItem extends StatelessWidget {
  final int id;
  final String title;
  final String overview;
  final String thumbnail;

  UserPostItem(this.id, this.title, this.overview, this.thumbnail);

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          '${thumbnail}',
        ),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  EditPostScreen.routeName,
                  arguments: id,
                );
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                try {
                  await Provider.of<PostProvider>(context, listen: false)
                      .deleteProduct(id);
                } catch (error) {
                  scaffold.showSnackBar(
                    SnackBar(
                      content: Text(
                        'Deleting failed!',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
