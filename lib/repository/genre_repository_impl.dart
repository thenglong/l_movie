import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:l_movie/blocs/response/genre_response.dart';
import 'package:l_movie/models/genre.dart';
import 'package:l_movie/repository/genre_repository.dart';

class GenreRepositoryImpl extends GenreRepository {
  static final _apiKey = dotenv.env['API_KEY'];
  final Client _client;

  GenreRepositoryImpl({Client? client}) : _client = client ?? Client();

  @override
  Future<List<Genre>> fetchGenres() async {
    final response = await _client.get(Uri.parse(
        'https://api.themoviedb.org/3/genre/movie/list?api_key=$_apiKey&language=en-US'));
    if (response.statusCode == 200) {
      return GenreResponse.parseFromJson(json.decode(response.body)).genres;
    } else {
      throw Exception('Fail to load movie');
    }
  }
}
