import 'package:dartz/dartz.dart';
import 'package:inti/inti.dart';
import 'package:tv/tv.dart';

class GetNowPlayingTvUseCase {
  final TvRepository repository;

  GetNowPlayingTvUseCase(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getNowPlayingTv();
  }
}