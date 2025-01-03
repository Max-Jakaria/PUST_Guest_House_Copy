import 'package:fpdart/fpdart.dart';
import 'package:pust_guest_house/core/error/failures.dart';
import 'package:pust_guest_house/core/usecase/usecase.dart';
import 'package:pust_guest_house/core/common/entities/user.dart';
import 'package:pust_guest_house/features/auth/demain/repository/auth_repository.dart';

class UserSignIn implements UseCase<MyUser, UserSignInParams> {
  final AuthRepository authRepository;

  const UserSignIn({required this.authRepository});

  @override
  Future<Either<Failure, MyUser>> call(UserSignInParams params) async {
    return await authRepository.signInWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignInParams {
  final String email;
  final String password;

  UserSignInParams({
    required this.email,
    required this.password,
  });
}
