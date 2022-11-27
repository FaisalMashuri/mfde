import 'package:dartz/dartz.dart';
import 'package:inti/inti.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';


class GetTvSeriesRecommendationsUseCase {
  final TvRepository repository;

  GetTvSeriesRecommendationsUseCase(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute(id) {
    return repository.getTvRecommendations(id);
  }
}