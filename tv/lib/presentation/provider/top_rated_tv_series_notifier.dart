import 'package:inti/inti.dart';
import "package:tv/tv.dart";
import 'package:flutter/foundation.dart';

class AllTopTvNotifier extends ChangeNotifier {
  final GetTopTvUseCase getTopTvUseCase;

  AllTopTvNotifier({required this.getTopTvUseCase});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvSeries> _tvSeries = [];
  List<TvSeries> get tvSeries => _tvSeries;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedTvSeries() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTopTvUseCase.execute();

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