import 'package:inti/inti.dart';

import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_detail_tv_series_usecase.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendation_usecase.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_tv_series_usecase.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv_series_usecase.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv_series_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TvDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvDetailUseCase getTvDetailUseCase;
  final GetTvSeriesRecommendationsUseCase getTvSeriesRecommendationsUseCase;
  final GetWatchListStatusTvUseCase getWatchListStatusTvUseCase;
  final SaveWatchlistTvUseCase saveWatchlistUseCase;
  final RemoveWatchlistTvUseCase removeWatchlistTvUseCase;

  TvDetailNotifier({
    required this.getTvDetailUseCase,
    required this.getTvSeriesRecommendationsUseCase,
    required this.getWatchListStatusTvUseCase,
    required this.saveWatchlistUseCase,
    required this.removeWatchlistTvUseCase,
  });

  late TvDetail _tvDetail;
  TvDetail get tvDetail => _tvDetail;

  RequestState _tvSeriesState = RequestState.Empty;
  RequestState get tvSeriesState => _tvSeriesState;

  List<TvSeries> _tvSeriesRecommendations = [];
  List<TvSeries> get tvSeriesRecommendations => _tvSeriesRecommendations;

  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  Future<void> fetchTvSeriesDetail(int id) async {
    _tvSeriesState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getTvDetailUseCase.execute(id);
    final recommendationResult =
        await getTvSeriesRecommendationsUseCase.execute(id);
    detailResult.fold(
      (failure) {
        _tvSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeries) {
        _recommendationState = RequestState.Loading;
        _tvDetail = tvSeries;
        notifyListeners();
        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.Error;
            _message = failure.message;
          },
          (tvSeries) {
            _recommendationState = RequestState.Loaded;
            _tvSeriesRecommendations = tvSeries;
          },
        );
        _tvSeriesState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlist(TvDetail tvSeries) async {
    final result = await saveWatchlistUseCase.execute(tvSeries);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tvSeries.id);
  }

  Future<void> removeFromWatchlist(TvDetail tvSeries) async {
    final result = await removeWatchlistTvUseCase.execute(tvSeries);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tvSeries.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatusTvUseCase.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}
