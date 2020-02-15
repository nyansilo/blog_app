// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$UserApiService extends UserApiService {
  _$UserApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = UserApiService;

  @override
  Future<Response<BuiltUser>> userRegister(BuiltUser user) {
    final $url = '/account/register';
    final $body = user;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<BuiltUser, BuiltUser>($request);
  }

  @override
  Future<Response<BuiltUser>> userLogin(BuiltUser user) {
    final $url = '/account/login';
    final $headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json'
    };
    final $body = user;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<BuiltUser, BuiltUser>($request);
  }
}
