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

  final definitionType = PostApiService;

  Future<Response<BuiltList<BuiltPost>>> getPosts() {
    final $url = '/blog/blog-list';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<BuiltList<BuiltPost>, BuiltPost>($request);
  }

  Future<Response<BuiltPost>> getPost(int id) {
    final $url = '/blog/detail/${id}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<BuiltPost, BuiltPost>($request);
  }

  Future<Response<BuiltPost>> createPost(BuiltPost post) {
    final $url = '/blog/create';
    final $body = post;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<BuiltPost, BuiltPost>($request);
  }

  Future<Response<BuiltPost>> updatePost(int id, BuiltPost post) {
    final $url = '/blog/update/${id}';
    final $body = post;
    final $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<BuiltPost, BuiltPost>($request);
  }

  Future<Response<BuiltPost>> deletePost(int id) {
    final $url = '/blog/delete/${id}';
    final $request = Request('DELETE', $url, client.baseUrl);
    return client.send<BuiltPost, BuiltPost>($request);
  }
}
