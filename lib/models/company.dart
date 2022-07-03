import 'package:equatable/equatable.dart';

class Company extends Equatable {
  final int id;
  final String? logoPath;
  final String name;
  final String originalCountry;

  const Company(
      {required this.id,
      this.logoPath,
      required this.name,
      required this.originalCountry});

  factory Company.parserFromJson(Map<String, dynamic> result) {
    return Company(
      id: result['id'],
      logoPath: result['logo_path'],
      name: result['name'],
      originalCountry: result['origin_country'],
    );
  }

  @override
  List<Object?> get props => [id, logoPath, name, originalCountry];
}
