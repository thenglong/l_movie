part of 'genre_bloc.dart';

abstract class GenreEvent extends Equatable {
  const GenreEvent();
}

class FetchGenresEvent extends GenreEvent {
  const FetchGenresEvent();

  @override
  List<Object?> get props => [];
}
