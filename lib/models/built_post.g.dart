// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'built_post.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BuiltPost> _$builtPostSerializer = new _$BuiltPostSerializer();

class _$BuiltPostSerializer implements StructuredSerializer<BuiltPost> {
  @override
  final Iterable<Type> types = const [BuiltPost, _$BuiltPost];
  @override
  final String wireName = 'BuiltPost';

  @override
  Iterable<Object> serialize(Serializers serializers, BuiltPost object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(int)));
    }
    if (object.slug != null) {
      result
        ..add('slug')
        ..add(serializers.serialize(object.slug,
            specifiedType: const FullType(String)));
    }
    if (object.title != null) {
      result
        ..add('title')
        ..add(serializers.serialize(object.title,
            specifiedType: const FullType(String)));
    }
    if (object.timestamp != null) {
      result
        ..add('timestamp')
        ..add(serializers.serialize(object.timestamp,
            specifiedType: const FullType(String)));
    }
    if (object.overview != null) {
      result
        ..add('overview')
        ..add(serializers.serialize(object.overview,
            specifiedType: const FullType(String)));
    }
    if (object.username != null) {
      result
        ..add('username')
        ..add(serializers.serialize(object.username,
            specifiedType: const FullType(String)));
    }
    if (object.author != null) {
      result
        ..add('author')
        ..add(serializers.serialize(object.author,
            specifiedType: const FullType(int)));
    }
    if (object.thumbnail != null) {
      result
        ..add('thumbnail')
        ..add(serializers.serialize(object.thumbnail,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  BuiltPost deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BuiltPostBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'slug':
          result.slug = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'timestamp':
          result.timestamp = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'overview':
          result.overview = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'username':
          result.username = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'author':
          result.author = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'thumbnail':
          result.thumbnail = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$BuiltPost extends BuiltPost {
  @override
  final int id;
  @override
  final String slug;
  @override
  final String title;
  @override
  final String timestamp;
  @override
  final String overview;
  @override
  final String username;
  @override
  final int author;
  @override
  final String thumbnail;

  factory _$BuiltPost([void Function(BuiltPostBuilder) updates]) =>
      (new BuiltPostBuilder()..update(updates)).build();

  _$BuiltPost._(
      {this.id,
      this.slug,
      this.title,
      this.timestamp,
      this.overview,
      this.username,
      this.author,
      this.thumbnail})
      : super._();

  @override
  BuiltPost rebuild(void Function(BuiltPostBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BuiltPostBuilder toBuilder() => new BuiltPostBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BuiltPost &&
        id == other.id &&
        slug == other.slug &&
        title == other.title &&
        timestamp == other.timestamp &&
        overview == other.overview &&
        username == other.username &&
        author == other.author &&
        thumbnail == other.thumbnail;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, id.hashCode), slug.hashCode),
                            title.hashCode),
                        timestamp.hashCode),
                    overview.hashCode),
                username.hashCode),
            author.hashCode),
        thumbnail.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BuiltPost')
          ..add('id', id)
          ..add('slug', slug)
          ..add('title', title)
          ..add('timestamp', timestamp)
          ..add('overview', overview)
          ..add('username', username)
          ..add('author', author)
          ..add('thumbnail', thumbnail))
        .toString();
  }
}

class BuiltPostBuilder implements Builder<BuiltPost, BuiltPostBuilder> {
  _$BuiltPost _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _slug;
  String get slug => _$this._slug;
  set slug(String slug) => _$this._slug = slug;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  String _timestamp;
  String get timestamp => _$this._timestamp;
  set timestamp(String timestamp) => _$this._timestamp = timestamp;

  String _overview;
  String get overview => _$this._overview;
  set overview(String overview) => _$this._overview = overview;

  String _username;
  String get username => _$this._username;
  set username(String username) => _$this._username = username;

  int _author;
  int get author => _$this._author;
  set author(int author) => _$this._author = author;

  String _thumbnail;
  String get thumbnail => _$this._thumbnail;
  set thumbnail(String thumbnail) => _$this._thumbnail = thumbnail;

  BuiltPostBuilder();

  BuiltPostBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _slug = _$v.slug;
      _title = _$v.title;
      _timestamp = _$v.timestamp;
      _overview = _$v.overview;
      _username = _$v.username;
      _author = _$v.author;
      _thumbnail = _$v.thumbnail;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BuiltPost other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$BuiltPost;
  }

  @override
  void update(void Function(BuiltPostBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$BuiltPost build() {
    final _$result = _$v ??
        new _$BuiltPost._(
            id: id,
            slug: slug,
            title: title,
            timestamp: timestamp,
            overview: overview,
            username: username,
            author: author,
            thumbnail: thumbnail);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
