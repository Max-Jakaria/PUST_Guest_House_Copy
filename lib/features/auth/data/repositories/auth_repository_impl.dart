import 'package:fpdart/src/either.dart';
import 'package:pust_guest_house/core/error/exceptions.dart';
import 'package:pust_guest_house/core/error/failures.dart';
import 'package:pust_guest_house/features/auth/data/dataSources/auth_remote_data_source.dart';
import 'package:pust_guest_house/core/common/entities/user.dart';
import 'package:pust_guest_house/features/auth/demain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  const AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, MyUser>> currentUser() async {
    try {
      final user = await remoteDataSource.getCurrentUserData();

      if (user == null) {
        return left(Failure('User not logged in.'));
      }
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, MyUser>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await _getUser(
      () async => await remoteDataSource.signInWithEmailAndPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, MyUser>> signUpWithUserInfo(
      {required String userName,
      required String designation,
      required String email,
      required String userPhoneNumber,
      required String password,
      required String department}) async {
    return await _getUser(
      () async => await remoteDataSource.signUpWithUserInfo(
        userName: userName,
        designation: designation,
        email: email,
        userPhoneNumber: userPhoneNumber,
        password: password,
        department: department,
      ),
    );
  }

  Future<Either<Failure, MyUser>> _getUser(
    Future<MyUser> Function() fn,
  ) async {
    try {
      final res = await fn();
      return right(res);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
