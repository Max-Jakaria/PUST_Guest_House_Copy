part of 'allocation_management_bloc.dart';

@immutable
sealed class AllocationManagementState {}

final class AllocationManagementInitial extends AllocationManagementState {}

final class AllocationManagementLoading extends AllocationManagementState {}

final class AllocationManagementFailure extends AllocationManagementState {
  final String error;
  AllocationManagementFailure({required this.error});
}

final class AllocationManagementUpdateSuccess extends AllocationManagementState {}

final class AllocationManagementGetSuccess extends AllocationManagementState {
  final MyAllocationList allocations;

  AllocationManagementGetSuccess({required this.allocations});
}