import 'package:equatable/equatable.dart';

class Country extends Equatable {
  final String name;
  final String code;

  const Country({required this.name, required this.code});

  factory Country.parserFromJson(Map<String, dynamic> result) {
    return Country(
      name: result['name'],
      code: result['iso_3166_1'],
    );
  }

  @override
  List<Object> get props => [name, code];
}
