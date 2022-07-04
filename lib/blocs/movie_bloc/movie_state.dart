import 'package:equatable/equatable.dart';
import 'package:l_movie/models/movie.dart';

abstract class MovieState extends Equatable {
  @override
  List<Object> get props => [];
}

class MovieInit extends MovieState {}

class MovieFetched extends MovieState {
  final List<Movie> movies;
  MovieFetched(this.movies);

  @override
  List<Object> get props => [movies];
}

class MovieFetchError extends MovieState {
  final String message;
  MovieFetchError(this.message);

  @override
  List<Object> get props => [message];
}
