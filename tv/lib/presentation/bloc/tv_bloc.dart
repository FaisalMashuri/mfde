import 'package:tv/tv.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tv_event.dart';
part 'tv_state.dart';

class NowPlayingTvSeriesBloc extends Bloc<TvEvent, TvState> {
  final GetNowPlayingTvUseCase _getOnTheAirTv;

  NowPlayingTvSeriesBloc(this._getOnTheAirTv) : super(TvEmpty()) {
    on<NowPlayingTv>((event, emit) async {
      emit(TvLoading());
      final result = await _getOnTheAirTv.execute();

      result.fold(
        (failure) {
          emit(TvError(failure.message));
        },
        (data) {
          emit(TvHasData(data));
        },
      );
    });
  }
}

class PopularTvBloc extends Bloc<TvEvent, TvState> {
  final GetPopularTvUseCase _getPopularTv;

  PopularTvBloc(this._getPopularTv) : super(TvEmpty()) {
    on<OnPopularTv>((event, emit) async {
      emit(TvLoading());
      final result = await _getPopularTv.execute();

      result.fold(
        (failure) {
          emit(TvError(failure.message));
        },
        (data) {
          emit(TvHasData(data));
        },
      );
    });
  }
}

class TopRatedTvBloc extends Bloc<TvEvent, TvState> {
  final GetTopTvUseCase _getTopRatedTv;

  TopRatedTvBloc(this._getTopRatedTv) : super(TvEmpty()) {
    on<OnTopRatedTv>((event, emit) async {
      emit(TvLoading());
      final result = await _getTopRatedTv.execute();

      result.fold(
        (failure) {
          emit(TvError(failure.message));
        },
        (data) {
          emit(TvHasData(data));
        },
      );
    });
  }
}

class TvDetailBloc extends Bloc<TvEvent, TvState> {
  final GetTvDetailUseCase _getTvDetail;

  TvDetailBloc(this._getTvDetail) : super(TvEmpty()) {
    on<OnTvDetail>((event, emit) async {
      emit(TvLoading());
      final result = await _getTvDetail.execute(event.id);

      result.fold(
        (failure) {
          emit(TvError(failure.message));
        },
        (data) {
          emit(TvDetailHasData(data));
        },
      );
    });
  }
}


class TvRecommendationsBloc extends Bloc<TvEvent, TvState> {
  final GetTvSeriesRecommendationsUseCase _getTvRecommendations;

  TvRecommendationsBloc(this._getTvRecommendations) : super(TvEmpty()) {
    on<OnTvRecommendations>((event, emit) async {
      emit(TvLoading());
      final result = await _getTvRecommendations.execute(event.id);

      result.fold(
        (failure) {
          emit(TvError(failure.message));
        },
        (data) {
          emit(TvHasData(data));
        },
      );
    });
  }
}

class TvWatchlistBloc extends Bloc<TvEvent, TvState> {
  final GetWatchListStatusTvUseCase _getWatchlistStatus;
  final GetWatchlistTvUseCase _getWatchlistTv;
  final SaveWatchlistTvUseCase _saveWatchlist;
  final RemoveWatchlistTvUseCase _removeWatchlist;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  TvWatchlistBloc(
    this._getWatchlistStatus,
    this._getWatchlistTv,
    this._saveWatchlist,
    this._removeWatchlist,
  ) : super(TvEmpty()) {
    on<OnTvWatchlistStatus>((event, emit) async {
      emit(TvLoading());
      final result = await _getWatchlistStatus.execute(event.id);

      emit(TvWatchlistStatus(result));
    });

    on<OnWatchlistTv>((event, emit) async {
      emit(TvLoading());
      final result = await _getWatchlistTv.execute();

      result.fold(
        (failure) {
          emit(TvError(failure.message));
        },
        (data) {
          emit(TvHasData(data));
        },
      );
    });

    on<OnAddTvToWatchlist>((event, emit) async {
      emit(TvLoading());
      final result = await _saveWatchlist.execute(event.tv);

      result.fold(
        (failure) {
          emit(TvError(failure.message));
        },
        (data) {
          emit(const TvWatchlistMessage(watchlistAddSuccessMessage));
        },
      );
    });

    on<OnRemoveTvFromWatchlist>((event, emit) async {
      emit(TvLoading());
      final result = await _removeWatchlist.execute(event.tv);

      result.fold(
        (failure) {
          emit(TvError(failure.message));
        },
        (data) {
          emit(const TvWatchlistMessage(watchlistRemoveSuccessMessage));
        },
      );
    });
  }
}