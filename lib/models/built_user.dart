import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter/foundation.dart';

part 'built_user.g.dart';

abstract class BuiltUser implements Built<BuiltUser, BuiltUserBuilder> {
  // IDs are set in the back-end.
  // In a POST request, BuiltPost's ID will be null.
  // Only BuiltPosts obtained through a GET request will have an ID.
  @nullable
  int get id;

  @nullable
  String get email;

  @nullable
  String get username;

  @nullable
  String get token;

  @nullable
  String get response;

  @nullable
  @BuiltValueField(wireName: 'error_message')
  String get errorMessage;

  @nullable
  String get password;

  @nullable
  String get password2;

  BuiltUser._();

  factory BuiltUser([updates(BuiltUserBuilder b)]) = _$BuiltUser;

  static Serializer<BuiltUser> get serializer => _$builtUserSerializer;
}
