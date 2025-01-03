import 'package:flutter/material.dart';
import 'package:pust_guest_house/core/theme/app_pallete.dart';
import 'package:pust_guest_house/features/admin/allocationManagement/presentation/pages/allocations_tabs.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  int pageIndex = 0;


  final List<Widget> navPages = [
    AllocationsTabs(),
    // Container(color: Colors.red,),
    Container(color: Colors.green,),
    Container(color: Colors.blue,)
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navPages[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        // type: BottomNavigationBarType.fixed,
        currentIndex: pageIndex,
        selectedItemColor: AppPallete.primary,
        backgroundColor: AppPallete.primaryExtraLight,
        onTap: (value) {
          setState(() {
            pageIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.request_quote),
            label: 'Requests',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_card),
            label: 'Houses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Users',
          ),
        ],
      ),
    );
  }
}
