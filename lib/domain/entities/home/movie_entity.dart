class MovieEntity {
  final String id;
  final String title;
  final String year;
  final String rated;
  final String released;
  final String runtime;
  final String genre;
  final String director;
  final String writer;
  final String actors;
  final String plot;
  final String language;
  final String country;
  final String awards;
  final String poster;
  final String metascore;
  final String imdbRating;
  final String imdbVotes;
  final String imdbID;
  final String type;
  final bool comingSoon;
  final bool isFavorite;
  final List<String> images;

  MovieEntity({
    required this.id,
    required this.title,
    required this.year,
    required this.rated,
    required this.released,
    required this.runtime,
    required this.genre,
    required this.director,
    required this.writer,
    required this.actors,
    required this.plot,
    required this.language,
    required this.country,
    required this.awards,
    required this.poster,
    required this.metascore,
    required this.imdbRating,
    required this.imdbVotes,
    required this.imdbID,
    required this.type,
    required this.comingSoon,
    required this.isFavorite,
    required this.images,
  });

  @override
  String toString() {
    return 'MovieEntity('
        'id: $id, '
        'title: $title, '
        'year: $year, '
        'genre: $genre, '
        'imdbRating: $imdbRating, '
        'isFavorite: $isFavorite, '
        'comingSoon: $comingSoon'
        ')';
  }
}
