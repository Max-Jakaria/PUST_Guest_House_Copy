import 'package:pust_guest_house/core/common/entities/my_room.dart';

class MyRoomListModel extends MyRoomList {
  MyRoomListModel({super.rooms});

  factory MyRoomListModel.fromJson(List<dynamic> parsedJson) {
    List<MyRoomModel> rooms = [];
    rooms = parsedJson.map(
      (e) {
        return MyRoomModel.fromJson(e);
      },
    ).toList();
    return MyRoomListModel(rooms: rooms);
  }
}

class MyRoomModel extends MyRoom {
  MyRoomModel({
    super.id,
    super.number,
    super.guest_house_id,
    super.room_type,
    super.border_count,
    // super.current_borders,
    super.parent_id,
    super.total_seat,
  });

  factory MyRoomModel.fromJson(Map<String, dynamic> response) {
    int? total_seat = response['total_seat'];
    if (total_seat == 0) {
      total_seat = 1;
    }

    return MyRoomModel(
      id: response['id'],
      number: response['number'],
      guest_house_id: '${response['guest_house_id']}',
      border_count: response['border_count'],
      room_type: response['room_type'],
      // current_borders: userList,
      parent_id: (response['parent_id'] == null)
          ? null
          : int.parse('${response['parent_id']}'),
      total_seat: total_seat,
    );
  }

  Map<String, dynamic> get() {
    return {
      'number': number,
      'guest_house_id': guest_house_id,
      'room_type': room_type
    };
  }
}
