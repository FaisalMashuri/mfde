import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:search/search.dart';
import '../../helpers/test_helper.mocks.dart';


void main() {
  late SearchTvUseCase usecase;
  late MockTvRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockTvRepository();
    usecase = SearchTvUseCase(mockMovieRepository);
  });

  final tTv = <TvSeries>[];
  final tQuery = 'Arcane';

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockMovieRepository.searchTv(tQuery))
        .thenAnswer((_) async => Right(tTv));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tTv));
  });
}
