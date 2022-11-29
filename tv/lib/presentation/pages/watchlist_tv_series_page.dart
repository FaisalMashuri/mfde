import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inti/inti.dart';
import "package:tv/tv.dart";
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-tv';

  @override
  _WatchlistTvSeriesPageState createState() => _WatchlistTvSeriesPageState();
}

class _WatchlistTvSeriesPageState extends State<WatchlistTvSeriesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<TvWatchlistBloc>().add(OnWatchlistTv()),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<TvWatchlistBloc>().add(OnWatchlistTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist Tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvWatchlistBloc, TvState>(
          builder: (context, state) {
            if (state is TvLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvHasData) {
              if (state.result.isEmpty) {
                return const Center(
                  child: Text('No Watchlist Added'),
                );
              } else {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final movie = state.result[index];
                    return TvSeriesCard(movie);
                  },
                  itemCount: state.result.length,
                );
              }
            } else if (state is TvError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: Text('Failed to load data'),
              );
            }
          },
        ),
      ),
    );
  }
}
