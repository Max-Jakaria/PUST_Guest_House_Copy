import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pust_guest_house/core/common/entities/my_allocation.dart';
import 'package:pust_guest_house/core/usecase/usecase.dart';
import 'package:pust_guest_house/features/admin/allocationManagement/domain/usecases/get_all_allocation.dart';
import 'package:pust_guest_house/features/admin/allocationManagement/domain/usecases/get_allocation_by_status.dart';
import 'package:pust_guest_house/features/admin/allocationManagement/domain/usecases/update_allocation.dart';

part 'allocation_management_event.dart';
part 'allocation_management_state.dart';

class AllocationManagementBloc
    extends Bloc<AllocationManagementEvent, AllocationManagementState> {
  final GetAllAllocationAdmin _getAllAllocation;
  final GetAllocationByStatusAdmin _getAllocationByStatus;
  final UpdateAllocation _updateAllocation;
  AllocationManagementBloc({
    required GetAllAllocationAdmin getAllAllocations,
    required GetAllocationByStatusAdmin getAllocationByStatus,
    required UpdateAllocation uploadAllocation,
  })  : _getAllAllocation = getAllAllocations,
        _getAllocationByStatus = getAllocationByStatus,
        _updateAllocation = uploadAllocation,
        super(AllocationManagementInitial()) {
    on<AllocationManagementEvent>(
        (event, emit) => emit(AllocationManagementLoading()));
    on<AllocationManagementUpdateEvent>(_onUpdateAllocation);
    on<AllocationManagementGetAllEvent>(_onGetAllAllocation);
    on<AllocationManagementGetByStatusEvent>(_onGetAllocationByStatus);
  }

  void _onUpdateAllocation(
    AllocationManagementUpdateEvent event,
    Emitter<AllocationManagementState> emit,
  ) async {
    final res = await _updateAllocation(UpdateAllocationParams(
      allocation_id: event.allocation_id,
      key: event.key,
      value: event.value,
    ));

    res.fold(
      (l) => emit(AllocationManagementFailure(error: l.message)),
      (r) => emit(AllocationManagementUpdateSuccess()),
    );
  }

  void _onGetAllAllocation(
    AllocationManagementGetAllEvent event,
    Emitter<AllocationManagementState> emit,
  ) async {
    final res = await _getAllAllocation(NoParams());

    res.fold(
      (l) => emit(AllocationManagementFailure(error: l.message)),
      (r) => emit(AllocationManagementGetSuccess(allocations: r)),
    );
  }

  void _onGetAllocationByStatus(
    AllocationManagementGetByStatusEvent event,
    Emitter<AllocationManagementState> emit,
  ) async {
    final res = await _getAllocationByStatus(
      GetAllocationByStatusParams(
        status: event.status,
      ),
    );

    res.fold(
      (l) => emit(AllocationManagementFailure(error: l.message)),
      (r) => emit(AllocationManagementGetSuccess(allocations: r)),
    );
  }
}
