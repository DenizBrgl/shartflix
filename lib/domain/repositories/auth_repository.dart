import 'package:dartz/dartz.dart';
import 'package:shartflix/core/error/failures.dart';
import 'package:shartflix/domain/entities/auth/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> register({
    required String email,
    required String name,
    required String password,
  });
}
