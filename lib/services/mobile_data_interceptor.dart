import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:connectivity/connectivity.dart';

class InternetAvailableInterceptor implements RequestInterceptor {
  @override
  FutureOr<Request> onRequest(Request request) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    final isMobile = connectivityResult == ConnectivityResult.mobile;

    final isWifi = connectivityResult == ConnectivityResult.wifi;

    if (!isMobile && !isWifi) {
      throw InternetAvailableException();
    }
    return request;
  }
}

class InternetAvailableException implements Exception {
  final message = 'No Internet Available';
  @override
  String toString() => message;
}

class MobileDataInterceptor implements RequestInterceptor {
  @override
  FutureOr<Request> onRequest(Request request) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    final isMobile = connectivityResult == ConnectivityResult.mobile;
    // Checking for large files is done by evaluating the URL of the request
    // with a regular expression. Specify all endpoints which contain large files.
    final isLargeFile = request.url.contains(RegExp(r'(/large|/video|/posts)'));

    if (isMobile && isLargeFile) {
      throw MobileDataCostException();
    }

    return request;
  }
}

class MobileDataCostException implements Exception {
  final message =
      'Downloading large files on a mobile data connection may incur costs';
  @override
  String toString() => message;
}

class HttpExceptionInterceptor implements ResponseInterceptor {
  @override
  FutureOr<Response> onResponse(Response response) async {
    if ((response.statusCode == 200) &&
        (response.body.response.contains('Error'))) {
      //print('response body inter');
      //print(response.body.response);
      //print(response.body.response.contains('Error'));
      //print(response.body.errorMessage);
      final errorResponse = response.body.errorMessage;
      throw HttpErrorException(errorResponse);
    }
    return response;
  }
}

class HttpErrorException implements Exception {
  final String message;

  HttpErrorException(this.message);

  @override
  String toString() {
    return message;
    // return super.toString(); // Instance of HttpException
  }
}

class HttpSocketExceptionInterceptor implements ResponseInterceptor {
  @override
  FutureOr<Response> onResponse(Response response) async {
    final errorResponse = response.error;
    if (response.statusCode == 400) {
      throw BadRequestException(errorResponse);
    } else if (response.statusCode == 401 || response.statusCode == 403) {
      throw UnauthorisedException(errorResponse);
    } else if (response.statusCode == 500 || response.statusCode == 503) {
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
    return response;
  }
}

class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends AppException {
  InvalidInputException([String message]) : super(message, "Invalid Input: ");
}
