import 'package:dartz/dartz.dart';
import 'package:inti/inti.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';


class GetTopTvUseCase {
  final TvRepository repository;

  GetTopTvUseCase(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getTopTv();
  }
}