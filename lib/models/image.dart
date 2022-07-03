import 'package:equatable/equatable.dart';

class Img extends Equatable {
  final double aspect;
  final String imagePath;
  final int height;
  final int width;
  final String? countryCode;
  final double voteAverage;
  final int voteCount;

  const Img({
    required this.aspect,
    required this.imagePath,
    required this.height,
    required this.width,
    required this.countryCode,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Img.parserFromJson(Map<String, dynamic> result) {
    final aspectRatio = result['aspect_ratio']?.toString();
    final countryCode = result['iso_639_1'];
    return Img(
      imagePath: result['file_path'],
      aspect: aspectRatio != null ? double.parse(aspectRatio) : 1.0,
      height: result['height'] ?? 0,
      width: result['width'] ?? 1,
      countryCode: countryCode,
      voteAverage: result['vote_average'],
      voteCount: result['vote_count'],
    );
  }

  @override
  List<Object?> get props => [
        aspect,
        imagePath,
        width,
        height,
        countryCode,
        voteCount,
        voteAverage,
        voteCount
      ];
}
