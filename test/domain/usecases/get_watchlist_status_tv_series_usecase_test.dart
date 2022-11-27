import 'package:ditonton/domain/usecases/get_watchlist_status_tv_series_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';


import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchListStatusTvUseCase usecase;
  late MockTvRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvRepository();
    usecase = GetWatchListStatusTvUseCase(mockTvSeriesRepository);
  });

  test('should get watchlist status tv series from repository', () async {
    // arrange
    when(mockTvSeriesRepository.isAddedToWatchlist(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, true);
  });
}