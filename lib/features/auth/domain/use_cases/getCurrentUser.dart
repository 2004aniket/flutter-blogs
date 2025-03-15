import 'package:blog/core/error/failure.dart';
import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

import '../../../../core/common/User.dart';

class Getcurrentuser implements Usecase<User, NoParms> {
  final AuthRepository authRepository;

  Getcurrentuser(this.authRepository);

  @override
  Future<Either<Failure, User>> call(Parms) async {
    return await authRepository.getCurrentUser();
  }
}
