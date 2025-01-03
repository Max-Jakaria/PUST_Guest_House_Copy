part of 'add_allocation_bloc.dart';

@immutable
sealed class AddAllocationEvent {}

final class AddNewAllocationEvent extends AddAllocationEvent {
  final int user_id;
  final int guest_house_id;
  final String boarding_date;
  final String departure_date;
  final String room_type;
  final String booking_type;
  final int guest_count;
  final String created_at;
  final String updated_at;
  final String boarder_type;
  final String allocation_purpose;
  final String behalf_of;

  AddNewAllocationEvent({
    required this.user_id,
    required this.guest_house_id,
    required this.boarding_date,
    required this.departure_date,
    required this.room_type,
    required this.booking_type,
    required this.guest_count,
    required this.created_at,
    required this.updated_at,
    required this.boarder_type,
    required this.allocation_purpose,
    required this.behalf_of,
  });
}

final class AddAllocationEventGetAll extends AddAllocationEvent {}

final class AddAllocationEventGetByStatus extends AddAllocationEvent {
  final String status;
  AddAllocationEventGetByStatus({
    required this.status,
  });
}
