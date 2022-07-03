import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l_movie/blocs/movie_image_bloc/movie_image_event.dart';
import 'package:l_movie/blocs/movie_image_bloc/movie_image_state.dart';
import 'package:l_movie/repository/movie_repository.dart';

class MovieImageBloc extends Bloc<GetMovieImagesEvent, MovieImageState> {
  final MovieRepository movieRepository;
  final connectivity = Connectivity();

  MovieImageBloc(this.movieRepository) : super(MovieImageInit()) {
    on<GetMovieImagesEvent>((event, emit) async {
      final connection = await connectivity.checkConnectivity();
      if (connection == ConnectivityResult.none) {
        emit(GetMovieImagesError('Please check the network connection'));
        return;
      }

      try {
        final images = await movieRepository.getMovieImages(event.movieId);
        emit(GetMovieImagesSuccess(images));
        return;
      } on Exception catch (e) {
        emit(GetMovieImagesError(e.toString()));
      }

      addError(Exception('Cannot support the event'));
    });
  }
}
