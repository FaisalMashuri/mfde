import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';
import 'package:inti/inti.dart';


class RemoveWatchlistTvUseCase {
  final TvRepository repository;

  RemoveWatchlistTvUseCase(this.repository);

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return repository.removeWatchlist(tv);
  }}