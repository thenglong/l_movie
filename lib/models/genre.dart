import 'package:equatable/equatable.dart';

class Genre extends Equatable {
  final int id;
  final String name;

  const Genre({required this.id, required this.name});

  factory Genre.parseFromJson(Map<String, dynamic> result) {
    return Genre(id: result['id'], name: result['name']);
  }

  @override
  List<Object> get props => [id, name];
}
