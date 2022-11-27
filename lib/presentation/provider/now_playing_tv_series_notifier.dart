import 'package:inti/inti.dart';

import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv_series_usecase.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series_usecase.dart';
import 'package:flutter/foundation.dart';

class NowPlayingTvSeriesNotifier extends ChangeNotifier {
  final GetNowPlayingTvUseCase getNowPlayingTv;

  NowPlayingTvSeriesNotifier({required this.getNowPlayingTv});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvSeries> _tvSeries = [];
  List<TvSeries> get tvSeries => _tvSeries;

  String _message = '';
  String get message => _message;

  Future<void> fetchNowPlayingTvSeries() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingTv.execute();

    result.fold(
          (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
          (tvSeriesData) {
        _tvSeries = tvSeriesData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}