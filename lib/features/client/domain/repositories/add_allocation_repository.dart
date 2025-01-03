import 'package:fpdart/fpdart.dart';
import 'package:pust_guest_house/core/error/failures.dart';
import 'package:pust_guest_house/core/common/entities/models/my_allocation_model.dart';

abstract interface class AllocationRepository {
  Future<Either<Failure, bool>> uploadNewAllocation({
    required int user_id,
    required int guest_house_id,
    required String boarding_date,
    required String departure_date,
    required String room_type,
    required String booking_type,
    required int guest_count,
    required String created_at,
    required String updated_at,
    required String boarder_type,
    required String allocation_purpose,
    required String behalf_of,
  });

  Future<Either<Failure, MyAllocationListModel>> getAllAllocations();

  Future<Either<Failure, MyAllocationListModel>> getAllocationByStatus({
    required String status,
  });
}
