import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';
import 'package:inti/inti.dart';

class SaveWatchlistTvUseCase {
  final TvRepository repository;

  SaveWatchlistTvUseCase(this.repository);

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return repository.saveWatchlist(tv);
  }
}