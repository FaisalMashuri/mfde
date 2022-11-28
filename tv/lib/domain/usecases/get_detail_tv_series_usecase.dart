import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';
import 'package:inti/inti.dart';


class GetTvDetailUseCase {
  final TvRepository repository;

  GetTvDetailUseCase(this.repository);

  Future<Either<Failure, TvDetail>> execute(int id) {
    return repository.getTvDetail(id);
  }
}