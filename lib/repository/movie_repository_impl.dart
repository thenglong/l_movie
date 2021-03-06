import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:l_movie/blocs/response/movie_response.dart';
import 'package:l_movie/constants/movie_constants.dart';
import 'package:l_movie/models/movie.dart';
import 'package:l_movie/models/movie_image.dart';
import 'package:l_movie/models/movie_info.dart';
import 'package:l_movie/models/movie_video.dart';

import 'movie_repository.dart';

class MovieRepositoryImpl extends MovieRepository {
  static final _apiKey = dotenv.env['API_KEY'];
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

  @override
  Future<List<Movie>> fetchMovieByGenres(List<int> genresId) async {
    final response = await _client.get(Uri.parse(
        'https://api.themoviedb.org/3/discover/movie?api_key=$_apiKey&language=en-US&sort_by=popularity.desc&include_adult=true&include_video=true&page=1&with_genres=${genresId.join(",")}'));
    if (response.statusCode == 200) {
      return MovieResponse.parserFromJson(json.decode(response.body)).movies;
    } else {
      throw Exception('Fail to load movie by this genre');
    }
  }

  @override
  Future<List<MovieVideo>> fetchMovieVideos(int videoId) async {
    final response = await _client.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/$videoId/videos?api_key=$_apiKey&language=en-US'));
    if (response.statusCode == 200) {
      final results = json.decode(response.body)['results'] as List;
      return results.map((e) => MovieVideo.fromJson(e)).toList();
    } else {
      throw Exception('Fail to load movie by this genre');
    }
  }
}
