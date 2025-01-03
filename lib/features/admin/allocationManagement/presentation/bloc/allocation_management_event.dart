part of 'allocation_management_bloc.dart';

@immutable
sealed class AllocationManagementEvent {}

final class AllocationManagementUpdateEvent extends AllocationManagementEvent {
  final int allocation_id;
  final String key;
  final String value;

  AllocationManagementUpdateEvent({
    required this.allocation_id,
    required this.key,
    required this.value,
  });
}

final class AllocationManagementGetAllEvent extends AllocationManagementEvent {}

final class AllocationManagementGetByStatusEvent extends AllocationManagementEvent {
  final String status;
  AllocationManagementGetByStatusEvent({
    required this.status,
  });
}
