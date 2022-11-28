import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvDetailUseCase usecase;
  late MockTvRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvRepository();
    usecase = GetTvDetailUseCase(mockTvSeriesRepository);
  });

  const tId = 1;

  test('should get tv series detail from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.getTvDetail(any))
        .thenAnswer((_) async =>  Right(testTVDetail));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result,  Right(testTVDetail));
  });
}