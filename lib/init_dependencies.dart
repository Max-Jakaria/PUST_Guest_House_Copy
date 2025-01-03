import 'package:get_it/get_it.dart';
import 'package:pust_guest_house/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:pust_guest_house/features/admin/allocationManagement/data/datasources/allocation_management_remote_data_source.dart';
import 'package:pust_guest_house/features/admin/allocationManagement/data/repositories/allocation_management_repository_impl.dart';
import 'package:pust_guest_house/features/admin/allocationManagement/domain/repositories/allocation_management_repository.dart';
import 'package:pust_guest_house/features/admin/allocationManagement/domain/usecases/get_all_allocation.dart';
import 'package:pust_guest_house/features/admin/allocationManagement/domain/usecases/get_allocation_by_status.dart';
import 'package:pust_guest_house/features/admin/allocationManagement/domain/usecases/update_allocation.dart';
import 'package:pust_guest_house/features/admin/allocationManagement/presentation/bloc/allocation_management_bloc.dart';
import 'package:pust_guest_house/features/auth/data/dataSources/auth_remote_data_source.dart';
import 'package:pust_guest_house/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:pust_guest_house/features/auth/demain/repository/auth_repository.dart';
import 'package:pust_guest_house/features/auth/demain/usecases/current_user.dart';
import 'package:pust_guest_house/features/auth/demain/usecases/user_sign_in.dart';
import 'package:pust_guest_house/features/auth/demain/usecases/user_sign_up.dart';
import 'package:pust_guest_house/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pust_guest_house/features/client/data/datasources/add_allocation_remote_data_source.dart';
import 'package:pust_guest_house/features/client/data/repositories/add_allocation_repository_impl.dart';
import 'package:pust_guest_house/features/client/domain/repositories/add_allocation_repository.dart';
import 'package:pust_guest_house/features/client/domain/usecases/add_new_allocation.dart';
import 'package:pust_guest_house/features/client/domain/usecases/get_all_allocation.dart';
import 'package:pust_guest_house/features/client/domain/usecases/get_allocation_by_status.dart';
import 'package:pust_guest_house/features/client/presentation/bloc/add_allocation_bloc.dart';

final serviceLocator = GetIt.instance;
Future<void> initDependencies() async {
  _initAuth();
  _initAddAllocation();
  _initAllocationManagement();

  // core
  serviceLocator.registerLazySingleton(
    () => AppUserCubit(),
  );
}

void _initAuth() {
  serviceLocator
    // Data Source
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(),
    )
    // Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDataSource: serviceLocator(),
      ),
    )
    // Usecase
    ..registerFactory(
      () => UserSignUp(
        authRepository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserSignIn(
        authRepository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => CurrentUser(
        authRepository: serviceLocator(),
      ),
    )
    // Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userSignIn: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}

void _initAddAllocation() {
  // Data Source
  serviceLocator
    ..registerFactory<AddAllocationRemoteDataSource>(
      () => AddAllocationRemoteDataSourceImpl(),
    )
    // Repository
    ..registerFactory<AllocationRepository>(
      () => AllocationRepositoryImpl(
        allocationRemoteDataSource: serviceLocator(),
      ),
    )
    // Usecase
    ..registerFactory(
      () => AddNewAllocation(
        allocationRepository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetAllAllocation(
        allocationRepository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetAllocationByStatus(
        allocationRepository: serviceLocator(),
      ),
    )
    // Bloc
    ..registerLazySingleton(
      () => AddAllocationBloc(
        getAllAllocations: serviceLocator(),
        addNewAllocation: serviceLocator(),
        getAllocationByStatus: serviceLocator(),
      ),
    );
}

void _initAllocationManagement() {
  // Data Source
  serviceLocator
    ..registerFactory<AllocationManagementRemoteDataSource>(
      () => AllocationManagementRemoteDataSourceImpl(),
    )
    // Repository
    ..registerFactory<AllocationManagementRepository>(
      () => AllocationManagementRepositoryImpl(
        allocationRemoteDataSource: serviceLocator(),
      ),
    )
    // Usecase
    ..registerFactory(
      () => UpdateAllocation(
        allocationRepository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetAllAllocationAdmin(
        allocationRepository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetAllocationByStatusAdmin(
        allocationRepository: serviceLocator(),
      ),
    )
    // Bloc
    ..registerLazySingleton(
      () => AllocationManagementBloc(
        getAllAllocations: serviceLocator(),
        uploadAllocation: serviceLocator(),
        getAllocationByStatus: serviceLocator(),
      ),
    );
}
