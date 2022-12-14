import 'package:equatable/equatable.dart';

class Season extends Equatable {
  const Season({
    required this.id,
    required this.name,
    required this.episodeCount,
    required this.posterPath,
    required this.seasonNumber
  });
  final int id;
  final String name;
  final int episodeCount;
  final String? posterPath;
  final int seasonNumber;

  @override
  List<Object?> get props => [id, name, seasonNumber, episodeCount, seasonNumber];
}