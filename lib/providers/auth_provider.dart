import 'dart:convert';

import 'package:blog/models/error_handling.dart';
import 'package:blog/services/mobile_data_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/built_user.dart';

import '../services/user_api_service.dart';

import 'package:flutter/widgets.dart';
import 'package:chopper/chopper.dart';

class AuthProvider with ChangeNotifier {
  String _token;
  int _userId;

  bool get isAuth {
    print("Token is:");
    print(token);
    return token != null;
  }

  String get token {
    if (_token != null) {
      return _token;
    }
    return null;
  }

  int get userId {
    return _userId;
  }

  // Future<void> signup(BuiltUser user) async {
  //   Response<BuiltUser> registerResponse =
  //       await UserApiService.create().userRegister(user);
  //   final responseData = registerResponse.body;
  //   if (responseData == null) {
  //     return;
  //   }
  //   print(responseData);
  // }

  //Future<void> login(BuiltUser user) async {
  //var newd = user.rebuild((b) => b..username = user.email);
  //print(token);
  //   print(user);
  //   Response<BuiltUser> loginResponse =
  //       await UserApiService.create().userLogin(user);

  //   final responseData = loginResponse.body;
  //   if (responseData == null) {
  //     return;
  //   }
  //   print(responseData);
  // }

//USER AUTHENICATION FUNCTIONS LOGIN,SIGNUP

  Future<void> _authenticate(
      BuiltUser user, Response<BuiltUser> urlSegment) async {
    try {
      final Response<BuiltUser> serverResponse = urlSegment;
      print("Response Body:");
      print(serverResponse.body);
      final responseData = serverResponse.body;
      //if no exception then store the user Token and ID
      print("Response Token:");
      print(responseData.token);
      _token = responseData.token;
      _userId = responseData.id;
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      // final userData = json.encode(
      //   {
      //     'token': _token,
      //     'userId': _userId,
      //     'expiryDate': _expiryDate.toIso8601String(),
      //   },
      // );
      //prefs.setString('userData', userData);

      prefs.setString('token', _token);
      prefs.setInt('userId', _userId);
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(BuiltUser user) async {
    return _authenticate(
        user, await UserApiService.create().userRegister(user));
  }

  Future<void> login(BuiltUser user) async {
    return _authenticate(user, await UserApiService.create().userLogin(user));
  }

  //AUTO LOGIN USER FUNCTION

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('token') && !prefs.containsKey('userId')) {
      return false;
    }
    // final extractedUserData =
    //     json.decode(prefs.getString('userData')) as Map<Object, Object>;

    // final expiryDate = DateTime.parse(extractedUserData['expiryDate']);
    // if (expiryDate.isBefore(DateTime.now())) {
    //   return false;
    // }

    // _token = extractedUserData['token'];
    // _userId = extractedUserData['userId'];
    //_expiryDate = expiryDate;

    // prefs.setString('stringValue', "abc");
    //  String stringValue = prefs.getString('stringValue');
    //  prefs.setInt('intValue', 123);
    //  int intValue = prefs.getInt('intValue');

    _token = prefs.getString('token');
    _userId = prefs.getInt('userId');

    notifyListeners();
    //_autoLogout();
    return true;
  }

//LOG OUT USER FUNCTION

  Future<void> logout() async {
    _token = null;
    _userId = null;
    // _expiryDate = null;
    // if (_authTimer != null) {
    //   _authTimer.cancel();
    //   _authTimer = null;
    // }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    // prefs.remove('userData');
    prefs.clear();
  }
}
