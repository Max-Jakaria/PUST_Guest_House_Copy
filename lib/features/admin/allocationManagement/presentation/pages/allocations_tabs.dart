import 'package:flutter/material.dart';
import 'package:pust_guest_house/core/common/constant/app_const.dart';
import 'package:pust_guest_house/core/common/widgets/bg_home.dart';
import 'package:pust_guest_house/core/common/widgets/appBarWidget/custom_appbar.dart';
import 'package:pust_guest_house/features/admin/allocationManagement/presentation/pages/admin_all_allocation.dart';

class AllocationsTabs extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const AllocationsTabs(),
      );

  const AllocationsTabs({super.key});

  @override
  State<AllocationsTabs> createState() => _AllocationsTabsState();
}

class _AllocationsTabsState extends State<AllocationsTabs> {
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
              return AdminAllAllocation(
                status: e,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
