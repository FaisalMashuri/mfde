import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';
import 'package:inti/inti.dart';

class GetWatchlistTvUseCase {
  final TvRepository _repository;

  GetWatchlistTvUseCase(this._repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return _repository.getWatchlistTv();
  }
}