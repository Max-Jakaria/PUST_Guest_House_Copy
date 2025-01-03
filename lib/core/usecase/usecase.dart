import 'package:fpdart/fpdart.dart';
import 'package:pust_guest_house/core/error/failures.dart';

abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

class NoParams {
}