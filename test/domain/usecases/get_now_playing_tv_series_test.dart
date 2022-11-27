import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv_series_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';


import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetNowPlayingTvUseCase usecase;
  late MockTvRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvRepository();
    usecase = GetNowPlayingTvUseCase(mockTvSeriesRepository);
  });

  final tTvSeries = <TvSeries>[];

  test('should get list of tv series from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.getNowPlayingTv())
        .thenAnswer((_) async => Right(tTvSeries));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTvSeries));
  });
}