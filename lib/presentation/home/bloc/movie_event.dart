import 'package:equatable/equatable.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object?> get props => [];
}

class FetchMovies extends MovieEvent {
  final int page;

  const FetchMovies({this.page = 1});

  @override
  List<Object?> get props => [page];
}

class RefreshMovies extends MovieEvent {
  final int page;

  const RefreshMovies({this.page = 1});

  @override
  List<Object?> get props => [page];
}

class ToggleFavoriteMovie extends MovieEvent {
  final String movieId;
  final bool isFavorite;

  const ToggleFavoriteMovie(this.movieId, this.isFavorite);

  @override
  List<Object?> get props => [movieId, isFavorite];
}
