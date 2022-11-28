
import 'package:ditonton/data/models/tv_series_detail.dart';
import 'package:ditonton/data/models/tv_series_table.dart';
import 'package:inti/inti.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';


final testTV = TvSeries(
  backdropPath: '/rkB4LyZHo1NHXFEDHl9vSD9r1lI.jpg',
  genreIds: const [16, 10765, 10759, 18],
  id: 94605,
  originalName: 'Arcane',
  overview: 'Amid the stark discord of twin cities Piltover and Zaun, two sisters fight on rival sides of a war between magic technologies and clashing convictions.',
  popularity: 107.593,
  posterPath: '/xQ6GijOFnxTyUzqiwGpVxgfcgqI.jpg',
  firstAirDate: '2021-11-06',
  name: 'Arcane',
  voteAverage: 9.066,
  voteCount: 2311,
);

final testTVList = [testTV];

final testTVDetail = TvDetail(
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

final testWatchlistTV = TvSeries.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvTable =TvTable
(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};
