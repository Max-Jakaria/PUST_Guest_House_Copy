import 'package:fpdart/fpdart.dart';
import 'package:pust_guest_house/core/common/entities/models/my_allocation_model.dart';
import 'package:pust_guest_house/core/error/exceptions.dart';
import 'package:pust_guest_house/core/error/failures.dart';
import 'package:pust_guest_house/features/admin/allocationManagement/data/datasources/allocation_management_remote_data_source.dart';
import 'package:pust_guest_house/features/admin/allocationManagement/domain/repositories/allocation_management_repository.dart';

class AllocationManagementRepositoryImpl implements AllocationManagementRepository {
  final AllocationManagementRemoteDataSource allocationRemoteDataSource;

  AllocationManagementRepositoryImpl({
    required this.allocationRemoteDataSource,
  });

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

  @override
  Future<Either<Failure, bool>> updateAllocation({
    required int allocation_id,
    required String key,
    required String value,
  }) async {
    try {
      final isSuccess = await allocationRemoteDataSource.updateAllocation(
        allocation_id: allocation_id,
        key: key,
        value: value,
      );
      return right(isSuccess);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
