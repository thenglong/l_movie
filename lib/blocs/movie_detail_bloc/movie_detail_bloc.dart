import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l_movie/blocs/movie_detail_bloc/movie_detail_event.dart';
import 'package:l_movie/blocs/movie_detail_bloc/movie_detail_state.dart';
import 'package:l_movie/repository/movie_repository.dart';

class MovieDetailBloc extends Bloc<GetMovieDetailEvent, MovieDetailState> {
  final MovieRepository movieRepository;
  Connectivity connectivity = Connectivity();

  MovieDetailBloc(this.movieRepository) : super(MovieDetailInit()) {
    on<GetMovieDetailEvent>((event, emit) async {
      final connection = await connectivity.checkConnectivity();
      if (connection == ConnectivityResult.none) {
        emit(GetMovieDetailError('Please check the network connection'));
        return;
      }

      try {
        final info = await movieRepository.getMovieInfo(event.movieId);
        emit(GetMovieDetailSuccess(info));
        return;
      } on Exception catch (e) {
        emit(GetMovieDetailError(e.toString()));
      }
      addError(Exception('Cannot support the event'));
    });
  }
}
