import 'package:equatable/equatable.dart';
import 'package:l_movie/constants/movie_constants.dart';
import 'package:l_movie/models/movie.dart';

abstract class MovieState extends Equatable {
  @override
  List<Object> get props => [];
}

class MovieInit extends MovieState {}

class MovieFetched extends MovieState {
  final List<Movie> movies;
  final MovieType type;
  MovieFetched(this.movies, this.type);

  @override
  List<Object> get props => [movies, type];
}

class MovieFetchError extends MovieState {
  final String message;
  MovieFetchError(this.message);

  @override
  List<Object> get props => [message];
}
