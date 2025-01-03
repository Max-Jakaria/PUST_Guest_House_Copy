import 'package:fpdart/fpdart.dart';
import 'package:pust_guest_house/core/common/entities/my_allocation.dart';
import 'package:pust_guest_house/core/error/failures.dart';
import 'package:pust_guest_house/core/usecase/usecase.dart';
import 'package:pust_guest_house/features/client/domain/repositories/add_allocation_repository.dart';

class GetAllAllocation implements UseCase<MyAllocationList, NoParams> {
  final AllocationRepository allocationRepository;
  GetAllAllocation({required this.allocationRepository});

  @override
  Future<Either<Failure, MyAllocationList>> call(NoParams params) async {
    return await allocationRepository.getAllAllocations();
  }
}
