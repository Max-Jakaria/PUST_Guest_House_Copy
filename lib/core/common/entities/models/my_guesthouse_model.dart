import 'dart:convert';

import 'package:pust_guest_house/core/common/entities/models/my_room_model.dart';
import 'package:pust_guest_house/core/common/entities/my_guesthouse.dart';
import 'package:pust_guest_house/core/common/entities/my_room.dart';

class MyGuesthouseListModel extends MyGuesthouseList {
  MyGuesthouseListModel({super.guesthouses});

  factory MyGuesthouseListModel.fromJson(List<dynamic> parsedJson) {
    List<MyGuesthouse> houses = [];
    houses = parsedJson.map(
      (e) {
        return MyGuesthouseModel.fromJson(e);
      },
    ).toList();
    return MyGuesthouseListModel(guesthouses: houses);
  }
}

class MyGuesthouseModel extends MyGuesthouse {
  MyGuesthouseModel({
    super.id,
    super.title,
    super.address,
    super.lat,
    super.log,
    super.roomList,
  });

  factory MyGuesthouseModel.fromJson(Map<String, dynamic> response) {
    // return MyGuesthouseModel();
    double? _lat = 0.0;
    double? _log = 0.0;
    if (response['gps_location'] != null) {
      Map<String, dynamic> location = json.decode(response['gps_location']);
      _lat = location['lat'];
      _log = location['log'];
    }
    MyRoomList? roomList;
    roomList = MyRoomListModel.fromJson(response['rooms']);

    return MyGuesthouseModel(
      id: response['id'],
      title: response['title'],
      address: response['address'],
      lat: _lat,
      log: _log,
      roomList: roomList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'address': address,
      'gps_location': json.encode({
        'lat': lat,
        'log': log,
      }).toString()
    };
  }
}
