import 'package:flutter/material.dart';
import 'package:pust_guest_house/core/theme/app_pallete.dart';

class CustomAppBarBottom extends StatelessWidget {
  final List<String> tabOptions;
  const CustomAppBarBottom({super.key, required this.tabOptions});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: double.infinity,
      alignment: Alignment.centerLeft,
      color: Colors.black12,
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: TabBar(
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        labelPadding: const EdgeInsets.symmetric(horizontal: 0.0),
        labelStyle: const TextStyle(color: AppPallete.primary),
        tabs: tabOptions.map((e) {
          return Container(
            padding: EdgeInsets.symmetric(
                horizontal: (e.length > 3) ? 16.0 : 28.0, vertical: 10.0),
            child: Text(e),
          );
        }).toList(),
        labelColor: Colors.white,
        unselectedLabelColor: AppPallete.whiteLight,
        indicator: BoxDecoration(
          // Customize the indicator
          color: AppPallete.primary,
          borderRadius: BorderRadius.circular(4.0),
          gradient: const LinearGradient(
            colors: [
              AppPallete.primaryDeep,
              AppPallete.primaryLight,
            ],
          ), // Set the color of the selected tab
        ),
      ),
    );
  }
}
