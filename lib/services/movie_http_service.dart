import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

@immutable
class MovieHttpService {
  static const _baseUrl = 'https://api.themoviedb.org';
  static final MovieHttpService _instance = MovieHttpService._internal();
  late final Dio _dio;

  static Dio get instance {
    return _instance._dio;
  }

  MovieHttpService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
      ),
    );
    // https://stackoverflow.com/questions/54285172/how-to-solve-flutter-certificate-verify-failed-error-whi?.e-performing-a-post-req
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }
}
