
import 'package:inti/inti.dart';
import 'package:tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvSeries = TvDetail(
    seasons: [],
    adult: true,
    backdropPath: 'backdropPath',
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    numberOfEpisodes: 2,
    name: 'name',
    numberOfSeasons: 2,
    overview: 'overview',
    posterPath: 'posterPath',
    episodeRunTime: [2],
    voteAverage: 1,
    voteCount: 1,
  );

  var tTvSeriesModel = TvDetailModel(
    seasons: [],
    adult: true,
    backdropPath: 'backdropPath',
    genres: [GenreModel(id: 1, name: 'Action')],
    id: 1,
    numberOfEpisodes: 2,
    name: 'name',
    numberOfSeasons: 2,
    overview: 'overview',
    posterPath: 'posterPath',
    episodeRunTime: [2],
    voteAverage: 1,
    voteCount: 1,
  );

  test('should be a subclass if Tv Series entity', () async {
    final result = tTvSeriesModel.toEntity();
    expect(result, tTvSeries);
  });
}
