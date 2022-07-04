import 'package:equatable/equatable.dart';
import 'package:l_movie/constants/movie_constants.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();
}

class FetchMovieWithType extends MovieEvent {
  final MovieType type;

  const FetchMovieWithType(this.type);

  @override
  List<Object> get props => [type];
}

class FetchMovieByGenres extends MovieEvent {
  final List<int> genresId;

  const FetchMovieByGenres(this.genresId);

  @override
  List<Object?> get props => [genresId];
}
