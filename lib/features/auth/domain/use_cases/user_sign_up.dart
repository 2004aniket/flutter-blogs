import 'package:blog/core/error/failure.dart';
import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

import '../../../../core/common/User.dart';

class UserSignUp implements Usecase<User, UserSignUpParms> {
  final AuthRepository authRepository;
  UserSignUp(this.authRepository);
  @override
  Future<Either<Failure, User>> call(Parms) async {
    return await authRepository.signUpWithEmailPassword(
        name: Parms.name, email: Parms.email, password: Parms.password);
  }
}

class UserSignUpParms {
  final String name;
  final String email;
  final String password;
  UserSignUpParms(this.name, this.email, this.password);
}
