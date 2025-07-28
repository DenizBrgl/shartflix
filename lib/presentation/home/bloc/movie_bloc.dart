import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix/domain/entities/home/movie_entity.dart';
import 'package:shartflix/domain/usecases/home/get_movies_usecase.dart';
import 'package:shartflix/domain/usecases/home/toggle_favorite_usecase.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetMoviesUseCase getMoviesUseCase;
  final ToggleFavoriteUseCase toggleFavoriteUseCase;

  List<MovieEntity> _movies = [];

  MovieBloc(this.getMoviesUseCase, this.toggleFavoriteUseCase)
    : super(MovieInitial()) {
    on<FetchMovies>((event, emit) async {
      if (event.page == 1) {
        emit(MovieLoading());
        _movies.clear();
      }

      try {
        final movies = await getMoviesUseCase(event.page);
        _movies.addAll(movies);
        emit(MovieLoaded(List.from(_movies)));
      } catch (e) {
        emit(MovieError(e.toString()));
      }
    });

    on<RefreshMovies>((event, emit) async {
      emit(MovieLoading());
      try {
        _movies.clear();
        final movies = await getMoviesUseCase(1);
        _movies = movies;
        emit(MovieLoaded(List.from(_movies)));
      } catch (e) {
        emit(MovieError(e.toString()));
      }
    });
    on<ToggleFavoriteMovie>((event, emit) async {
      final result = await toggleFavoriteUseCase(
        event.movieId,
        event.isFavorite,
      );
      result.fold(
        (failure) => debugPrint("Favori hatası: ${failure.message}"),
        (_) => debugPrint("Favori güncellendi."),
      );
    });
  }
}
