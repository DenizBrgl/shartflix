import 'package:dartz/dartz.dart';
import 'package:shartflix/domain/repositories/movie_repository.dart';
import 'package:shartflix/core/error/failures.dart';

class ToggleFavoriteUseCase {
  final MovieRepository repository;

  ToggleFavoriteUseCase(this.repository);

  Future<Either<Failure, Unit>> call(String movieId, bool isFavorite) {
    return repository.toggleFavorite(movieId, isFavorite);
  }
}
