import 'package:fpdart/fpdart.dart';
import 'package:pust_guest_house/core/error/failures.dart';
import 'package:pust_guest_house/core/usecase/usecase.dart';
import 'package:pust_guest_house/features/client/domain/repositories/add_allocation_repository.dart';

class AddNewAllocation implements UseCase<bool, AddNewAllocationParams> {
  final AllocationRepository allocationRepository;
  AddNewAllocation({required this.allocationRepository});

  @override
  Future<Either<Failure, bool>> call(AddNewAllocationParams params) async {
    return allocationRepository.uploadNewAllocation(
      user_id: params.user_id,
      guest_house_id: params.guest_house_id,
      boarding_date: params.boarding_date,
      departure_date: params.departure_date,
      room_type: params.room_type,
      booking_type: params.booking_type,
      guest_count: params.guest_count,
      created_at: params.created_at,
      updated_at: params.updated_at,
      boarder_type: params.boarder_type,
      allocation_purpose: params.allocation_purpose,
      behalf_of: params.behalf_of,
    );
  }
}

class AddNewAllocationParams {
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

  AddNewAllocationParams({
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
