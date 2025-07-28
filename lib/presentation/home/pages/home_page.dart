import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix/data/datasources/home/movie_remote_data_source.dart';
import 'package:shartflix/domain/repositories/movie_repository.dart';
import 'package:shartflix/injection_container.dart';
import 'package:shartflix/presentation/home/bloc/movie_bloc.dart';
import 'package:shartflix/presentation/home/bloc/movie_event.dart';
import 'package:shartflix/presentation/home/bloc/movie_state.dart';
import 'package:shartflix/presentation/home/widgets/movie_card.dart';
import 'package:shartflix/presentation/home/widgets/shimmer_movie_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MovieBloc _movieBloc = sl<MovieBloc>();
  final ScrollController _scrollController = ScrollController();
  int _page = 1;

  @override
  void initState() {
    super.initState();
    _movieBloc.add(FetchMovies(page: _page));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 300) {
        _page++;
        _movieBloc.add(FetchMovies(page: _page));
      }
    });
  }

  Future<void> _refreshMovies() async {
    _page = 1;
    _movieBloc.add(FetchMovies(page: _page));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _movieBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: BlocBuilder<MovieBloc, MovieState>(
          bloc: _movieBloc,
          builder: (context, state) {
            if (state is MovieLoading && _page == 1) {
              return ListView.builder(
                itemCount: 5,
                padding: const EdgeInsets.only(top: 16),
                itemBuilder: (context, index) => const ShimmerMovieCard(),
              );
            } else if (state is MovieLoaded) {
              return RefreshIndicator(
                onRefresh: _refreshMovies,
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: state.movies.length + 1,
                  itemBuilder: (context, index) {
                    if (index < state.movies.length) {
                      final movie = state.movies[index];
                      return MovieCard(
                        movie: movie,
                        onLikeTap: (newValue) async {
                          await sl<MovieRepository>().toggleFavorite(
                            movie.id,
                            newValue,
                          );
                        },
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 5,
                        itemBuilder: (_, i) => const ShimmerMovieCard(),
                      );
                    }
                  },
                ),
              );
            } else if (state is MovieError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            } else {
              return const Center(
                child: Text(
                  "Veri bulunamadı",
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
