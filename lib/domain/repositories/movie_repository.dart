// domain/repositories/movie_repository.dart

import 'package:dartz/dartz.dart';
import 'package:shartflix/domain/entities/home/movie_entity.dart';
import 'package:shartflix/core/error/failures.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<MovieEntity>>> getMovies({int page});
  Future<Either<Failure, Unit>> toggleFavorite(String movieId, bool isFavorite);
}
