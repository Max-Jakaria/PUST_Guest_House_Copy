import 'package:fpdart/fpdart.dart';
import 'package:pust_guest_house/core/common/entities/my_allocation.dart';
import 'package:pust_guest_house/core/error/failures.dart';
import 'package:pust_guest_house/core/usecase/usecase.dart';
import 'package:pust_guest_house/features/admin/allocationManagement/domain/repositories/allocation_management_repository.dart';

class GetAllocationByStatusAdmin
    implements UseCase<MyAllocationList, GetAllocationByStatusParams> {
  final AllocationManagementRepository allocationRepository;
  GetAllocationByStatusAdmin({required this.allocationRepository});

  @override
  Future<Either<Failure, MyAllocationList>> call(
      GetAllocationByStatusParams params) async {
    return await allocationRepository.getAllocationByStatus(
      status: params.status,
    );
  }
}

class GetAllocationByStatusParams {
  final String status;

  GetAllocationByStatusParams({required this.status});
}
