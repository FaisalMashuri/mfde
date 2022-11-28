import 'package:inti/inti.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  var tSeasonModel = SeasonModel(
    seasonNumber: 1,
    episodeCount: 2,
    name: 'name',
    airDate: '',
    id: 1,
    overview: '',
    posterPath: '',
  );

  var tSeason = Season(
    seasonNumber: 1,
    episodeCount: 2,
    name: 'name',
    id: 1,
    posterPath: '',
  );

  final tSeasonModelJsonValue = {
    'air_date': '',
    'episode_count': 2,
    'id': 1,
    'name': 'name',
    'overview': '',
    'poster_path': '',
    'season_number': 1
  };

  test('should be a subclass of Genre entity', () async {
    final result = tSeasonModel.toEntity();
    expect(result, tSeason);
  });

  test('should be convert to Genre model', () async {
    final result = SeasonModel.fromJson(tSeasonModelJsonValue);
    expect(result, tSeasonModel);
  });

  test('should be convert to json value from Genre model ', () async {
    final result = tSeasonModel.toJson();
    expect(result, tSeasonModelJsonValue);
  });
}
