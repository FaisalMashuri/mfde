import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:inti/inti.dart' as inti;
import "package:tv/tv.dart";
import "package:tv/tv.dart";
import 'package:inti/inti.dart';


class TvRepositoryImpl implements TvRepository {
  final TvRemoteDataSource remoteDataSource;
  final TvLocalDataSource localDataSource;

  TvRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<inti.Failure, List<TvSeries>>> getNowPlayingTv() async {
    try {
      final result = await remoteDataSource.getNowPlayingTv();
      print(result);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(inti.ServerFailure(''));
    } on SocketException {
      return Left(inti.ConnectionFailure(inti.failedConnect));
    }on TlsException {
      return Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }

  @override
  Future<Either<inti.Failure, List<TvSeries>>> getPopularTv() async {
    try {
      final result = await remoteDataSource.getPopularTv();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure(failedConnect));
    }on TlsException {
      return Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getTopTv() async {
    try {
      final result = await remoteDataSource.getTopRatedTv();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure(failedConnect));
    }on TlsException {
      return Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }

  @override
  Future<Either<Failure, TvDetail>> getTvDetail(int id) async {
    try {
      final result = await remoteDataSource.getTvDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure(failedConnect));
    }on TlsException {
      return Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getTvRecommendations(int id) async {
    try {
      final result = await remoteDataSource.getTvRecommendations(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure(failedConnect));
    }on TlsException {
      return Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }


  @override
  Future<Either<Failure, String>> saveWatchlist(TvDetail tvTable) async {
    try {
      final result = await localDataSource.insertTvWatchlist(TvTable.fromEntity(tvTable));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      // throw e;
      return Left(DatabaseFailure("Failed to add watchlist"));
    }
  }

  @override
  Future<Either<Failure, String>> removeWatchlist(
      TvDetail tvSeries) async {
    try {
      final result = await localDataSource
          .removeTvWatchlist(TvTable.fromEntity(tvSeries));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }catch (e) {
      // throw e;
      return Left(DatabaseFailure("Failed to remove watchlist"));
    }
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async {
    final result = await localDataSource.getTvById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getWatchlistTv() async {
    final result = await localDataSource.getWatchlistTv();
    return Right(result.map((data) => data.toEntity()).toList());
  }

  @override
  Future<Either<Failure, List<TvSeries>>> searchTv(String q) async {
    try {
      final result = await remoteDataSource.searchTvSeries(q);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure(failedConnect));
    }
  }
}