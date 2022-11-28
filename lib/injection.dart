import 'package:movie/movie.dart';
import 'package:inti/inti.dart';
import 'package:tv/tv.dart';
import 'package:search/search.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(
    () => SearchMovieBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => SearchTvBloc(
      locator(),
    ),
  );
  // provider
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesListNotifier(
      getNowPlayingTvUseCase: locator(),
      getPopularTvUseCase: locator(),
      getTopTvUseCase: locator(),
    ),
  );
  locator.registerFactory(
    () => TvDetailNotifier(
      getTvDetailUseCase: locator(),
      getTvSeriesRecommendationsUseCase: locator(),
      getWatchListStatusTvUseCase: locator(),
      saveWatchlistUseCase: locator(),
      removeWatchlistTvUseCase: locator(),
    ),
  );
  locator.registerFactory(
    () => AllTopTvNotifier(
      getTopTvUseCase: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvSeriesNotifier(
      getPopularTvUseCase: locator(),
    ),
  );
  
  locator.registerFactory(
    () => WatchlistTvSeriesNotifier(
      getWatchlistTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => NowPlayingTvSeriesNotifier(
      getNowPlayingTv: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetNowPlayingTvUseCase(locator()));
  locator.registerLazySingleton(() => SearchTvUseCase(locator()));
  locator.registerLazySingleton(() => GetPopularTvUseCase(locator()));
  locator.registerLazySingleton(() => GetTopTvUseCase(locator()));
  locator.registerLazySingleton(() => GetTvDetailUseCase(locator()));
  locator.registerLazySingleton(
      () => GetTvSeriesRecommendationsUseCase(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTvUseCase(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTvUseCase(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvUseCase(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTvUseCase(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvSeriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(databaseHelper: locator()));

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
