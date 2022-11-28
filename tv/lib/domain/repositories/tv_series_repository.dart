import 'package:dartz/dartz.dart';
import 'package:inti/inti.dart';
import "package:tv/tv.dart";

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