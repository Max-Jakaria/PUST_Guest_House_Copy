import 'package:fpdart/fpdart.dart';
import 'package:pust_guest_house/core/error/failures.dart';
import 'package:pust_guest_house/core/usecase/usecase.dart';
import 'package:pust_guest_house/core/common/entities/user.dart';
import 'package:pust_guest_house/features/auth/demain/repository/auth_repository.dart';

class CurrentUser implements UseCase<MyUser, NoParams> {
  final AuthRepository authRepository;

  CurrentUser({required this.authRepository});

  @override
  Future<Either<Failure, MyUser>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}
