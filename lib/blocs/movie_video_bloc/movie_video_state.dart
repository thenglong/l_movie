part of 'movie_video_bloc.dart';

abstract class MovieVideoState extends Equatable {
  const MovieVideoState();
}

class MovieVideoInitial extends MovieVideoState {
  @override
  List<Object> get props => [];
}

class GetMovieVideosSuccess extends MovieVideoState {
  final List<MovieVideo> videos;
  final YoutubePlayerController youtubePlayerController;

  const GetMovieVideosSuccess(this.videos, this.youtubePlayerController);

  @override
  List<Object> get props => [videos];
}

class GetMovieVideosError extends MovieVideoState {
  final String message;

  const GetMovieVideosError(this.message);

  @override
  List<Object> get props => [message];
}
