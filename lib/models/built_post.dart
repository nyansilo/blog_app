import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter/foundation.dart';

part 'built_post.g.dart';

abstract class BuiltPost implements Built<BuiltPost, BuiltPostBuilder> {
  // IDs are set in the back-end.
  // In a POST request, BuiltPost's ID will be null.
  // Only BuiltPosts obtained through a GET request will have an ID.
  @nullable
  int get id;

  @nullable
  String get slug;

  @nullable
  String get title;

  @nullable
  String get timestamp;

  @nullable
  String get overview;

  @nullable
  String get thumbnail;

  BuiltPost._();

  factory BuiltPost([updates(BuiltPostBuilder b)]) = _$BuiltPost;

  static Serializer<BuiltPost> get serializer => _$builtPostSerializer;
}

Comparator<BuiltPost> timestampComparator =
    (b, a) => a.timestamp.compareTo(b.timestamp);
