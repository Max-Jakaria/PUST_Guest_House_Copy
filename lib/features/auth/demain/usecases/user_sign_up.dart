import 'package:fpdart/fpdart.dart';
import 'package:pust_guest_house/core/error/failures.dart';
import 'package:pust_guest_house/core/usecase/usecase.dart';
import 'package:pust_guest_house/core/common/entities/user.dart';
import 'package:pust_guest_house/features/auth/demain/repository/auth_repository.dart';

class UserSignUp implements UseCase<MyUser, UserSignUpParamms> {
  final AuthRepository authRepository;
  const UserSignUp({required this.authRepository});

  @override
  Future<Either<Failure, MyUser>> call(UserSignUpParamms params) async {
    return await authRepository.signUpWithUserInfo(
      userName: params.userName,
      designation: params.designation,
      email: params.email,
      userPhoneNumber: params.userPhoneNumber,
      password: params.password,
      department: params.department,
    );
  }
}

class UserSignUpParamms {
  final String userName;
  final String designation;
  final String email;
  final String userPhoneNumber;
  final String password;
  final String department;

  UserSignUpParamms({
    required this.userName,
    required this.designation,
    required this.email,
    required this.userPhoneNumber,
    required this.password,
    required this.department,
  });
}
