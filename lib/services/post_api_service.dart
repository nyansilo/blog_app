import 'package:blog/models/built_post.dart';
import 'package:chopper/chopper.dart';
import 'package:built_collection/built_collection.dart';
import 'built_value_converter.dart';
import "dart:async";

// Source code generation in Dart works by creating a new file which contains a "companion class".
// In order for the source gen to know which file to generate and which files are "linked", you need to use the part keyword.
part 'post_api_service.chopper.dart';

@ChopperApi(baseUrl: '/blog')
abstract class PostApiService extends ChopperService {
  @Get(path: 'blog-list')
  Future<Response<BuiltList<BuiltPost>>> getPosts();

  @Get(path: 'detail/{id}')
  // Query parameters are specified the same way as @Path
  // but obviously with a @Query annotation
  // For single returned objects, response will hold only one BuiltPost
  Future<Response<BuiltPost>> getPost(@Path('id') int id);

  // Put & Patch requests are specified the same way - they must contain the @Body
  @Post(path: 'create')
  //@multipart
  Future<Response<BuiltPost>> createPost(
    @Body() BuiltPost post,
  );

  @Put(path: 'update/{id}')
  //@multipart
  Future<Response<BuiltPost>> updatePost(
    @Path('id') int id,
    @Body() BuiltPost post,
  );

  @Delete(path: 'delete/{id}')
  Future<Response<BuiltPost>> deletePost(@Path('id') int id);

  static PostApiService create() {
    final client = ChopperClient(
      // The first part of the URL is now here
      baseUrl: 'http://127.0.0.1:8000/api',
      //baseUrl: 'https://jsonplaceholder.typicode.com',
      services: [
        // The generated implementation
        _$PostApiService(),
      ],
      interceptors: [
        HeadersInterceptor({'Cache-Control': 'no-cache'}),
        HttpLoggingInterceptor(),
        //CurlInterceptor()
        (Request request) async {
          if (request.method == HttpMethod.Post) {
            chopperLogger.info('Performed a POST request');
          }
          return request;
        },
        (Response response) async {
          if (response.statusCode == 404) {
            chopperLogger.severe('404 NOT FOUND');
          }
          return response;
        },
      ],
      // Converts data to & from JSON and adds the application/json header.
      converter: BuiltValueConverter(),
    );

    // The generated class with the ChopperClient passed in
    return _$PostApiService(client);
  }
}
