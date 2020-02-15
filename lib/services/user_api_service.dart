import 'package:blog/models/built_user.dart';
import 'package:chopper/chopper.dart';
import 'package:built_collection/built_collection.dart';
import 'built_value_converter.dart';
import "dart:async";

import 'mobile_data_interceptor.dart';

// Source code generation in Dart works by creating a new file which contains a "companion class".
// In order for the source gen to know which file to generate and which files are "linked", you need to use the part keyword.
part 'user_api_service.chopper.dart';

@ChopperApi(baseUrl: '/account')
abstract class UserApiService extends ChopperService {
  //@Get(path: 'users')
  //Future<Response<BuiltList<BuiltUser>>> getUsers();

  //@Get(path: 'user/{id}')
  // Query parameters are specified the same way as @Path
  // but obviously with a @Query annotation
  // For single returned objects, response will hold only one BuiltPost
  // Future<Response<BuiltUser>> getUser(@Path('id') int id);

  // Put & Patch requests are specified the same way - they must contain the @Body
  @Post(path: 'register')
  Future<Response<BuiltUser>> userRegister(
    // @Field('email') String email,
    // @Field('username') String username,
    // @Field('password') String password,
    // @Field('password2') String password2,
    @Body() BuiltUser user,
  );

  //  headers: { 'Content-type': 'application/json',
  //             'Accept': 'application/json',
  //             "Authorization": "Some token"},

  @Post(path: 'login', headers: {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  })
  Future<Response<BuiltUser>> userLogin(
    //@Header('Authorization') String token,
    // @Field('email') String email,
    // @Field('username') String username,
    // @Field('password') String password,
    // @Field('password2') String password2,
    @Body() BuiltUser user,
  );

  //@Put(path: 'update/{id}')
  //@multipart
  // Future<Response<BuiltUser>> updateUser(
  //   @Path('id') int id,
  //   @Body() BuiltUser user,
  // );

  // @Delete(path: 'delete/{id}')
  // Future<Response<BuiltUser>> deleteUser(@Path('id') int id);

  static UserApiService create() {
    final client = ChopperClient(
      // The first part of the URL is now here
      baseUrl: 'http://127.0.0.1:8000/api',
      //baseUrl: 'https://jsonplaceholder.typicode.com',
      services: [
        // The generated implementation
        _$UserApiService(),
      ],
      interceptors: [
        HeadersInterceptor({'Cache-Control': 'no-cache'}),
        HttpLoggingInterceptor(),
        InternetAvailableInterceptor(),
        HttpExceptionInterceptor(),
        HttpSocketExceptionInterceptor(),

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
    return _$UserApiService(client);
  }
}
