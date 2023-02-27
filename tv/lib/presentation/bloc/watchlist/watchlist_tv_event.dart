part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTVEvent extends Equatable {
  const WatchlistTVEvent();

  @override
  List<Object> get props => [];
}

class FetchTVWatchlist extends WatchlistTVEvent {}
