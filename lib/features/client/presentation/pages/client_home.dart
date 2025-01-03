import 'package:flutter/material.dart';
import 'package:pust_guest_house/core/common/constant/app_const.dart';
import 'package:pust_guest_house/core/common/widgets/bg_home.dart';
import 'package:pust_guest_house/core/common/widgets/appBarWidget/custom_appbar.dart';
import 'package:pust_guest_house/features/client/presentation/pages/add_allocation_request.dart';
import 'package:pust_guest_house/features/client/presentation/pages/client_all_allocation.dart';

class ClientHomePage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const ClientHomePage(),
      );

  const ClientHomePage({super.key});

  @override
  State<ClientHomePage> createState() => _ClientHomePageState();
}

class _ClientHomePageState extends State<ClientHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return home_background(
      child: DefaultTabController(
        length: AppConst.tabOptions.length,
        child: Scaffold(
          appBar: const MyAppBar(
            bottomTab: true,
          ),
          body: TabBarView(
            children: AppConst.tabOptions.map((e) {
              return ClientAllAllocation(
                status: e,
              );
            }).toList(),
          ),

          //  BlocConsumer<AddAllocationBloc, AddAllocationState>(
          //   listener: (context, state) {
          //     if (state is AddAllocationFailure) {
          //       showSnackBar(context, state.error);
          //     }
          //   },
          //   builder: (context, state) {
          //     if (state is AddAllocationLoading) {
          //       return const Loader();
          //     }
          //     if (state is AddAllocationGetSuccess &&
          //         state.allocations.allocations!.length > 0) {
          //       return ListView.builder(
          //         itemCount: state.allocations.allocations!.length,
          //         itemBuilder: (context, index) {
          //           final allocation = state.allocations.allocations![index];
          //           return ListTile(
          //             title: Text(allocation.user_name!),
          //           );
          //         },
          //       );
          //     }
          //     return const Center(
          //       child: Text('No allocation found.', style: TextStyle(color: AppPallete.grey),),
          //     );
          //   },
          // ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context, AddAllocationRequestPage.route());
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
