import 'package:equatable/equatable.dart';

class Language extends Equatable {
  final String name;
  final String engName;
  final String countryCode;

  const Language(
      {required this.name, required this.engName, required this.countryCode});

  factory Language.parserFromJson(Map<String, dynamic> result) {
    return Language(
      name: result['name'],
      engName: result['english_name'],
      countryCode: result['iso_639_1'],
    );
  }

  @override
  List<Object> get props => [name, engName, countryCode];
}
