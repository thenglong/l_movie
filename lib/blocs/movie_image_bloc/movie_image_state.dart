import 'package:equatable/equatable.dart';
import 'package:l_movie/models/movie_image.dart';

abstract class MovieImageState extends Equatable {
  @override
  List<Object> get props => [];
}

class MovieImageInit extends MovieImageState {}

class GetMovieImagesSuccess extends MovieImageState {
  final MovieImage images;

  GetMovieImagesSuccess(this.images);

  @override
  List<Object> get props => [images];
}

class GetMovieImagesError extends MovieImageState {
  final String msg;

  GetMovieImagesError(this.msg);

  @override
  List<Object> get props => [msg];
}
