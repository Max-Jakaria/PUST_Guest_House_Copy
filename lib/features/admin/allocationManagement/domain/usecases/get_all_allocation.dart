import 'package:fpdart/fpdart.dart';
import 'package:pust_guest_house/core/common/entities/my_allocation.dart';
import 'package:pust_guest_house/core/error/failures.dart';
import 'package:pust_guest_house/core/usecase/usecase.dart';
import 'package:pust_guest_house/features/admin/allocationManagement/domain/repositories/allocation_management_repository.dart';

class GetAllAllocationAdmin implements UseCase<MyAllocationList, NoParams> {
  final AllocationManagementRepository allocationRepository;
  GetAllAllocationAdmin({required this.allocationRepository});

  @override
  Future<Either<Failure, MyAllocationList>> call(NoParams params) async {
    return await allocationRepository.getAllAllocations();
  }
}
