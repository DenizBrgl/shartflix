import 'package:dartz/dartz.dart';
import 'package:shartflix/data/datasources/auth/auth_remote_data_source.dart';
import 'package:shartflix/data/models/auth/request/register_request_model.dart';
import 'package:shartflix/domain/entities/auth/user.dart';
import '../../../core/error/failures.dart';
import '../../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await remoteDataSource.login(
        email: email,
        password: password,
      );

      if (response.response.code != 200 || response.data == null) {
        return Left(ServerFailure(response.response.message));
      }

      return Right(response.data!.toEntity());
    } catch (e) {
      return Left(ServerFailure('Giriş başarısız: $e'));
    }
  }

  @override
  Future<Either<Failure, User>> register({
    required String email,
    required String name,
    required String password,
  }) async {
    try {
      final request = RegisterRequestModel(
        email: email,
        name: name,
        password: password,
      );

      final response = await remoteDataSource.register(request: request);

      if (response.response.code != 200 || response.data == null) {
        return Left(ServerFailure(response.response.message));
      }
      return Right(response.data!.toEntity());
    } catch (e) {
      return Left(ServerFailure('Kayıt başarısız: $e'));
    }
  }
}
