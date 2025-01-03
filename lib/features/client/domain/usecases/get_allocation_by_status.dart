import 'package:fpdart/fpdart.dart';
import 'package:pust_guest_house/core/common/entities/my_allocation.dart';
import 'package:pust_guest_house/core/error/failures.dart';
import 'package:pust_guest_house/core/usecase/usecase.dart';
import 'package:pust_guest_house/features/client/domain/repositories/add_allocation_repository.dart';

class GetAllocationByStatus
    implements UseCase<MyAllocationList, GetAllocationByStatusParams> {
  final AllocationRepository allocationRepository;
  GetAllocationByStatus({required this.allocationRepository});

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
