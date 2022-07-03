import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l_movie/blocs/movie_bloc/movie_event.dart';
import 'package:l_movie/blocs/movie_bloc/movie_state.dart';
import 'package:l_movie/repository/movie_repository.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository;
  Connectivity connectivity = Connectivity();

  MovieBloc(this.movieRepository) : super(MovieInit()) {
    on<FetchMovieWithType>((event, emit) async {
      final connectResult = await connectivity.checkConnectivity();
      if (connectResult == ConnectivityResult.none) {
        emit(MovieFetchError('Please check the network connection'));
        return;
      }

      try {
        final movies = await movieRepository.fetchMovies(event.type);
        emit(MovieFetched(movies, event.type));
      } on Exception catch (e) {
        emit(MovieFetchError(e.toString()));
      }

      addError(Exception('Cannot support the event'));
    });
  }
}
