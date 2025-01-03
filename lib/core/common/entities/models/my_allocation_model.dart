import 'dart:convert';

import 'package:pust_guest_house/core/common/entities/models/my_room_model.dart';
import 'package:pust_guest_house/core/common/entities/my_allocation.dart';

class MyAllocationListModel extends MyAllocationList {
  MyAllocationListModel({super.allocations});

  factory MyAllocationListModel.fromJson(List<dynamic> parsedJson) {
    List<MyAllocation> allocations = [];
    allocations = parsedJson.map(
      (e) {
        return MyAllocationModel.fromJson(e);
      },
    ).toList();
    print('Allocation build success-----');
    print('size : ${allocations.length}');
    return MyAllocationListModel(allocations: allocations);
  }
}

class MyAllocationModel extends MyAllocation {
  MyAllocationModel({
    super.id,
    super.user_id,
    super.guest_house_id,
    // super.room_id,
    // super.bed_number,
    super.guest_count,
    super.room_type,
    super.booking_type,
    super.status,
    super.boarding_date,
    super.departure_date,
    super.extension_request_date,
    super.is_admin_seen,
    super.is_user_seen,
    super.created_at,
    super.updated_at,
    // super.room_charge,
    super.dayCount,
    super.assigned_rooms,
    super.boarder_type,
    super.allocation_purpose,
    super.behalf_of,
    super.rejection_reason,
    super.cancellation_reason,
    super.report_link,
    super.user_name,
    super.user_profile,
  });

  factory MyAllocationModel.fromJson(Map<String, dynamic> response) {
    MyRoomListModel? room_list;
    if (response['assigned_rooms'] != null) {
      room_list = MyRoomListModel.fromJson(response['assigned_rooms']);
    }
    String? behalf = "";
    if (response['behalf_of'] != null) {
      try {
        behalf = json.decode(response['behalf_of'])[0]['name'];
      } catch (e) {
        print('ex : $e');
        print(response['id']);
      }
    }
    // print('behalf is : $behalf -------');

    String? user_name;
    String? user_profile;
    if (response['user_short_info'] != null) {
      Map<String, dynamic> user = response['user_short_info'];
      user_name = user['name'];
      user_profile = user['email'];
    }

    return MyAllocationModel(
      id: response['id'],
      user_id: response['user_id'],
      guest_house_id: response['guest_house_id'],
      // room_id: response['room_id'],
      // bed_number: response['bed_number'],
      guest_count: response['guest_count'],
      room_type: response['room_type'],
      booking_type: response['booking_type'],
      status: response['status'],
      boarding_date: response['boarding_date'],
      departure_date: response['departure_date'],
      extension_request_date: response['extension_request_date'],
      is_admin_seen: response['is_admin_seen'],
      is_user_seen: response['is_user_seen'],
      created_at: response['created_at'],
      updated_at: response['updated_at'],
      // room_charge: _charge,
      dayCount: int.parse('${response['days_count']}'),
      assigned_rooms: room_list,
      boarder_type: response['boarder_type'],
      allocation_purpose: response['allocation_purpose'],
      behalf_of: behalf,
      rejection_reason: response['rejection_reason'],
      cancellation_reason: response['cancellation_reason'],
      report_link: response['report_link'],
      user_name: user_name,
      user_profile: user_profile,
    );
  }

  Map<String, dynamic> get() {
    // if (boarding_period == 'pm') {
    //   int hour = int.parse(boarding_date!.substring(11, 13));
    //   hour += 12;
    //   // boarding_date =
    //   '${boarding_date!.substring(0, 11)}$hour${boarding_date!.substring(13)}';
    //   print(
    //       'Formated Bo date : ${boarding_date!.substring(0, 11)}$hour${boarding_date!.substring(13)}');
    // }
    return {
      'user_id': user_id,
      'guest_house_id': guest_house_id,
      'boarding_date': boarding_date,
      'departure_date': departure_date,
      'room_type': room_type,
      'booking_type': booking_type,
      'guest_count': guest_count,
      'created_at': created_at,
      'updated_at': updated_at,
      'boarder_type': boarder_type,
      'allocation_purpose': allocation_purpose,
      'behalf_of': json.encode([
        {'name': behalf_of}
      ]),
    };
  }
}
