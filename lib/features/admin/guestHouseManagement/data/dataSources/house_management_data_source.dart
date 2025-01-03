import 'dart:convert';

import 'package:http/http.dart';
import 'package:pust_guest_house/core/common/entities/models/my_guesthouse_model.dart';
import 'package:pust_guest_house/core/common/entities/models/my_room_model.dart';
import 'package:pust_guest_house/core/common/entities/my_room.dart';
import 'package:pust_guest_house/core/error/exceptions.dart';
import 'package:pust_guest_house/core/secrets/app_secrets.dart';
import 'package:pust_guest_house/core/utils/show_snackbar.dart';

abstract interface class HouseManagementDataSource {
  Future<bool> createGuestHouse(MyGuesthouseModel guesthouse);
  Future<MyGuesthouseListModel> getAllGuestHouses();
  Future<bool> updateGuesthouse(MyGuesthouseModel guesthouse);

  Future<bool> createRoom(MyRoomModel myRoom);
  // Future<MyRoomListModel> getAllRooms(int guesthouse_id);
  Future<bool> updateRoom(MyRoomModel myRoom);
}

class HouseManagementDataSourceImpl implements HouseManagementDataSource {
  @override
  Future<bool> createGuestHouse(MyGuesthouseModel guesthouse) async {
    final token = await getToken();
    if (token == null) {
      return false;
    }

    Uri url = Uri.http(AppSecrets.hostUrl, '/api/v1/admin/guest-houses/create');
    print('-_-calling url is : ${url.toString()}');

    final response = await post(
      url,
      body: json.encode(guesthouse.toMap()),
      headers: {'Authorization': 'Bearer $token'},
    );
    try {
      print('-_-_- status code : ${response.statusCode}');
      if (response.statusCode == 200) {
        final res = json.decode(response.body);
        print('-_- body $res');
        if (res['status'] == 'error') {
          throw ServerException(message: res['message']);
        }
        return true;
      } else {
        throw ServerException(
            message:
                'error occure to login user with code ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<bool> createRoom(MyRoomModel myRoom) async {
    final token = await getToken();
    if (token == null) {
      return false;
    }

    Uri url = Uri.http(AppSecrets.hostUrl, '/api/v1/admin/rooms/create');
    print('-_-calling url is : ${url.toString()}');

    final response = await post(
      url,
      body: json.encode(myRoom.get()),
      headers: {'Authorization': 'Bearer $token'},
    );
    try {
      print('-_-_- status code : ${response.statusCode}');
      if (response.statusCode == 200) {
        final res = json.decode(response.body);
        print('-_- body $res');
        if (res['status'] == 'error') {
          throw ServerException(message: res['message']);
        }
        return true;
      } else {
        throw ServerException(
            message:
                'error occure to login user with code ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<MyGuesthouseListModel> getAllGuestHouses() async {
    final token = await getToken();
    if (token == null) {
      return MyGuesthouseListModel();
    }

    Uri url = Uri.http(AppSecrets.hostUrl, '/api/v1/admin/guest-houses');
    print('-_-calling url is : ${url.toString()}');

    final response = await get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    try {
      if (response.statusCode == 200) {
        print(response.body);
        return MyGuesthouseListModel.fromJson(
            json.decode(response.body)['data']['list']);
      } else {
        print(response.statusCode);
        throw ServerException(
            message:
                'Bad request returned response code is ${response.statusCode}');
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  // @override
  // Future<MyRoomListModel> getAllRooms(int guesthouse_id) async {
    
  // }

  @override
  Future<bool> updateGuesthouse(MyGuesthouseModel guesthouse) async {
    final token = await getToken();
    if (token == null) {
      return false;
    }

    Uri url = Uri.http(AppSecrets.hostUrl, '/api/v1/admin/guest-houses/create');
    print('-_-calling url is : ${url.toString()}');

    final response = await post(
      url,
      body: json.encode(guesthouse.toMap()),
      headers: {'Authorization': 'Bearer $token'},
    );
    try {
      print('-_-_- status code : ${response.statusCode}');
      if (response.statusCode == 200) {
        final res = json.decode(response.body);
        print('-_- body $res');
        if (res['status'] == 'error') {
          throw ServerException(message: res['message']);
        }
        return true;
      } else {
        throw ServerException(
            message:
                'error occure to login user with code ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<bool> updateRoom(MyRoom myRoom) {
    // TODO: implement updateRoom
    throw UnimplementedError();
  }
}
