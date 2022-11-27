import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';
import 'package:inti/inti.dart';
import 'package:dartz/dartz.dart';

class SearchTvUseCase {
  final TvRepository repository;
  SearchTvUseCase(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute(String query) {
    return repository.searchTv(query);
  }
}