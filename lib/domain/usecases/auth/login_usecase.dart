import 'package:dartz/dartz.dart';
import 'package:shartflix/core/error/logger.dart';
import 'package:shartflix/core/network/network_info.dart';
import '../../../core/error/failures.dart';
import '../../entities/auth/user.dart';
import '../../repositories/auth_repository.dart';
import '../../../core/usecase/usecase.dart';

class LoginUseCase implements UseCase<User, LoginParams> {
  final AuthRepository repository;
  final INetworkInfo networkInfo;

  LoginUseCase(this.repository, this.networkInfo);

  @override
  Future<Either<Failure, User>> call(LoginParams params) async {
    try {
      if (!await networkInfo.isConnected) {
        return Left(ConnectionFailure());
      }

      return await repository.login(
        email: params.email,
        password: params.password,
      );
    } catch (e, stack) {
      AppLogger.logException(e, stack);
      return Left(ServerFailure("Bir hata oluştu", stack));
    }
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}
