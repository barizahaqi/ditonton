import 'package:core/utils/utils.dart';
import 'package:tv/presentation/bloc/watchlist/watchlist_tv_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistTVPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-tv';

  @override
  _WatchlistTVPageState createState() => _WatchlistTVPageState();
}

class _WatchlistTVPageState extends State<WatchlistTVPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TVWatchlistBloc>().add(FetchTVWatchlist());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<TVWatchlistBloc>().add(FetchTVWatchlist());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TVWatchlistBloc, WatchlistTVState>(
            builder: (context, state) {
          if (state is WatchlistTVLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WatchlistTVHasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final tv = state.watchlistResult[index];
                return TVCard(tv);
              },
              itemCount: state.watchlistResult.length,
            );
          } else if (state is WatchlistTVError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Container();
          }
        }),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
