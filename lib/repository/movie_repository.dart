import 'package:l_movie/models/movie.dart';
import 'package:l_movie/models/movie_image.dart';
import 'package:l_movie/models/movie_info.dart';

abstract class MovieRepository {
  Future<List<Movie>> fetchMovies(String type);

  Future<MovieInfo> getMovieInfo(int movieId);

  Future<MovieImage> getMovieImages(int movieId);
}
