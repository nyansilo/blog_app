import 'package:blog/screens/splash_screen.dart';

import './providers/auth_provider.dart';

import './providers/post_provider.dart';
import './screens/auth_screen.dart';
import './screens/user_posts_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products.dart';
import './screens/edit_post_screen.dart';
import 'package:logging/logging.dart';

//void main() => runApp(MyApp());

void main() {
  _setupLogging();
  runApp(MyApp());
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AuthProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, PostProvider>(
          create: (_) => PostProvider(),
          update: (ctx, AuthProvider auth, PostProvider postProvider) {
            postProvider.authToken = auth.token;
            postProvider.authId = auth.userId;
            //update the previus state
            postProvider == null ? [] : postProvider.posts;
            return postProvider;
          },
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (ctx, auth, _) => MaterialApp(
            title: 'MyBlog',
            theme: ThemeData(
              primarySwatch: Colors.purple,
              accentColor: Colors.deepOrange,
              fontFamily: 'Lato',
            ),
            //home: ProductsOverviewScreen(),
            //home: auth.isAuth ? ProductsOverviewScreen() : AuthScreen(),
            home: auth.isAuth
                ? ProductsOverviewScreen()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (ctx, authResultSnapshot) =>
                        authResultSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? SplashScreen()
                            : AuthScreen(),
                  ),
            routes: {
              ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
              UserPostsScreen.routeName: (ctx) => UserPostsScreen(),
              EditPostScreen.routeName: (ctx) => EditPostScreen(),
            }),
      ),
    );
  }
}
