import 'package:dartz/dartz.dart';
import 'package:inti/inti.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class SaveWatchlistTvUseCase {
  final TvRepository repository;

  SaveWatchlistTvUseCase(this.repository);

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return repository.saveWatchlist(tv);
  }
}