import 'package:blog/models/built_post.dart';
import 'package:chopper/chopper.dart';
import 'package:built_collection/built_collection.dart';
import 'built_value_converter.dart';
import "dart:async";

// Source code generation in Dart works by creating a new file which contains a "companion class".
// In order for the source gen to know which file to generate and which files are "linked", you need to use the part keyword.
part 'post_api_service.chopper.dart';

//String token = "Token " + token;

@ChopperApi(baseUrl: '/blog')
abstract class PostApiService extends ChopperService {
  static const Map<String, String> _headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  //GET ALL POSTS POST REQUEST
  @Get(
    path: 'blog-list',
    headers: _headers,
  )
  Future<Response<BuiltList<BuiltPost>>> getPosts(
    @Header("Authorization") String authorization,
    @Query() int search,
    @Query() int ordering,
  );

  //GET SINGLE POST REQUEST
  @Get(
    path: 'detail/{id}',
    headers: _headers,
  )

// Query parameters are specified the same way as @Path
// but obviously with a @Query annotation
// For single returned objects, response will hold only one BuiltPost
//Use the Query annotation to add query parameters to the url
//  Future<Response> search({
//     @Query() String name,
//     @Query('int') int number,
//     @Query('default_value') int def = 42,
// });

// If you prefer to pass to pass a full Map you can use the QueryMap annotation
// Future<Response> search(@QueryMap() Map<String, dynamic> query);

//{@Query('q') String path = 'flutter:featured'}
  //{
  //@Query() String username,
  //@Query() int author,
  //}
  //@Query() int search,

  //GET SINGLE POST REQUE
  Future<Response<BuiltPost>> getPost(
    @Header("Authorization") String authorization,
    @Path('id') int id,
  );

  //CREATE POST REQUEST
  @Post(
    path: 'create',
    headers: _headers,
  )
  //@multipart
  Future<Response<BuiltPost>> createPost(
    @Header("Authorization") String authorization,
    @Body() BuiltPost post,
  );

  //UPDATING POST REQUEST
  @Put(
    path: 'update/{id}',
    headers: _headers,
  )
  //@multipart
  Future<Response<BuiltPost>> updatePost(
    @Header("Authorization") String authorization,
    @Path('id') int id,
    @Body() BuiltPost post,
  );

  //DELETE POST REQUEST
  @Delete(
    path: 'delete/{id}',
    headers: _headers,
  )
  Future<Response<BuiltPost>> deletePost(
    @Header("Authorization") String authorization,
    @Path('id') int id,
  );

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
