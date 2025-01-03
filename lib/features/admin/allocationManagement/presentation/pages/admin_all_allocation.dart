import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pust_guest_house/core/common/widgets/allocation_card.dart';
import 'package:pust_guest_house/core/common/widgets/loader.dart';
import 'package:pust_guest_house/core/theme/app_pallete.dart';
import 'package:pust_guest_house/core/utils/show_snackbar.dart';
import 'package:pust_guest_house/features/admin/allocationManagement/presentation/bloc/allocation_management_bloc.dart';

class AdminAllAllocation extends StatefulWidget {
  final String status;
  const AdminAllAllocation({
    super.key,
    required this.status,
  });

  @override
  State<AdminAllAllocation> createState() => _AdminAllAllocationState();
}

class _AdminAllAllocationState extends State<AdminAllAllocation> {
  @override
  void initState() {
    super.initState();

    context.read<AllocationManagementBloc>().add(
          AllocationManagementGetByStatusEvent(
            status: widget.status,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AllocationManagementBloc, AllocationManagementState>(
      listener: (context, state) {
        if (state is AllocationManagementFailure) {
          showSnackBar(context, state.error);
        }
      },
      builder: (context, state) {
        if (state is AllocationManagementLoading) {
          return const Loader();
        }
        if (state is AllocationManagementGetSuccess &&
            state.allocations.allocations!.isNotEmpty) {
          return RefreshIndicator(
            onRefresh: () async {
              print('Refresh call');
              context.read<AllocationManagementBloc>().add(
                    AllocationManagementGetByStatusEvent(
                      status: widget.status,
                    ),
                  );
            },
            displacement: 10,
            backgroundColor: AppPallete.primaryDeep,
            color: AppPallete.white,
            child: ListView.builder(
              itemCount: state.allocations.allocations!.length,
              itemBuilder: (context, index) {
                final allocation = state.allocations.allocations![index];
                return AllocationCard(
                  allocation: allocation,
                  isAdminSize: true,
                );
              },
            ),
          );
        }
        return const Center(
          child: Text(
            'No allocation found.',
            style: TextStyle(color: AppPallete.grey),
          ),
        );
      },
    );
  }
}
