import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final int id;
  final int voteCount;
  final bool video;
  final double voteAverage;
  final String title;
  final double popularity;
  final String posterPath;
  final String originalLanguage;
  final String originalTitle;
  final List<int> genreIds;
  final String? backdropPath;
  final bool adult;
  final String overview;
  final String releaseDate;

  const Movie({
    required this.id,
    required this.voteCount,
    required this.video,
    required this.voteAverage,
    required this.title,
    required this.popularity,
    required this.posterPath,
    required this.originalLanguage,
    required this.originalTitle,
    required this.genreIds,
    required this.backdropPath,
    required this.adult,
    required this.overview,
    required this.releaseDate,
  });

  factory Movie.parserFromJson(Map<String, dynamic> result) {
    return Movie(
      id: result['id'],
      voteCount: result['vote_count'],
      video: result['video'],
      voteAverage: double.parse(result['vote_average'].toString()),
      title: result['title'],
      popularity: result['popularity'],
      posterPath: result['poster_path'],
      originalTitle: result['original_title'],
      originalLanguage: result['original_language'],
      backdropPath: result['backdrop_path'],
      adult: result['adult'],
      overview: result['overview'],
      releaseDate: result['release_date'],
      genreIds: List<int>.from(result['genre_ids']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        voteCount,
        video,
        voteAverage,
        title,
        posterPath,
        popularity,
        originalLanguage,
        originalTitle,
        genreIds,
        backdropPath,
        adult,
        overview,
        releaseDate,
      ];
}
