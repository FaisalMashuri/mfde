import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistTvUseCase usecase;
  late MockTvRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvRepository();
    usecase = GetWatchlistTvUseCase(mockTvSeriesRepository);
  });

  test('should get list of tv series from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.getWatchlistTv())
        .thenAnswer((_) async => Right(testTVList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTVList));
  });
}