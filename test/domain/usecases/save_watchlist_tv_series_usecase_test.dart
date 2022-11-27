import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv_series_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlistTvUseCase usecase;
  late MockTvRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvRepository();
    usecase = SaveWatchlistTvUseCase(mockTvSeriesRepository);
  });

  test('should save tv series to the repository', () async {
    // arrange
    when(mockTvSeriesRepository.saveWatchlist(testTVDetail))
        .thenAnswer((_) async => const Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTVDetail);
    // assert
    verify(mockTvSeriesRepository.saveWatchlist(testTVDetail));
    expect(result, const Right('Added to Watchlist'));
  });
}