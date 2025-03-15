import 'package:blog/core/error/failure.dart';
import 'package:blog/core/exceptions/serverexception.dart';
import 'package:blog/core/network/NetworkChecker.dart';
import 'package:blog/features/auth/data/datasources/remote_data_soureces.dart';
import 'package:blog/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

import '../../../../core/common/User.dart';

class AuthRepositoryImpl implements AuthRepository {
  final remoteDataSource authRepository;
  final NetWorkChecker netWorkChecker;
  const AuthRepositoryImpl(this.authRepository, this.netWorkChecker);
  @override
  Future<Either<Failure, User>> signInWithEmailPassword(
      {required String email, required String password}) async {
    try {
      if (!(await netWorkChecker.isConntected)) {
        return Left(Failure("no Internet Connection"));
      }
      final user = await authRepository.signInWithEmailPassword(
          email: email, password: password);
      return right(user);
    } on Serverexception catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      if (!(await netWorkChecker.isConntected)) {
        return Left(Failure("no Internet Connection"));
      }
      final user = await authRepository.signUpWithEmailPassword(
          name: name, email: email, password: password);
      return right(user);
    } on Serverexception catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final user = await authRepository.getCurrentUser();
      if (user == null) {
        return left(Failure("user not logged"));
      }
      return right(user);
    } on Serverexception catch (e) {
      return left(Failure(e.message));
    }
  }
}
