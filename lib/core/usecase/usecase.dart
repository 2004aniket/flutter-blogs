import 'package:blog/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class Usecase<SuccessType, Parms> {
  Future<Either<Failure, SuccessType>> call(Parms);
}

class NoParms {}
