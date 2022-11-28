import 'package:dartz/dartz.dart';
import 'package:inti/inti.dart';

import 'package:tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvDetailUseCase,
  GetTvSeriesRecommendationsUseCase,
  GetWatchListStatusTvUseCase,
  SaveWatchlistTvUseCase,
  RemoveWatchlistTvUseCase,
])
void main() {
  late TvDetailNotifier provider;
  late MockGetTvDetailUseCase mockGetMovieDetail;
  late MockGetTvSeriesRecommendationsUseCase mockGetMovieRecommendations;
  late MockGetWatchListStatusTvUseCase mockGetWatchlistStatus;
  late MockSaveWatchlistTvUseCase mockSaveWatchlist;
  late MockRemoveWatchlistTvUseCase mockRemoveWatchlist;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetMovieDetail = MockGetTvDetailUseCase();
    mockGetMovieRecommendations = MockGetTvSeriesRecommendationsUseCase();
    mockGetWatchlistStatus = MockGetWatchListStatusTvUseCase();
    mockSaveWatchlist = MockSaveWatchlistTvUseCase();
    mockRemoveWatchlist = MockRemoveWatchlistTvUseCase();
    provider = TvDetailNotifier(
      getTvDetailUseCase: mockGetMovieDetail,
      getTvSeriesRecommendationsUseCase: mockGetMovieRecommendations,
      getWatchListStatusTvUseCase: mockGetWatchlistStatus,
      saveWatchlistUseCase: mockSaveWatchlist,
      removeWatchlistTvUseCase: mockRemoveWatchlist,
    )..addListener(() {
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
  void _arrangeUsecase() {
    when(mockGetMovieDetail.execute(tId))
        .thenAnswer((_) async => Right(testTVDetail));
    when(mockGetMovieRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tTvList));
  }

  group('Get Movie Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      verify(mockGetMovieDetail.execute(tId));
      verify(mockGetMovieRecommendations.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchTvSeriesDetail(tId);
      // assert
      expect(provider.tvSeriesState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change movie when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      expect(provider.tvSeriesState, RequestState.Loaded);
      expect(provider.tvDetail, testTVDetail);
      expect(listenerCallCount, 3);
    });

    test('should change recommendation movies when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      expect(provider.tvSeriesState, RequestState.Loaded);
      expect(provider.tvSeriesRecommendations, tTvList);
    });
  });

  group('Get Tv Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      verify(mockGetMovieRecommendations.execute(tId));
      expect(provider.tvSeriesRecommendations, tTvList);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.Loaded);
      expect(provider.tvSeriesRecommendations, tTvList);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((_) async => Right(testTVDetail));
      when(mockGetMovieRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetWatchlistStatus.execute(1)).thenAnswer((_) async => true);
      // act
      await provider.loadWatchlistStatus(1);
      // assert
      expect(provider.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveWatchlist.execute(testTVDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetWatchlistStatus.execute(testTVDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTVDetail);
      // assert
      verify(mockSaveWatchlist.execute(testTVDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveWatchlist.execute(testTVDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(mockGetWatchlistStatus.execute(testTVDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlist(testTVDetail);
      // assert
      verify(mockRemoveWatchlist.execute(testTVDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveWatchlist.execute(testTVDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockGetWatchlistStatus.execute(testTVDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTVDetail);
      // assert
      verify(mockGetWatchlistStatus.execute(testTVDetail.id));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveWatchlist.execute(testTVDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchlistStatus.execute(testTVDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.addWatchlist(testTVDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
      when(mockGetMovieRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tTvList));
      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      expect(provider.tvSeriesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });

    
  });
}
