import 'package:equatable/equatable.dart';
import 'package:l_movie/models/genre.dart';

class GenreResponse extends Equatable {
  final List<Genre> genres;

  const GenreResponse({required this.genres});

  factory GenreResponse.parseFromJson(Map<String, dynamic> result) {
    return GenreResponse(
      genres: (result['genres'] as List)
          .map((e) => Genre.parseFromJson(e))
          .toList(),
    );
  }

  @override
  List<Object> get props => [genres];
}
