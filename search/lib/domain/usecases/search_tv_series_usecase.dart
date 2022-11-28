import 'package:tv/tv.dart';
import 'package:inti/inti.dart';
import 'package:dartz/dartz.dart';

class SearchTvUseCase {
  final TvRepository repository;
  SearchTvUseCase(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute(String query) {
    return repository.searchTv(query);
  }
}