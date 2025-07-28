import 'package:shartflix/domain/entities/home/movie_entity.dart';
import 'package:shartflix/domain/repositories/movie_repository.dart';

class GetMoviesUseCase {
  final MovieRepository repository;

  GetMoviesUseCase(this.repository);

  Future<List<MovieEntity>> call(int page) async {
    final result = await repository.getMovies(page: page);
    return result.fold((failure) => [], (movies) => movies);
  }
}
