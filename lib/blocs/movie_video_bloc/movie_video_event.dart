part of 'movie_video_bloc.dart';

abstract class MovieVideoEvent extends Equatable {
  const MovieVideoEvent();
}

class GetMovieVideosEvent extends MovieVideoEvent {
  final int movieId;
  const GetMovieVideosEvent(this.movieId);

  @override
  List<Object> get props => [movieId];
}
