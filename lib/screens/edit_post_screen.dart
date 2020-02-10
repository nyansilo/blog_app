import 'package:blog/providers/post_provider.dart';

import '../models/built_post.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

class EditPostScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  _EditPostScreenState createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  final _overviewFocusNode = FocusNode();
  //final _imageUrlController = TextEditingController();
  //final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  var _editedProduct = BuiltPost(
    (b) => b
      // id is null - it gets assigned in the backend
      ..id = null
      ..title = ' '
      ..overview = ' ',
    //imageUrl: '',
  );

  var _initValues = {
    'title': '',
    'overview': '',
    //'imageUrl': '',
  };
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    // _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      //final productId = ModalRoute.of(context).settings.arguments as String;
      final productId = ModalRoute.of(context).settings.arguments as int;
      if (productId != null) {
        _editedProduct = Provider.of<PostProvider>(context, listen: false)
            .findById(productId);
        _initValues = {
          'title': _editedProduct.title,
          'overview': _editedProduct.overview,
          // 'imageUrl': _editedProduct.imageUrl,
          //'imageUrl': '',
        };
        //_imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    //_imageUrlFocusNode.removeListener(_updateImageUrl);

    _overviewFocusNode.dispose();
    //_imageUrlController.dispose();
    //_imageUrlFocusNode.dispose();
    super.dispose();
  }

  /*
 void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') 
         && !_imageUrlController.text.startsWith('https')) ||
         (!_imageUrlController.text.endsWith('.png') 
         && !_imageUrlController.text.endsWith('.jpg')  
         && !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }*/

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();

    setState(() {
      _isLoading = true;
    });

    if (_editedProduct.id != null) {
      await Provider.of<PostProvider>(context, listen: false)
          .updatePost(_editedProduct.id, _editedProduct);
    } else {
      try {
        await Provider.of<PostProvider>(context, listen: false)
            .addProduct(_editedProduct);
      } catch (error) {
        print(error.toString());
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('An error occurred!'),
            content: Text('Something went wrong.'),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
        );
      }
      // finally {
      //   setState(() {
      //     _isLoading = false;
      //   });
      //   Navigator.of(context).pop();
      // }
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _initValues['title'],
                      decoration: InputDecoration(labelText: 'Title'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_overviewFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = BuiltPost(
                          (b) => b
                            ..title = value
                            ..overview = _editedProduct.title
                            ..id = _editedProduct.id,
                          //imageUrl: _editedProduct.imageUrl,
                          //id: _editedProduct.id,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['overview'],
                      decoration: InputDecoration(labelText: 'overview'),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      focusNode: _overviewFocusNode,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a overview.';
                        }
                        if (value.length < 10) {
                          return 'Should be at least 10 characters long.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = BuiltPost(
                          (b) => b
                            // id is null - it gets assigned in the backend
                            ..title = _editedProduct.title
                            ..overview = value
                            ..id = _editedProduct.id,
                        );
                      },
                    ),
                    /*
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(
                            top: 8,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          child: _imageUrlController.text.isEmpty  ? Text('Enter a URL')
                             
                              : FittedBox(
                                  child: Image.network(
                                    _imageUrlController.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'Image URL'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrlController,
                            focusNode: _imageUrlFocusNode,
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter an image URL.';
                              }
                              if (!value.startsWith('http') &&  !value.startsWith('https')) {
                                 
                                return 'Please enter a valid URL.';
                              }
                              if (!value.endsWith('.png') 
                              &&  !value.endsWith('.jpg') 
                              &&  !value.endsWith('.jpeg')) {
                                 
                                 
                                return 'Please enter a valid image URL.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _editedProduct = Product(
                                title: _editedProduct.title,
                                price: _editedProduct.price,
                                overview: _editedProduct.overview,
                                imageUrl: value,
                                id: _editedProduct.id,
                                isFavorite: _editedProduct.isFavorite,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    */
                  ],
                ),
              ),
            ),
    );
  }
}
