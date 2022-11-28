import 'package:dartz/dartz.dart';
import 'package:inti/inti.dart';
import 'package:tv/tv.dart';


class GetTopTvUseCase {
  final TvRepository repository;

  GetTopTvUseCase(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getTopTv();
  }
}