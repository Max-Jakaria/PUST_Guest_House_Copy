import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pust_guest_house/core/common/widgets/allocation_card.dart';
import 'package:pust_guest_house/core/common/widgets/loader.dart';
import 'package:pust_guest_house/core/theme/app_pallete.dart';
import 'package:pust_guest_house/core/utils/show_snackbar.dart';
import 'package:pust_guest_house/features/client/presentation/bloc/add_allocation_bloc.dart';

class ClientAllAllocation extends StatefulWidget {
  final String status;
  const ClientAllAllocation({
    super.key,
    required this.status,
  });

  @override
  State<ClientAllAllocation> createState() => _ClientAllAllocationState();
}

class _ClientAllAllocationState extends State<ClientAllAllocation> {
  @override
  void initState() {
    super.initState();

    context.read<AddAllocationBloc>().add(
          AddAllocationEventGetByStatus(
            status: widget.status,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddAllocationBloc, AddAllocationState>(
      listener: (context, state) {
        if (state is AddAllocationFailure) {
          showSnackBar(context, state.error);
        }
      },
      builder: (context, state) {
        if (state is AddAllocationLoading) {
          return const Loader();
        }
        if (state is AddAllocationGetSuccess &&
            state.allocations.allocations!.isNotEmpty) {
          return RefreshIndicator(
            onRefresh: () async {
              print('Refresh call');
            },
            displacement: 10,
            backgroundColor: AppPallete.primaryDeep,
            color: AppPallete.white,
            child: ListView.builder(
              itemCount: state.allocations.allocations!.length,
              itemBuilder: (context, index) {
                final allocation = state.allocations.allocations![index];
                print('---------${allocation.status}  ${widget.status.toLowerCase()}');
                if (allocation.status == widget.status.toLowerCase() || widget.status == 'All') {
                  return AllocationCard(
                    allocation: allocation,
                    isAdminSize: true,
                  );
                }else{
                  return Container();
                }
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
