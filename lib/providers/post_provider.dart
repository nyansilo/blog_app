import 'package:blog/models/built_post.dart';
import 'package:blog/models/error_handling.dart';
import 'package:blog/services/post_api_service.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:built_collection/built_collection.dart';

class PostProvider with ChangeNotifier {
  List<BuiltPost> _posts = [];

  String _tokenId;
  int _authId;

  String get authToken {
    return _tokenId;
  }

  set authToken(String tkId) {
    _tokenId = tkId;
  }

  int get authId {
    return _authId;
  }

  set authId(int aId) {
    _authId = aId;
  }

  //PostProvider(this.authToken, this._posts);

  List<BuiltPost> get posts {
    return [..._posts];
  }

  BuiltPost findById(int id) {
    return _posts.firstWhere((prod) => prod.id == id);
  }

  Future<void> getAllPosts([bool filterByUser = false]) async {
    print("OuthToken is:");

    final filterPost = filterByUser ? _authId : null;
    print('filterString:');
    print(filterPost);

    //print(_tokenId);
    final secureToken = "Token " + _tokenId;
    //print(secureToken);
    print('Auth ID is:');
    print(_authId);

    Response<BuiltList<BuiltPost>> postResponse = await PostApiService.create()
        .getPosts(secureToken, filterPost, filterPost);

    final extractedData = postResponse.body;
    if (extractedData == null) {
      return;
    }
    print("Data After Login is:");
    print(extractedData);
    List<BuiltPost> loadedProducts = extractedData.toList();
    //print(loadedProducts);
    _posts = loadedProducts;
    //sort by date time implemented on builpost class
    _posts.sort(timestampComparator);
    notifyListeners();

    /*
  final List<BuiltPost>  loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(BuiltPost(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
  
        ));
      });
      _posts = loadedProducts;
      notifyListeners();
 
  */
  }

  Future<void> addProduct(BuiltPost post) async {
    final secureToken = "Token " + _tokenId;

    Response<BuiltPost> response =
        await PostApiService.create().createPost(secureToken, post);
    final responseData = response.body;
    if (responseData == null) {
      return;
    }
    //print('before response');
    //print(responseData);

    final newPost = BuiltPost(
      (b) => b
        ..id = responseData.id
        ..title = post.title
        ..overview = post.overview,
      //imageUrl: '',
    );

    print(newPost);

    //_posts.add(newPost);
    //insert fun insert on first pos of a list
    _posts.insert(0, newPost);
    notifyListeners();
  }

  Future<void> updatePost(int id, BuiltPost newPost) async {
    final secureToken = "Token " + _tokenId;

    final prodIndex = _posts.indexWhere((prod) => prod.id == id);

    if (prodIndex >= 0) {
      Response<BuiltPost> response =
          await PostApiService.create().updatePost(secureToken, id, newPost);
      final responseData = response.body;
      if (responseData == null) {
        return;
      }
      _posts[prodIndex] = newPost;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteProduct(int id) async {
    final secureToken = "Token " + _tokenId;

    Response<BuiltPost> response =
        await PostApiService.create().deletePost(secureToken, id);
    final existingProductIndex = _posts.indexWhere((prod) => prod.id == id);
    var existingProduct = _posts[existingProductIndex];
    _posts.removeAt(existingProductIndex);
    notifyListeners();

    if (response.statusCode >= 400) {
      _posts.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingProduct = null;
  }
}
