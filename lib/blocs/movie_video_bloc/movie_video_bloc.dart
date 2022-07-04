import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l_movie/models/movie_video.dart';
import 'package:l_movie/repository/movie_repository.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

part 'movie_video_event.dart';
part 'movie_video_state.dart';

class MovieVideoBloc extends Bloc<MovieVideoEvent, MovieVideoState> {
  final MovieRepository movieRepository;
  Connectivity connectivity = Connectivity();

  MovieVideoBloc(this.movieRepository) : super(MovieVideoInitial()) {
    on<GetMovieVideosEvent>((event, emit) async {
      final connection = await connectivity.checkConnectivity();
      if (connection == ConnectivityResult.none) {
        emit(const GetMovieVideosError('Please check the network connection'));
        return;
      }

      try {
        final videos = await movieRepository.fetchMovieVideos(event.movieId);
        final controller = YoutubePlayerController(
          initialVideoId: videos[0].key ?? '',
          flags: const YoutubePlayerFlags(
            autoPlay: true,
            mute: false,
          ),
        );
        emit(GetMovieVideosSuccess(videos, controller));
        return;
      } on Exception catch (e) {
        emit(GetMovieVideosError(e.toString()));
      }
      addError(Exception('Cannot support the event'));
    });
  }
}
