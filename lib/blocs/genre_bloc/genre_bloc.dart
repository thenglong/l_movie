import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:l_movie/models/genre.dart';
import 'package:l_movie/repository/genre_repository.dart';

part 'genre_event.dart';
part 'genre_state.dart';

class GenreBloc extends Bloc<GenreEvent, GenreState> {
  final GenreRepository genreRepository;
  Connectivity connectivity = Connectivity();

  GenreBloc(this.genreRepository) : super(GenreInitial()) {
    on<GenreEvent>((event, emit) async {
      final connectResult = await connectivity.checkConnectivity();
      if (connectResult == ConnectivityResult.none) {
        emit(const GenresFetchError('Please check the network connection'));
        return;
      }

      try {
        final genres = await genreRepository.fetchGenres();
        emit(GenresFetched(genres));
      } on Exception catch (e) {
        emit(GenresFetchError(e.toString()));
      }

      addError(Exception('Cannot support the event'));
    });
  }
}
