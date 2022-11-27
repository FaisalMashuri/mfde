import 'package:dartz/dartz.dart';
import 'package:ditonton/data/models/tv_series_detail.dart';
import 'package:inti/inti.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';

abstract class TvRepository {

  //tv home
  Future<Either<Failure, List<TvSeries>>> searchTv(String query);
  Future<Either<Failure, List<TvSeries>>> getNowPlayingTv();
  Future<Either<Failure, List<TvSeries>>> getPopularTv();
  Future<Either<Failure, List<TvSeries>>> getTopTv();

  //detail
  Future<Either<Failure, TvDetail>> getTvDetail(int id);
  Future<Either<Failure, List<TvSeries>>> getTvRecommendations(int id);

  //wishlist
  Future<Either<Failure, String>> saveWatchlist(TvDetail tvSeries);
  Future<Either<Failure, String>> removeWatchlist(TvDetail tvSeries);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<TvSeries>>> getWatchlistTv();
}