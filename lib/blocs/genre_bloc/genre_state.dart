part of 'genre_bloc.dart';

abstract class GenreState extends Equatable {
  const GenreState();
}

class GenreInitial extends GenreState {
  @override
  List<Object> get props => [];
}

class GenresFetched extends GenreState {
  final List<Genre> genres;

  const GenresFetched(this.genres);

  @override
  List<Object?> get props => [genres];
}

class GenresFetchError extends GenreState {
  final String message;
  const GenresFetchError(this.message);

  @override
  List<Object> get props => [message];
}
