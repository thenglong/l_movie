import 'package:l_movie/models/genre.dart';

abstract class GenreRepository {
  Future<List<Genre>> fetchGenres();
}
