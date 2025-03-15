import 'package:blog/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/common/User.dart';
// import 'package:fpdart/f'

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> signInWithEmailPassword({
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> getCurrentUser();
}
