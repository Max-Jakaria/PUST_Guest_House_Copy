import 'package:fpdart/fpdart.dart';
import 'package:pust_guest_house/core/error/failures.dart';
import 'package:pust_guest_house/core/usecase/usecase.dart';
import 'package:pust_guest_house/features/admin/allocationManagement/domain/repositories/allocation_management_repository.dart';

class UpdateAllocation implements UseCase<bool, UpdateAllocationParams> {
  final AllocationManagementRepository allocationRepository;
  UpdateAllocation({required this.allocationRepository});

  @override
  Future<Either<Failure, bool>> call(UpdateAllocationParams params) async {
    return allocationRepository.updateAllocation(
      allocation_id: params.allocation_id,
      key: params.key,
      value: params.value,
    );
  }
}

class UpdateAllocationParams {
  final int allocation_id;
  final String key;
  final String value;

  UpdateAllocationParams({
    required this.allocation_id,
    required this.key,
    required this.value,
  });
}
