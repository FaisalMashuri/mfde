import 'package:dartz/dartz.dart';
import 'package:ditonton/data/models/tv_series_detail.dart';
import 'package:inti/inti.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class GetTvDetailUseCase {
  final TvRepository repository;

  GetTvDetailUseCase(this.repository);

  Future<Either<Failure, TvDetail>> execute(int id) {
    return repository.getTvDetail(id);
  }
}