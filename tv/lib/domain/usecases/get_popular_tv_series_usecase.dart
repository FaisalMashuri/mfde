import 'package:dartz/dartz.dart';
import 'package:inti/inti.dart';
import 'package:tv/tv.dart';


class GetPopularTvUseCase {
  final TvRepository repository;

  GetPopularTvUseCase(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getPopularTv();
  }
}