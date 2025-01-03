import 'package:pust_guest_house/core/common/entities/my_room.dart';

class MyGuesthouseList{
  final List<MyGuesthouse>? guesthouses;
  MyGuesthouseList({this.guesthouses});
}

class MyGuesthouse {
  final int? id;
  final String? title;
  // String? gps_location;
  final String? address;
  final double? lat;
  final double? log;
  final MyRoomList? roomList;

  MyGuesthouse({
    this.id,
    this.title,
    this.address,
    this.lat,
    this.log,
    this.roomList,
  });
}
