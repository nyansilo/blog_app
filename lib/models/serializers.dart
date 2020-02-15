import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

import 'built_post.dart';
import 'built_user.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  BuiltPost,
  BuiltUser,
])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
