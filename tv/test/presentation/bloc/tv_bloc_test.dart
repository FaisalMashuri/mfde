import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:inti/inti.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import '../../dummy_data/dummy_objects.dart';
import 'package:tv/tv.dart';
import 'tv_bloc_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingTvUseCase,
  GetPopularTvUseCase,
  GetTopRatedMovies,
  GetTopTvUseCase,
  GetTvDetailUseCase,
  GetTvSeriesRecommendationsUseCase,
  GetWatchlistTvUseCase,
  GetWatchListStatusTvUseCase,
  SaveWatchlistTvUseCase,
  RemoveWatchlistTvUseCase
])
void main() {
  const tId =1;
  late NowPlayingTvSeriesBloc onTheAirTvBloc;
  late MockGetNowPlayingTvUseCase mockGetOnTheAirTv;

  late PopularTvBloc popularTvBloc;
  late MockGetPopularTvUseCase mockGetPopularTv;

  late TopRatedTvBloc topRatedTvBloc;
  late MockGetTopTvUseCase mockGetTopRatedTv;

  late TvDetailBloc tvDetailBloc;
  late MockGetTvDetailUseCase mockGetTvDetail;

  late TvRecommendationsBloc tvRecommendationsBloc;
  late MockGetTvSeriesRecommendationsUseCase mockGetTvRecommendations;

  late TvWatchlistBloc tvWatchlistBloc;
  late MockGetWatchListStatusTvUseCase mockGetWatchlistStatus;
  late MockGetWatchlistTvUseCase mockGetWatchlistTv;
  late MockSaveWatchlistTvUseCase mockSaveWatchlist;
  late MockRemoveWatchlistTvUseCase mockRemoveWatchlist;

  setUp(
    () {
      mockGetOnTheAirTv = MockGetNowPlayingTvUseCase();
      onTheAirTvBloc = NowPlayingTvSeriesBloc(mockGetOnTheAirTv);
      mockGetPopularTv = MockGetPopularTvUseCase();
      popularTvBloc = PopularTvBloc(mockGetPopularTv);
      mockGetTopRatedTv = MockGetTopTvUseCase();
      topRatedTvBloc = TopRatedTvBloc(mockGetTopRatedTv);
      mockGetTvDetail = MockGetTvDetailUseCase();
      tvDetailBloc = TvDetailBloc(mockGetTvDetail);
      mockGetTvRecommendations = MockGetTvSeriesRecommendationsUseCase();
      tvRecommendationsBloc = TvRecommendationsBloc(mockGetTvRecommendations);
      mockGetWatchlistStatus = MockGetWatchListStatusTvUseCase();
      mockGetWatchlistTv = MockGetWatchlistTvUseCase();
      mockSaveWatchlist = MockSaveWatchlistTvUseCase();
      mockRemoveWatchlist = MockRemoveWatchlistTvUseCase();
      tvWatchlistBloc = TvWatchlistBloc(
        mockGetWatchlistStatus,
        mockGetWatchlistTv,
        mockSaveWatchlist,
        mockRemoveWatchlist,
      );
    },
  );

  group('on the air tv', () {
    test('initial state should be empty', () {
      expect(onTheAirTvBloc.state, TvEmpty());
    });

    blocTest<NowPlayingTvSeriesBloc, TvState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetOnTheAirTv.execute())
            .thenAnswer((_) async => Right(testTVList));
        return onTheAirTvBloc;
      },
      act: (bloc) => bloc.add(NowPlayingTv()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TvLoading(),
        TvHasData(testTVList),
      ],
      verify: (bloc) {
        verify(mockGetOnTheAirTv.execute());
      },
    );

    blocTest<NowPlayingTvSeriesBloc, TvState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetOnTheAirTv.execute()).thenAnswer(
            (_) async =>  Left(ServerFailure('Server Failure')));
        return onTheAirTvBloc;
      },
      act: (bloc) => bloc.add(NowPlayingTv()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TvLoading(),
        const TvError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetOnTheAirTv.execute());
      },
    );
  });

  group('popular tv', () {
    test('initial state should be empty', () {
      expect(popularTvBloc.state, TvEmpty());
    });

    blocTest<PopularTvBloc, TvState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetPopularTv.execute())
            .thenAnswer((_) async => Right(testTVList));
        return popularTvBloc;
      },
      act: (bloc) => bloc.add(OnPopularTv()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TvLoading(),
        TvHasData(testTVList),
      ],
      verify: (bloc) {
        verify(mockGetPopularTv.execute());
      },
    );

    blocTest<PopularTvBloc, TvState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetPopularTv.execute()).thenAnswer(
            (_) async => Left(ServerFailure('Server Failure')));
        return popularTvBloc;
      },
      act: (bloc) => bloc.add(OnPopularTv()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TvLoading(),
        const TvError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetPopularTv.execute());
      },
    );
  });

  group('top rated tv', () {
    test('initial state should be empty', () {
      expect(topRatedTvBloc.state, TvEmpty());
    });

    blocTest<TopRatedTvBloc, TvState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedTv.execute())
            .thenAnswer((_) async => Right(testTVList));
        return topRatedTvBloc;
      },
      act: (bloc) => bloc.add(OnTopRatedTv()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TvLoading(),
        TvHasData(testTVList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTv.execute());
      },
    );

    blocTest<TopRatedTvBloc, TvState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetTopRatedTv.execute()).thenAnswer(
            (_) async =>  Left(ServerFailure('Server Failure')));
        return topRatedTvBloc;
      },
      act: (bloc) => bloc.add(OnTopRatedTv()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TvLoading(),
        const TvError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTv.execute());
      },
    );
  });

  group('tv detail', () {
    test('initial state should be empty', () {
      expect(tvDetailBloc.state, TvEmpty());
    });

    blocTest<TvDetailBloc, TvState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTvDetail.execute(tId))
            .thenAnswer((_) async =>  Right(testTVDetail));
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(const OnTvDetail(tId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TvLoading(),
         TvDetailHasData(testTVDetail),
      ],
      verify: (bloc) {
        verify(mockGetTvDetail.execute(tId));
      },
    );

    blocTest<TvDetailBloc, TvState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetTvDetail.execute(tId)).thenAnswer(
            (_) async =>  Left(ServerFailure('Server Failure')));
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(const OnTvDetail(tId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TvLoading(),
        const TvError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTvDetail.execute(tId));
      },
    );
  });

  group('tv recommendations', () {
    test('initial state should be empty', () {
      expect(tvRecommendationsBloc.state, TvEmpty());
    });

    blocTest<TvRecommendationsBloc, TvState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTvRecommendations.execute(tId))
            .thenAnswer((_) async => Right(testTVList));
        return tvRecommendationsBloc;
      },
      act: (bloc) => bloc.add(const OnTvRecommendations(tId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TvLoading(),
        TvHasData(testTVList),
      ],
      verify: (bloc) {
        verify(mockGetTvRecommendations.execute(tId));
      },
    );

    blocTest<TvRecommendationsBloc, TvState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetTvRecommendations.execute(tId)).thenAnswer(
            (_) async =>  Left(ServerFailure('Server Failure')));
        return tvRecommendationsBloc;
      },
      act: (bloc) => bloc.add(const OnTvRecommendations(tId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TvLoading(),
        const TvError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTvRecommendations.execute(tId));
      },
    );
  });

  group('tv watchlist', () {
    test('initial state should be empty', () {
      expect(tvWatchlistBloc.state, TvEmpty());
    });

    group('tv watchlist status', () {
      blocTest<TvWatchlistBloc, TvState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetWatchlistStatus.execute(tId))
              .thenAnswer((_) async => true);
          return tvWatchlistBloc;
        },
        act: (bloc) => bloc.add(const OnTvWatchlistStatus(tId)),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          TvLoading(),
          const TvWatchlistStatus(true),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistStatus.execute(tId));
        },
      );
    });

    group('watchlist tv', () {
      blocTest<TvWatchlistBloc, TvState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetWatchlistTv.execute())
              .thenAnswer((_) async => Right(testTVList));
          return tvWatchlistBloc;
        },
        act: (bloc) => bloc.add(OnWatchlistTv()),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          TvLoading(),
          TvHasData(testTVList),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistTv.execute());
        },
      );

      blocTest<TvWatchlistBloc, TvState>(
        'Should emit [Loading, Error] when get search is unsuccessful',
        build: () {
          when(mockGetWatchlistTv.execute()).thenAnswer(
              (_) async =>  Left(ServerFailure('Server Failure')));
          return tvWatchlistBloc;
        },
        act: (bloc) => bloc.add(OnWatchlistTv()),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          TvLoading(),
          const TvError('Server Failure'),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistTv.execute());
        },
      );
    });

    group('add tv to watchlist', () {
      const tWatchlistAddSuccessMessage =
          TvWatchlistBloc.watchlistAddSuccessMessage;

      blocTest<TvWatchlistBloc, TvState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockSaveWatchlist.execute(testTVDetail)).thenAnswer(
              (_) async => const Right(tWatchlistAddSuccessMessage));
          return tvWatchlistBloc;
        },
        act: (bloc) => bloc.add( OnAddTvToWatchlist(testTVDetail)),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          TvLoading(),
          const TvWatchlistMessage(tWatchlistAddSuccessMessage),
        ],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(testTVDetail));
        },
      );

      blocTest<TvWatchlistBloc, TvState>(
        'Should emit [Loading, Error] when get search is unsuccessful',
        build: () {
          when(mockSaveWatchlist.execute(testTVDetail)).thenAnswer(
              (_) async =>  Left(ServerFailure('Server Failure')));
          return tvWatchlistBloc;
        },
        act: (bloc) => bloc.add( OnAddTvToWatchlist(testTVDetail)),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          TvLoading(),
          const TvError('Server Failure'),
        ],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(testTVDetail));
        },
      );
    });

    group('remove tv from watchlist', () {
      const tWatchlistRemoveSuccessMessage =
          TvWatchlistBloc.watchlistRemoveSuccessMessage;

      blocTest<TvWatchlistBloc, TvState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockRemoveWatchlist.execute(testTVDetail)).thenAnswer(
              (_) async => const Right(tWatchlistRemoveSuccessMessage));
          return tvWatchlistBloc;
        },
        act: (bloc) => bloc.add( OnRemoveTvFromWatchlist(testTVDetail)),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          TvLoading(),
          const TvWatchlistMessage(tWatchlistRemoveSuccessMessage),
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlist.execute(testTVDetail));
        },
      );

      blocTest<TvWatchlistBloc, TvState>(
        'Should emit [Loading, Error] when get search is unsuccessful',
        build: () {
          when(mockRemoveWatchlist.execute(testTVDetail)).thenAnswer(
              (_) async =>  Left( ServerFailure('Server Failure')));
          return tvWatchlistBloc;
        },
        act: (bloc) => bloc.add( OnRemoveTvFromWatchlist(testTVDetail)),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          TvLoading(),
          const TvError('Server Failure'),
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlist.execute(testTVDetail));
        },
      );
    });
  });
}
