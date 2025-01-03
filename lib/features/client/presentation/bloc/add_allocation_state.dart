part of 'add_allocation_bloc.dart';

@immutable
sealed class AddAllocationState {}

final class AddAllocationInitial extends AddAllocationState {}

final class AddAllocationLoading extends AddAllocationState {}

final class AddAllocationFailure extends AddAllocationState {
  final String error;
  AddAllocationFailure({required this.error});
}

final class AddAllocationUploadSuccess extends AddAllocationState {}

final class AddAllocationGetSuccess extends AddAllocationState {
  final MyAllocationList allocations;

  AddAllocationGetSuccess({required this.allocations});
}
