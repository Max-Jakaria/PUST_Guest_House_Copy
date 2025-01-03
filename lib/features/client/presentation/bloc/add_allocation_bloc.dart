import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pust_guest_house/core/common/entities/my_allocation.dart';
import 'package:pust_guest_house/core/usecase/usecase.dart';
import 'package:pust_guest_house/features/client/domain/usecases/add_new_allocation.dart';
import 'package:pust_guest_house/features/client/domain/usecases/get_all_allocation.dart';
import 'package:pust_guest_house/features/client/domain/usecases/get_allocation_by_status.dart';

part 'add_allocation_event.dart';
part 'add_allocation_state.dart';

class AddAllocationBloc extends Bloc<AddAllocationEvent, AddAllocationState> {
  final AddNewAllocation _addNewAllocation;
  final GetAllAllocation _getAllAllocation;
  final GetAllocationByStatus _getAllocationByStatus;

  AddAllocationBloc({
    required AddNewAllocation addNewAllocation,
    required GetAllAllocation getAllAllocations,
    required GetAllocationByStatus getAllocationByStatus,
  })  : _addNewAllocation = addNewAllocation,
        _getAllAllocation = getAllAllocations,
        _getAllocationByStatus = getAllocationByStatus,
        super(AddAllocationInitial()) {
    on<AddAllocationEvent>((event, emit) => emit(AddAllocationLoading()));
    on<AddNewAllocationEvent>(_onNewAllocationUpload);
    on<AddAllocationEventGetAll>(_onGetAllAllocation);
    on<AddAllocationEventGetByStatus>(_onGetAllocationByStatus);
  }

  void _onNewAllocationUpload(
    AddNewAllocationEvent event,
    Emitter<AddAllocationState> emit,
  ) async {
    final res = await _addNewAllocation(
      AddNewAllocationParams(
        user_id: event.user_id,
        guest_house_id: event.guest_house_id,
        boarding_date: event.boarding_date,
        departure_date: event.departure_date,
        room_type: event.room_type,
        booking_type: event.booking_type,
        guest_count: event.guest_count,
        created_at: event.created_at,
        updated_at: event.updated_at,
        boarder_type: event.boarder_type,
        allocation_purpose: event.allocation_purpose,
        behalf_of: event.behalf_of,
      ),
    );

    res.fold(
      (l) => emit(AddAllocationFailure(error: l.message)),
      (r) => emit(AddAllocationUploadSuccess()),
    );
  }

  void _onGetAllAllocation(
    AddAllocationEventGetAll event,
    Emitter<AddAllocationState> emit,
  ) async {
    final res = await _getAllAllocation(NoParams());

    res.fold(
      (l) => emit(AddAllocationFailure(error: l.message)),
      (r) => emit(AddAllocationGetSuccess(allocations: r)),
    );
  }

  void _onGetAllocationByStatus(
    AddAllocationEventGetByStatus event,
    Emitter<AddAllocationState> emit,
  ) async {
    final res = await _getAllocationByStatus(
      GetAllocationByStatusParams(
        status: event.status,
      ),
    );

    res.fold(
      (l) => emit(AddAllocationFailure(error: l.message)),
      (r) => emit(AddAllocationGetSuccess(allocations: r)),
    );
  }
}
