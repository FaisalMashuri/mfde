import 'package:tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  final tTvSeries = TvSeries(
    originCountry: ["Korea"],
    originalLanguage: "English",
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
    voteAverage: 1.0,
    voteCount: 1,
    popularity: 1,
    originalName: 'originalName',
    genreIds: const [1, 2, 3],
  );

  var tTvSeriesModel = TvModel(
    originCountry: ["Korea"],
    originalLanguage: "English",
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
    voteAverage: 1.0,
    voteCount: 1,
    popularity: 1,
    originalName: 'originalName',
    genreIds: [1, 2, 3],
  );

  test('should be a subclass if Tv Series entity', () async {
    final result = tTvSeriesModel.toEntity();
    expect(result, tTvSeries);
  });
}