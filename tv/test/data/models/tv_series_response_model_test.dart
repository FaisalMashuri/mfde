import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv/tv.dart';
import '../../json_reader.dart';

void main() {
  var tTvSeriesModel = TvModel(
    originCountry: ["US"],
    originalLanguage: "en",
    backdropPath: "/path.jpg",
    genreIds: [1, 2, 3, 4],
    id: 1,
    originalName: "Original Name",
    overview: "Overview",
    popularity: 1.0,
    posterPath: "/path.jpg",
    firstAirDate: "2019-07-09",
    name: "Name",
    voteAverage: 1.0,
    voteCount: 1,
  );

  var tTvSeriesResponseModel =
      TvResponse(results: <TvModel>[tTvSeriesModel], totalPages: 41, totalResults: 804, page: 1);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arangge
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/now_playing_tv.json'));
      // act
      final result = TvResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvSeriesResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      // arrange

      // act
      final result = tTvSeriesResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "page": 1,
        "results": [
          {
            "backdrop_path": "/path.jpg",
            "first_air_date": "2019-07-09",
            "genre_ids": [1, 2, 3, 4],
            "id": 1,
            "name": "Name",
            "origin_country": ["US"],
            "original_language": "en",
            "original_name": "Original Name",
            "overview": "Overview",
            "popularity": 1.0,
            "poster_path": "/path.jpg",
            "vote_average": 1.0,
            "vote_count": 1
          }
        ],
        "total_pages": 41,
        "total_results" : 804
      };
      expect(result, expectedJsonMap);
    });
  });
}
