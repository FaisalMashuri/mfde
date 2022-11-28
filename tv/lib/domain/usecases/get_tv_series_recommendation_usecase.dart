import 'package:dartz/dartz.dart';
import 'package:inti/inti.dart';
import "package:tv/tv.dart";


class GetTvSeriesRecommendationsUseCase {
  final TvRepository repository;

  GetTvSeriesRecommendationsUseCase(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute(id) {
    return repository.getTvRecommendations(id);
  }
}