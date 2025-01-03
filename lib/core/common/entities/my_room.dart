class MyRoomList {
  final List<MyRoom>? rooms;
  MyRoomList({this.rooms});
}

class MyRoom {
  int? id;
  String? number;
  String? guest_house_id;
  String? room_type;
  int? border_count;
  bool is_selected = false;
  // UserList? current_borders;
  int? parent_id;
  int? total_seat;

  MyRoom({
    this.id,
    this.number,
    this.guest_house_id,
    this.room_type,
    this.border_count,
    // this.current_borders,
    this.parent_id,
    this.total_seat,
  });

  
}
