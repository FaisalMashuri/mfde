import 'package:dartz/dartz.dart';
import 'package:inti/inti.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class GetNowPlayingTvUseCase {
  final TvRepository repository;

  GetNowPlayingTvUseCase(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getNowPlayingTv();
  }
}