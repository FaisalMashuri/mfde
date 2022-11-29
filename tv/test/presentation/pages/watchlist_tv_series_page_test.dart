import 'package:tv/presentation/bloc/tv_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/pages/watchlist_tv_series_page.dart';
import 'package:tv/presentation/widgets/tv_series_card_list.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/bloc_test_helper.dart';

void main() {
  late MockTvWatchlistBloc mockTvWatchlistBloc;

  setUp(() {
    mockTvWatchlistBloc = MockTvWatchlistBloc();
    registerFallbackValue(TvFakeEvent());
    registerFallbackValue(TvFakeState());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvWatchlistBloc>.value(
      value: mockTvWatchlistBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTvWatchlistBloc.state).thenReturn(TvLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget( WatchlistTvSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTvWatchlistBloc.state).thenReturn(TvLoading());
    when(() => mockTvWatchlistBloc.state).thenReturn(TvHasData(testTVList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(WatchlistTvSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display TvCard when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTvWatchlistBloc.state).thenReturn(TvHasData(testTVList));

    final tvCardFinder = find.byType(TvSeriesCard);

    await tester.pumpWidget(_makeTestableWidget(WatchlistTvSeriesPage()));

    expect(tvCardFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockTvWatchlistBloc.state).thenReturn(const TvError('Error'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(WatchlistTvSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}