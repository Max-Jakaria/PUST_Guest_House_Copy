
import 'package:pust_guest_house/core/common/entities/my_room.dart';

class MyAllocationList {
  final List<MyAllocation>? allocations;
  MyAllocationList({this.allocations});
}

class MyAllocation {
  int? id;
  int? user_id;
  int? guest_house_id;
  // int? room_id;
  // String? bed_number;
  int? guest_count;
  String? room_type;
  String? booking_type;
  String? status;
  String? boarding_date;
  String? departure_date;
  String? extension_request_date;
  int? is_admin_seen;
  int? is_user_seen;
  String? created_at;
  String? updated_at;
  // int? room_charge;
  int? dayCount;
  MyRoomList? assigned_rooms;
  String? boarder_type; // Mail or Femail or Family
  String? allocation_purpose; // night stay or day stay
  String? behalf_of; // self or other
  String? rejection_reason;
  String? cancellation_reason;
  String? report_link; // download pdf link
  String? user_name;
  String? user_profile;

  MyAllocation({
    this.id,
    this.user_id,
    this.guest_house_id,
    // this.room_id,
    // this.bed_number,
    this.guest_count,
    this.room_type,
    this.booking_type,
    this.status,
    this.boarding_date,
    this.departure_date,
    this.extension_request_date,
    this.is_admin_seen,
    this.is_user_seen,
    this.created_at,
    this.updated_at,
    // this.room_charge,
    this.dayCount,
    this.assigned_rooms,
    this.boarder_type,
    this.allocation_purpose,
    this.behalf_of,
    this.rejection_reason,
    this.cancellation_reason,
    this.report_link,
    this.user_name,
    this.user_profile,
  });
}
