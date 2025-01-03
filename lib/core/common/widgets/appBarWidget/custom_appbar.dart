import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pust_guest_house/core/common/constant/app_const.dart';
import 'package:pust_guest_house/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:pust_guest_house/core/common/widgets/appBarWidget/bottom_tab.dart';
import 'package:pust_guest_house/core/secrets/app_secrets.dart';
import 'package:pust_guest_house/core/theme/app_pallete.dart';
import 'package:pust_guest_house/core/utils/get_background_image.dart';
import 'package:pust_guest_house/core/common/widgets/appBarWidget/menu_pages/about.dart';
import 'package:pust_guest_house/core/common/widgets/appBarWidget/menu_pages/help_user.dart';
import 'package:pust_guest_house/core/common/widgets/appBarWidget/menu_pages/user_profile.dart';
import 'package:pust_guest_house/features/auth/presentation/pages/signin_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Size preferredSize;

  final bool? bottomTab;

  @override
  const MyAppBar({
    super.key,
    this.bottomTab,
  }) : preferredSize = (bottomTab == null)
            ? const Size.fromHeight(56.0)
            : const Size.fromHeight(90);

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(
              height: 40,
              width: 40,
              child: Image.asset('images/pust_logo.png'),
            ),
            const Text(
              'PUST Guest House',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      actions: _getMenueOption(),
      bottom: (widget.bottomTab == null || widget.bottomTab == false)
          ? null
          : const PreferredSize(
              preferredSize: Size.fromHeight(46),
              child: CustomAppBarBottom(tabOptions: AppConst.tabOptions),
            ),
    );
  }

  List<Widget> _getMenueOption() {
    try {
      final user = (context.read<AppUserCubit>().state as AppUserSignedIn).user;
      return [
        Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
              color: AppPallete.acceptColor,
              borderRadius: BorderRadius.circular(100)),
          padding: EdgeInsets.all(2.0),
          child: GestureDetector(
            onTap: () {
              print('User clicked');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserProfile()),
              );
            },
            child: CircleAvatar(
              backgroundImage: getBackgroundImage(user.profile_picture),
            ),
          ),
        ),
        PopupMenuButton<String>(
          itemBuilder: (BuildContext context) {
            // Define the items in the menu
            return [
              PopupMenuItem(
                onTap: () {
                  Navigator.push(
                    context,
                    AboutPage.route(),
                  );
                },
                child: Text('About'),
              ),
              PopupMenuItem(
                onTap: () {
                  Navigator.push(
                    context,
                    UserProfile.route(),
                  );
                },
                child: Text('View Profile'),
              ),
              PopupMenuItem(
                onTap: () {
                  // Navigator.popUntil(context, (route) => false);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => const SplashScreen()),
                  // );
                },
                child: Text('Refresh'),
              ),
              PopupMenuItem(
                onTap: () {
                  Navigator.push(
                    context,
                    HelpUser.route(),
                  );
                },
                child: Text('Help'),
              ),
              PopupMenuItem(
                onTap: () async {
                  // --- logoutConfirmationDialog(context);
                  final props = await SharedPreferences.getInstance();
                  props.remove(AppSecrets.tokenKey);
                  // Navigator.pop(context);
                  Navigator.popUntil(context, (route) => false);
                  Navigator.push(
                    context,
                    SignInPage.route(),
                  );
                },
                child: Text('Sign Out'),
              ),
            ];
          },
        ),
      ];
    } catch (e) {
      return [];
    }
  }
}
