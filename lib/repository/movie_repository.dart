import 'package:l_movie/constants/movie_constants.dart';
import 'package:l_movie/models/movie.dart';
import 'package:l_movie/models/movie_image.dart';
import 'package:l_movie/models/movie_info.dart';

abstract class MovieRepository {
  Future<List<Movie>> fetchMovies(MovieType type);

  Future<MovieInfo> getMovieInfo(int movieId);

  Future<MovieImage> getMovieImages(int movieId);

  Future<List<Movie>> fetchMovieByGenres(List<int> genresId);
}
