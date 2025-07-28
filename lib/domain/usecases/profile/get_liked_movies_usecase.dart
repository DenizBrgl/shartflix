import 'package:shartflix/data/models/movie/movie_model.dart';
import 'package:shartflix/domain/entities/home/movie_entity.dart';
import 'package:shartflix/domain/repositories/profile_repository.dart';

class GetLikedMoviesUseCase {
  final ProfileRepository repository;

  GetLikedMoviesUseCase(this.repository);

  Future<List<MovieEntity>> call() async {
    return await repository.getLikedMovies();
  }
}
