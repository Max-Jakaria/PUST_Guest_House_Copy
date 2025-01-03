import 'package:fpdart/fpdart.dart';
import 'package:pust_guest_house/core/error/exceptions.dart';
import 'package:pust_guest_house/core/error/failures.dart';
import 'package:pust_guest_house/features/client/data/datasources/add_allocation_remote_data_source.dart';
import 'package:pust_guest_house/core/common/entities/models/my_allocation_model.dart';
import 'package:pust_guest_house/features/client/domain/repositories/add_allocation_repository.dart';

class AllocationRepositoryImpl implements AllocationRepository {
  final AddAllocationRemoteDataSource allocationRemoteDataSource;

  AllocationRepositoryImpl({
    required this.allocationRemoteDataSource,
  });

  @override
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
  }) async {
    try {
      MyAllocationModel allocationModel = MyAllocationModel(
        user_id: user_id,
        guest_house_id: guest_house_id,
        boarding_date: boarding_date,
        departure_date: departure_date,
        room_type: room_type,
        booking_type: booking_type,
        guest_count: guest_count,
        created_at: created_at,
        updated_at: updated_at,
        boarder_type: boarder_type,
        allocation_purpose: allocation_purpose,
        behalf_of: behalf_of,
      );

      final res =
          await allocationRemoteDataSource.uploadNewAllocation(allocationModel);
      if (res) {
        return right(true);
      } else {
        return left(
          Failure('Your token is not correct. It may your token' +
              ' expaired or removed. Please re-signin and try again.'),
        );
      }
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, MyAllocationListModel>> getAllAllocations() async {
    try {
      final allocations = await allocationRemoteDataSource.getAllAllocations();
      return right(allocations);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, MyAllocationListModel>> getAllocationByStatus({
    required String status,
  }) async {
    try {
      final allocations = await allocationRemoteDataSource
          .getAllocationByStatus(status: status.toLowerCase());
      return right(allocations);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
