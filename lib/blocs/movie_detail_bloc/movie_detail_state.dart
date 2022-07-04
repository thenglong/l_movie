import 'package:equatable/equatable.dart';
import 'package:l_movie/models/movie_info.dart';

abstract class MovieDetailState extends Equatable {
  @override
  List<Object> get props => [];
}

class MovieDetailInit extends MovieDetailState {}

class GetMovieDetailSuccess extends MovieDetailState {
  final MovieInfo movieInfo;

  GetMovieDetailSuccess(this.movieInfo);

  @override
  List<Object> get props => [movieInfo];
}

class GetMovieDetailError extends MovieDetailState {
  final String message;

  GetMovieDetailError(this.message);

  @override
  List<Object> get props => [message];
}
