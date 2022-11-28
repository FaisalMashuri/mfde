import 'package:tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:inti/inti.dart';

import 'popular_tv_series_test.mocks.dart';


@GenerateMocks([GetPopularTvUseCase])
void main() {
  late MockGetPopularTvUseCase mockGetPopularMovies;
  late PopularTvSeriesNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetPopularMovies = MockGetPopularTvUseCase();
    notifier =
        PopularTvSeriesNotifier(getPopularTvUseCase: mockGetPopularMovies)
          ..addListener(() {
            listenerCallCount++;
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
  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetPopularMovies.execute())
        .thenAnswer((_) async => Right(tTvList));
    // act
    notifier.fetchPopularTvSeries();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockGetPopularMovies.execute())
        .thenAnswer((_) async => Right(tTvList));
    // act
    await notifier.fetchPopularTvSeries();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tvSeries, tTvList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetPopularMovies.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchPopularTvSeries();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
