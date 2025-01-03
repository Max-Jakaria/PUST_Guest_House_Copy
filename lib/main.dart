import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pust_guest_house/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:pust_guest_house/core/theme/theme.dart';
import 'package:pust_guest_house/features/admin/admin_home.dart';
import 'package:pust_guest_house/features/admin/allocationManagement/presentation/bloc/allocation_management_bloc.dart';
import 'package:pust_guest_house/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pust_guest_house/features/auth/presentation/pages/signin_page.dart';
import 'package:pust_guest_house/features/client/presentation/bloc/add_allocation_bloc.dart';
import 'package:pust_guest_house/features/client/presentation/pages/client_home.dart';
import 'package:pust_guest_house/init_dependencies.dart';

void main() async {
  await initDependencies();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => serviceLocator<AppUserCubit>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<AuthBloc>(),
      ),
      // Client site allocation management
      BlocProvider(
        create: (context) => serviceLocator<AddAllocationBloc>(),
      ),
      // admin site allocation management
      BlocProvider(
        create: (context) => serviceLocator<AllocationManagementBloc>(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    context.read<AuthBloc>().add(AuthIsUserSignIn());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.darkThemeMode,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserSignedIn;
        },
        builder: (context, isSignedIn) {
          if (isSignedIn) {
            final user =
                (context.read<AppUserCubit>().state as AppUserSignedIn).user;
            if (user.user_type == 'admin') {
              print('----admin login success');
              return const AdminHomePage();
            } else {
              print('-----user login success');
              return const ClientHomePage();
            }
          }
          return const SignInPage();
        },
      ),
    );
  }
}
