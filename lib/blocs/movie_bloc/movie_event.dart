import 'package:equatable/equatable.dart';
import 'package:l_movie/constants/movie_constants.dart';

abstract class MovieEvent extends Equatable {}

class FetchMovieWithType extends MovieEvent {
  final MovieType type;

  FetchMovieWithType(this.type);

  @override
  List<Object> get props => [type];
}
