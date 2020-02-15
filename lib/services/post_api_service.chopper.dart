// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$PostApiService extends PostApiService {
  _$PostApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = PostApiService;

  @override
  Future<Response<BuiltList<BuiltPost>>> getPosts(
      String authorization, int search, int ordering) {
    final $url = '/blog/blog-list';
    final $params = <String, dynamic>{'search': search, 'ordering': ordering};
    final $headers = {
      'Authorization': authorization,
      'Content-type': 'application/json',
      'Accept': 'application/json'
    };
    final $request = Request('GET', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<BuiltList<BuiltPost>, BuiltPost>($request);
  }

  @override
  Future<Response<BuiltPost>> getPost(String authorization, int id) {
    final $url = '/blog/detail/$id';
    final $headers = {
      'Authorization': authorization,
      'Content-type': 'application/json',
      'Accept': 'application/json'
    };
    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<BuiltPost, BuiltPost>($request);
  }

  @override
  Future<Response<BuiltPost>> createPost(String authorization, BuiltPost post) {
    final $url = '/blog/create';
    final $headers = {
      'Authorization': authorization,
      'Content-type': 'application/json',
      'Accept': 'application/json'
    };
    final $body = post;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<BuiltPost, BuiltPost>($request);
  }

  @override
  Future<Response<BuiltPost>> updatePost(
      String authorization, int id, BuiltPost post) {
    final $url = '/blog/update/$id';
    final $headers = {
      'Authorization': authorization,
      'Content-type': 'application/json',
      'Accept': 'application/json'
    };
    final $body = post;
    final $request =
        Request('PUT', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<BuiltPost, BuiltPost>($request);
  }

  @override
  Future<Response<BuiltPost>> deletePost(String authorization, int id) {
    final $url = '/blog/delete/$id';
    final $headers = {
      'Authorization': authorization,
      'Content-type': 'application/json',
      'Accept': 'application/json'
    };
    final $request = Request('DELETE', $url, client.baseUrl, headers: $headers);
    return client.send<BuiltPost, BuiltPost>($request);
  }
}
