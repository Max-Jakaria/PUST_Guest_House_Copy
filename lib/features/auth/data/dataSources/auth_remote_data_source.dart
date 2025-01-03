import 'dart:convert';

import 'package:http/http.dart';
import 'package:pust_guest_house/core/error/exceptions.dart';
import 'package:pust_guest_house/core/models/userModel.dart';
import 'package:pust_guest_house/core/secrets/app_secrets.dart';
import 'package:pust_guest_house/features/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class AuthRemoteDataSource {
  Future<MyUserModel?> getCurrentUserData();
  
  Future<MyUserModel> signUpWithUserInfo({
    required String userName,
    required String designation,
    required String email,
    required String userPhoneNumber,
    required String password,
    required String department,
  });

  Future<MyUserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  
  @override
  Future<MyUserModel?> getCurrentUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = await prefs.getString(AppSecrets.tokenKey);

    if(token == null){
      return null;
    }

    Uri url = Uri.http(AppSecrets.hostUrl, '/api/v1/user/details');
    final response =
        await get(url, headers: {'Authorization': 'Bearer $token'});

    try {
      print('-_-_- is log status code : ${response.statusCode}');
      if (response.statusCode == 200) {
        final res = json.decode(response.body);
        print('-_- is log body $res');
        if (res['status'] == 'error') {
          throw ServerException(message: res['message']);
        }
        print('Ret u m');
        return MyUserModel.fromJson(json.decode(response.body));
      } else {
        throw ServerException(
            message:
                'error occure to get current user ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException(message: '${e}');
    }
  }

  @override
  Future<MyUserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    Uri url = Uri.http(AppSecrets.hostUrl, '/api/v1/login');

    print('-_-calling url is : ${url.toString()}');
    Map<String, dynamic> credintial = {'email': email, 'password': password};

    final response = await post(url, body: json.encode(credintial));

    try {
      print('-_-_- status code : ${response.statusCode}');
      if (response.statusCode == 200) {
        final res = json.decode(response.body);
        print('-_- body $res');
        print('-_- token : ${res['data']['token']}');
        if (res['status'] == 'error') {
          throw ServerException(message: res['message']);
        }
        final SharedPreferences prefs = await SharedPreferences.getInstance();

        await prefs.setString(AppSecrets.tokenKey, res['data']['token']);
        return MyUserModel.fromJson(json.decode(response.body));
      } else {
        throw ServerException(
            message:
                'error occure to login user with code ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException(message: '${e}');
    }
  }

  @override
  Future<MyUserModel> signUpWithUserInfo({
    required String userName,
    required String designation,
    required String email,
    required String userPhoneNumber,
    required String password,
    required String department,
  }) async {
    User user = User(
      name: userName,
      title: designation,
      email: email,
      phone: userPhoneNumber,
      password: password,
      department: department,
    );

    Uri url = Uri.https(AppSecrets.hostUrl, '/api/v1/registration');
    print('calling url is : ${url.toString()}');

    try {
      final response = await post(url, body: json.encode(user.getUser()));
      if (response.statusCode == 200) {
        return MyUserModel.fromJson(json.decode(response.body));
      } else {
        throw ServerException(
            message:
                'error occure to register user with code : ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException(
          message:
              'excepton caught to register user message : ${e.toString()}');
    }
  }
}
