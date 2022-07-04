import 'package:equatable/equatable.dart';
import 'package:l_movie/models/image.dart';

class MovieImage extends Equatable {
  final List<Img> backdrops;
  final List<Img> posters;

  const MovieImage({required this.backdrops, required this.posters});

  factory MovieImage.parserFromJson(Map<String, dynamic> result) {
    return MovieImage(
      backdrops: (result['backdrops'] as List)
          .map((e) => Img.parserFromJson(e))
          .toList(),
      posters: (result['posters'] as List)
          .map((e) => Img.parserFromJson(e))
          .toList(),
    );
  }

  @override
  List<Object> get props => [backdrops, posters];
}
