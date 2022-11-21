import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/search_tv_series_usecase.dart';
import 'package:ditonton/presentation/provider/tv_series_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/failure.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'tv_series_search_notifier_test.mocks.dart';

@GenerateMocks([SearchTvUseCase])
void main() {
  late TvSeriesSearchNotifier provider;
  late MockSearchTvUseCase mockSearchMovies;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchMovies = MockSearchTvUseCase();
    provider = TvSeriesSearchNotifier(searchTvSeries: mockSearchMovies)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tId = 1;

  final tTv = TvSeries(
    backdropPath: '/rkB4LyZHo1NHXFEDHl9vSD9r1lI.jpg',
    genreIds: const [16, 10765, 10759, 18],
    id: 94605,
    originalName: 'Arcane',
    overview:
        'Amid the stark discord of twin cities Piltover and Zaun, two sisters fight on rival sides of a war between magic technologies and clashing convictions.',
    popularity: 107.593,
    posterPath: '/xQ6GijOFnxTyUzqiwGpVxgfcgqI.jpg',
    firstAirDate: '2021-11-06',
    name: 'Arcane',
    voteAverage: 9.066,
    voteCount: 2311,
  );

  final tTvList = [tTv];
  final tQuery = "Arcane";

  group('search movies', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Right(tTvList));
      // act
      provider.fetchTvSeriesSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loading);
    });

    test('should change search result data when data is gotten successfully',
        () async {
      // arrange
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Right(tTvList));
      // act
      await provider.fetchTvSeriesSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loaded);
      expect(provider.searchResult, tTvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTvSeriesSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
