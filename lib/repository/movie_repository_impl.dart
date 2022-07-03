import 'dart:convert';

import 'package:http/http.dart';
import 'package:l_movie/blocs/response/movie_response.dart';
import 'package:l_movie/constants/movie_constants.dart';
import 'package:l_movie/models/movie.dart';
import 'package:l_movie/models/movie_image.dart';
import 'package:l_movie/models/movie_info.dart';

import 'movie_repository.dart';

class MovieRepositoryImpl extends MovieRepository {
  static const _apiKey = 'apiKey';
  final Client _client;

  MovieRepositoryImpl({Client? client}) : _client = client ?? Client();

  @override
  Future<List<Movie>> fetchMovies(MovieType type) async {
    final response = await _client.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/${type.value}?api_key=$_apiKey'));
    if (response.statusCode == 200) {
      return MovieResponse.parserFromJson(json.decode(response.body)).movies;
    } else {
      throw Exception('Fail to load movie');
    }
  }

  @override
  Future<MovieInfo> getMovieInfo(int movieId) async {
    final response = await _client.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/$movieId?api_key=$_apiKey'));
    if (response.statusCode == 200) {
      return MovieInfo.parserFromJson(json.decode(response.body));
    } else {
      throw Exception('Fail to load movie info');
    }
  }

  @override
  Future<MovieImage> getMovieImages(int movieId) async {
    final response = await _client.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/$movieId/images?api_key=$_apiKey'));
    if (response.statusCode == 200) {
      return MovieImage.parserFromJson(json.decode(response.body));
    } else {
      throw Exception('Fail to load movie info');
    }
  }
}
