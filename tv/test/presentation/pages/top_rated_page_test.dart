import 'package:tv/presentation/bloc/tv_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/pages/top_rated_tv_series.dart';
import 'package:tv/presentation/widgets/tv_series_card_list.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/bloc_test_helper.dart';

void main() {
  late MockTopRatedTvBloc mockTopRatedTvBloc;

  setUp(() {
    mockTopRatedTvBloc = MockTopRatedTvBloc();
    registerFallbackValue(TvFakeEvent());
    registerFallbackValue(TvFakeState());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvBloc>.value(
      value: mockTopRatedTvBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTopRatedTvBloc.state).thenReturn(TvLoading());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget( TopRatedTvSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTopRatedTvBloc.state).thenReturn(TvHasData(testTVList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget( TopRatedTvSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display TvCard when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTopRatedTvBloc.state).thenReturn(TvHasData(testTVList));

    final tvCardFinder = find.byType(TvSeriesCard);

    await tester.pumpWidget(_makeTestableWidget( TopRatedTvSeriesPage()));

    expect(tvCardFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockTopRatedTvBloc.state)
        .thenReturn(const TvError('Something went wrong'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget( TopRatedTvSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}