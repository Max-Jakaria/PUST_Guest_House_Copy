import 'package:fpdart/fpdart.dart';
import 'package:pust_guest_house/core/error/failures.dart';
import 'package:pust_guest_house/core/common/entities/user.dart';

abstract interface class AuthRepository{
  Future<Either<Failure, MyUser>> signUpWithUserInfo({
    required String userName,
    required String designation, 
    required String email, 
    required String userPhoneNumber,
    required String password, 
    required String department,
  });

  Future<Either<Failure, MyUser>> signInWithEmailAndPassword({
    required String email, 
    required String password, 
  });

  Future<Either<Failure, MyUser>> currentUser();
}