import 'package:fpdart/fpdart.dart';
import 'package:pust_guest_house/core/common/entities/models/my_allocation_model.dart';
import 'package:pust_guest_house/core/error/failures.dart';


abstract interface class AllocationManagementRepository {
  Future<Either<Failure, MyAllocationListModel>> getAllAllocations();

  Future<Either<Failure, MyAllocationListModel>> getAllocationByStatus({
    required String status,
  });
  Future<Either<Failure, bool>> updateAllocation({
    required int allocation_id,
    required String key,
    required String value,
  });
}
