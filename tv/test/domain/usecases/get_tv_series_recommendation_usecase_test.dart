import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';


import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesRecommendationsUseCase usecase;
  late MockTvRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvRepository();
    usecase = GetTvSeriesRecommendationsUseCase(mockTvSeriesRepository);
  });

  const tId = 1;
  final tTvSeries = <TvSeries>[];

  test('should get list of tv series recommendations from the repository',
          () async {
        // arrange
        when(mockTvSeriesRepository.getTvRecommendations(tId))
            .thenAnswer((_) async => Right(tTvSeries));
        // act
        final result = await usecase.execute(tId);
        // assert
        expect(result, Right(tTvSeries));
      });
}