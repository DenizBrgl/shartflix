import 'package:dartz/dartz.dart';
import 'package:shartflix/core/error/logger.dart';
import '../../../core/error/failures.dart';
import '../../entities/auth/user.dart';
import '../../repositories/auth_repository.dart';
import '../../../core/network/network_info.dart';

class RegisterUseCase {
  final AuthRepository repository;
  final INetworkInfo networkInfo;

  RegisterUseCase(this.repository, this.networkInfo);
  Future<Either<Failure, User>> call(RegisterParams params) async {
    try {
      if (!await networkInfo.isConnected) {
        return Left(ConnectionFailure());
      }

      return await repository.register(
        name: params.name,
        email: params.email,
        password: params.password,
      );
    } catch (e, stack) {
      AppLogger.logException(e, stack);
      return Left(ServerFailure("Bir hata oluştu", stack));
    }
  }
}

class RegisterParams {
  final String email;
  final String name;
  final String password;

  RegisterParams({
    required this.email,
    required this.name,
    required this.password,
  });
}
