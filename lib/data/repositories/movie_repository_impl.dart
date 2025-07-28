import 'package:dartz/dartz.dart';
import 'package:shartflix/data/datasources/home/movie_remote_data_source.dart';
import 'package:shartflix/domain/entities/home/movie_entity.dart';
import 'package:shartflix/domain/repositories/movie_repository.dart';
import 'package:shartflix/core/error/failures.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<MovieEntity>>> getMovies({int page = 1}) async {
    try {
      final response = await remoteDataSource.getMovies(page);

      if (response.response.code != 200 || response.data == null) {
        return Left(ServerFailure(response.response.message));
      }

      final movies = response.data!.map((model) => model.toEntity()).toList();

      return Right(movies);
    } catch (e) {
      return Left(ServerFailure('Filmler alınamadı: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> toggleFavorite(
    String movieId,
    bool isFavorite,
  ) async {
    try {
      await remoteDataSource.toggleFavorite(movieId, isFavorite);
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure('Favori işlemi başarısız: $e'));
    }
  }
}
