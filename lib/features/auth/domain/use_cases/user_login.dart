import 'package:blog/core/error/failure.dart';
import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

import '../../../../core/common/User.dart';

class UserLogin implements Usecase<User, UserSigninParms> {
  final AuthRepository authRepository;

  UserLogin({required this.authRepository});

  @override
  Future<Either<Failure, User>> call(Parms) async {
    return await authRepository.signInWithEmailPassword(
        email: Parms.email, password: Parms.password);
  }
}

class UserSigninParms {
  final String email;
  final String password;

  UserSigninParms({required this.email, required this.password});
}
